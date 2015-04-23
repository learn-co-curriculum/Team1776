//
//  ViewController.m
//  TestingCookieStorage
//
//  Created by Jim Campagno on 3/30/15.
//  Copyright (c) 2015 Gamesmith, LLC. All rights reserved.
//

#import "LoginViewController.h"
#import "Constants.h"
#import "APIClient.h"
#import "ParseAPIClient.h"
#import <MBProgressHUD.h>
#import "UnionDataStore.h"

@interface LoginViewController ()

@property (strong, nonatomic) UIWebView *webView;
@property (strong, nonatomic) NSDictionary *user1776;
@property (strong, nonatomic) NSString *cookieValue;
@property (strong, nonatomic) NSString *cookieValueSecure;
@property (nonatomic) BOOL notificationReceived;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *UIBack;

- (void) requestTheDefaulLoginScreen;

- (void) setUpOurInitialView;
- (void) fetchCookieFromWebView;
- (void) storeCookie;
- (void) toggleBackButtonToState:(BOOL)state;
- (void) hideTheTabBar;
- (void) unHideTheTabBar;
- (BOOL) isLoggedIn;

- (IBAction)backTapped:(id)sender;

@end

@implementation LoginViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushNotificationReceived) name:@"pushNotification" object:nil];
    
    self.UIBack.enabled = NO;
    [self.UIBack setTintColor:[UIColor clearColor]];
    
    [self setUpOurInitialView];
    
    //This is here for when a notifcation is sent when the APP is not active (closed)
    if ([UnionDataStore sharedDataStore].notificationDictionary) {
        
        [self pushNotificationReceived];
        
    } else {
        
        [self requestTheDefaulLoginScreen];
    }
    
    
    if ([self isLoggedIn]) {
        
        [self unHideTheTabBar];
    } else {
        
        [self hideTheTabBar];
    }
}


- (void) pushNotificationReceived {
    
    [APIClient loadTheFeedWithNotification:[UnionDataStore sharedDataStore].notificationDictionary withWebView:self.webView];
}

- (void)requestTheDefaulLoginScreen {
    
    [APIClient loadTheInitialFeedOrLoginScreenWithWebView:self.webView];
}

#pragma mark - UIWebViewDelegate Methods

- (void)webViewDidStartLoad:(UIWebView *)webView {
    
    self.UIBack.enabled = self.webView.canGoBack;
    if ([self isLoggedIn]) {
        [ParseAPIClient saveUserIDtoParse];
        
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    [MBProgressHUD hideHUDForView:webView animated:YES];
    
    //To disable horizontal scrolling
    [webView.scrollView setContentSize: CGSizeMake(webView.frame.size.width, webView.scrollView.contentSize.height)];
    
    [self fetchCookieFromWebView];
    
    [self storeCookie];
    
    //To store the DeviceID and store it into keychain
    [KeychainHelper storeDeviceIDintoPhone:[[[UIDevice currentDevice] identifierForVendor] UUIDString]];
    
    if ([self isLoggedIn] ) {
        [self unHideTheTabBar];
    }
    
    [self toggleBackButtonToState:(webView.canGoBack && ![self onMainPage:webView.request.URL])];
    
}


#pragma mark - View Modifiers

- (void)setUpOurInitialView {
    
    CGFloat heightOfIphone =[[UIScreen mainScreen] bounds].size.height;
    CGFloat widthOfIphone = [[UIScreen mainScreen] bounds].size.width;
    CGRect rectOfWebView = CGRectMake(0.0, 0.0, widthOfIphone, heightOfIphone);
    self.webView = [[UIWebView alloc] initWithFrame:rectOfWebView];
    [self.view addSubview:self.webView];
    self.webView.delegate = self;
}

#pragma mark - Actions

- (IBAction)backTapped:(id)sender {
    if ([self.webView canGoBack])
    {
        [self.webView goBack];
    }
}

#pragma mark - Helper Methods

-(void)reloadWebView {
    
    if ( [self onMainPage:self.webView.request.URL] ) {
        NSString *script = @"$('html, body').animate({scrollTop:0}, 'fast')";
        [self.webView stringByEvaluatingJavaScriptFromString:script];
        
    } else {
        [self requestTheDefaulLoginScreen];
    }
    
}

- (BOOL)onMainPage:(NSURL *)currentURL {
    
    NSString *urlString = currentURL.absoluteString;
    
    return [urlString isEqualToString:DEFAULT_LOGIN_SCREEN_OR_FEED] ||
    [urlString isEqualToString:[NSString stringWithFormat:@"%@%@",DEFAULT_LOGIN_SCREEN_OR_FEED,@"#"]] ||
    [urlString isEqualToString:DEFAULT_LOGIN_SCREEN];
}

- (void)fetchCookieFromWebView {
    
    //To find the cookie needed to store the 1776dc_uid and 1776dc_uid_secure
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    
    for (cookie in [cookieJar cookies]) {
        
        if ([cookie.name isEqualToString:@"1776dc_uid"]) {
            self.cookieValue = cookie.value;
        }
        if ([cookie.name isEqualToString:@"1776dc_uid_secure"]) {
            //This is not being used
            self.cookieValueSecure = cookie.value;
        }
    }
}

- (void)storeCookie {
    //Store the valueID in keychain
    [KeychainHelper setUpCurrentUserInKeyChainWithValueID:self.cookieValue];
    
    //To store the secureID in keychain
    [KeychainHelper storeSecureIDintoPhone:self.cookieValueSecure];
}


- (void) toggleBackButtonToState:(BOOL)state {
    
    if (state) {
        self.UIBack.enabled = YES;
        [self.UIBack setTintColor:[UIColor blueColor]];
    } else {
        self.UIBack.enabled = NO;
        [self.UIBack setTintColor:[UIColor clearColor]];
    }
}

- (void)hideTheTabBar {
    
    self.hidesBottomBarWhenPushed = NO;
    
    [self.tabBarController.tabBar setTranslucent:YES];
    [self.tabBarController.tabBar setHidden:YES];
    
}

- (void)unHideTheTabBar {
    
    [self.tabBarController.tabBar setTranslucent:NO];
    [self.tabBarController.tabBar setHidden:NO];
    
}

- (BOOL) isLoggedIn
{
    return self.cookieValue != nil;
}

@end