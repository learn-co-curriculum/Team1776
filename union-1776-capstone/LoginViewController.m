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
    NSLog(@"viewdidLoadWasCalled");

//    self.appDelegate.delegate = self;
    
    self.UIBack.enabled = NO;
    [self.UIBack setTintColor:[UIColor clearColor]];
    
    [self setUpOurInitialView];
    
  
    
    [self requestTheDefaulLoginScreen];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushNotificationReceived) name:@"pushNotification" object:nil];
    
    if ([self isLoggedIn]) {
        [self unHideTheTabBar];
    } else
    {
        [self hideTheTabBar];
    }
    
}

//- (void)viewDidAppear:(BOOL)animated {
//    if ([UnionDataStore sharedDataStore].notificationDictionary) {
//        [APIClient loadTheFeedWithNotification:[UnionDataStore sharedDataStore].notificationDictionary withWebView:self.webView];
//        NSLog(@"it's loading the url from viewdidappear");
//        
//    }
//}

- (void) pushNotificationReceived {
    [APIClient loadTheFeedWithNotification:[UnionDataStore sharedDataStore].notificationDictionary withWebView:self.webView];
//    NSString *message = [NSString stringWithFormat:@"The dictionary is... %@", [UnionDataStore sharedDataStore].notificationDictionary];
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"YO!" message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alert show];
    
 
}

- (void)requestTheDefaulLoginScreen {
    
    [APIClient loadTheInitialFeedOrLoginScreenWithWebView:self.webView];
}

#pragma mark - UIWebViewDelegate Methods

-(void)webViewDidStartLoad:(UIWebView *)webView {
    
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
//        [ParseAPIClient saveUserIDtoParse];
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

- (IBAction)backTapped:(id)sender
{
    if ([self.webView canGoBack])
    {
        [self.webView goBack];
    }
}

#pragma mark - Helper Methods

-(void)reloadWebView
{
    if ( [self onMainPage:self.webView.request.URL] )
    {
        NSString *script = @"$('html, body').animate({scrollTop:0}, 'fast')";
        [self.webView stringByEvaluatingJavaScriptFromString:script];
    }
    else
    {
        [self requestTheDefaulLoginScreen];
    }
    
}

- (BOOL) onMainPage:(NSURL *)currentURL
{
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


- (void) toggleBackButtonToState:(BOOL)state
{
    
    if (state)
    {
        self.UIBack.enabled = YES;
        [self.UIBack setTintColor:[UIColor blueColor]];
        
    } else
    {
        self.UIBack.enabled = NO;
        [self.UIBack setTintColor:[UIColor clearColor]];
    }
    
}

- (void)hideTheTabBar {
    
    self.hidesBottomBarWhenPushed = NO;
    
//    [self setHideTabBar:YES animated:YES];
    
    [self.tabBarController.tabBar setTranslucent:YES];
    [self.tabBarController.tabBar setHidden:YES];
//    [self hideTabBar:self.tabBarController];
    
}

- (void)unHideTheTabBar {
    
//    [self setHideTabBar:NO animated:YES];
    
    
    [self.tabBarController.tabBar setTranslucent:NO];
    [self.tabBarController.tabBar setHidden:NO];
    
//    [self showTabBar:self.tabBarController];
    
}

- (BOOL) isLoggedIn
{
    return self.cookieValue != nil;
}

- (void) hideTabBar:(UITabBarController *) tabbarcontroller
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    float fHeight = screenRect.size.height;
    if(  UIDeviceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation) )
    {
        fHeight = screenRect.size.width;
    }
    
    for(UIView *view in tabbarcontroller.view.subviews)
    {
        if([view isKindOfClass:[UITabBar class]])
        {
            [view setFrame:CGRectMake(view.frame.origin.x, fHeight, view.frame.size.width, view.frame.size.height)];
        }
        else
        {
            [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, fHeight)];
            view.backgroundColor = [UIColor blackColor];
        }
    }
    [UIView commitAnimations];
}



- (void) showTabBar:(UITabBarController *) tabbarcontroller
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    float fHeight = screenRect.size.height - tabbarcontroller.tabBar.frame.size.height;
    
    if(  UIDeviceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation) )
    {
        fHeight = screenRect.size.width - tabbarcontroller.tabBar.frame.size.height;
    }
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    for(UIView *view in tabbarcontroller.view.subviews)
    {
        if([view isKindOfClass:[UITabBar class]])
        {
            [view setFrame:CGRectMake(view.frame.origin.x, fHeight, view.frame.size.width, view.frame.size.height)];
        }
        else
        {
            [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, fHeight)];
        }
    }
    [UIView commitAnimations];
}

- (void)setHideTabBar:(BOOL)hide animated:(BOOL)animated {
    UIViewController *selectedViewController = self.tabBarController;
    if ([selectedViewController isKindOfClass:[UINavigationController class]])
        selectedViewController = ((UINavigationController *)selectedViewController).visibleViewController;
    __weak __typeof(self) weakSelf = self;
    
    void (^animations)(void) = ^{
        selectedViewController.edgesForExtendedLayout = UIRectEdgeAll;
        [selectedViewController setExtendedLayoutIncludesOpaqueBars:hide];
        weakSelf.navigationController.tabBarController.tabBar.hidden = hide;
        [selectedViewController.navigationController.view layoutSubviews];
    };
    
    [UIView animateWithDuration:animated ? UINavigationControllerHideShowBarDuration : 1 animations:animations];
}




@end