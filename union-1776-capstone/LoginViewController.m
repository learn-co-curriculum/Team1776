//
//  ViewController.m
//  TestingCookieStorage
//
//  Created by Jim Campagno on 3/30/15.
//  Copyright (c) 2015 Gamesmith, LLC. All rights reserved.
//

#import "LoginViewController.h"
#import "Constants.h"
#import <UIKit/UIKit.h>

@interface LoginViewController ()
@property (strong, nonatomic) UIWebView *webView;
@property (strong, nonatomic) NSDictionary *user1776;
@property (strong, nonatomic) NSString *cookieValue;
@property (strong, nonatomic) NSString *cookieValueSecure;

@property (nonatomic) NSInteger loads;
@property (nonatomic) BOOL firstTimeOver;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *UIBack;
- (IBAction)backTapped:(id)sender;

@end

@implementation LoginViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.firstTimeOver = NO;
    
    self.UIBack.enabled = NO;
    [self.UIBack setTintColor:[UIColor clearColor]];
    
    [self setUpOurInitialView];
    
    [self requestTheDefaulLoginScreen];
    
    NSLog(@"The value for the person logging in is : %@", [KeychainHelper returnValueIDForCurrentUser]);
    
}

- (void)dataFromAppDelegate:(NSDictionary *)user1776Info {
    
    self.user1776 = user1776Info;
}

- (void)requestTheDefaulLoginScreen {
    
    if (self.user1776) {
        
        [APIClient loadTheFeedWithNotification:self.user1776 withWebView:self.webView];
    }
    else {
        
        [APIClient loadTheInitialFeedOrLoginScreenWithWebView:self.webView];
    }
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    self.UIBack.enabled = self.webView.canGoBack;
    
    self.loads++;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    //To disable horizontal scrolling
    [webView.scrollView setContentSize: CGSizeMake(webView.frame.size.width, webView.scrollView.contentSize.height)];
    
    //To find the cookie needed to store the 1776dc_uid
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
    
    [KeychainHelper setUpCurrentUserInKeyChainWithValueID:self.cookieValue];
    
    NSString *currentURL = webView.request.URL.absoluteString;
    BOOL onMainPage = [currentURL isEqualToString:DEFAULT_LOGIN_SCREEN_OR_FEED] || [currentURL isEqualToString:[NSString stringWithFormat:@"%@%@",DEFAULT_LOGIN_SCREEN_OR_FEED,@"#"]];
    
    self.loads--;
    
    if (self.firstTimeOver)
    {
        if (webView.canGoBack == YES && !onMainPage)
        {
            self.UIBack.enabled = YES;
            [self.UIBack setTintColor:[UIColor blueColor]];
        }
        else
        {
            self.UIBack.enabled = NO;
            [self.UIBack setTintColor:[UIColor clearColor]];
        }
    }
    
    if (self.cookieValue && self.loads < 1 && !self.firstTimeOver)
    {
        self.firstTimeOver = YES;
    }
}

- (void)setUpOurInitialView {
    
    CGFloat heightOfIphone =[[UIScreen mainScreen] bounds].size.height;
    CGFloat widthOfIphone = [[UIScreen mainScreen] bounds].size.width;
    CGRect rectOfWebView = CGRectMake(0.0, 0.0, widthOfIphone, heightOfIphone);
    self.webView = [[UIWebView alloc] initWithFrame:rectOfWebView];
    [self.view addSubview:self.webView];
    self.webView.delegate = self;
}


- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

- (IBAction)backTapped:(id)sender
{
    if ([self.webView canGoBack])
    {
        [self.webView goBack];
    }
}
@end