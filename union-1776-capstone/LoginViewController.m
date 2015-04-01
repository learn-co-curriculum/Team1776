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
@end

@implementation LoginViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setUpOurInitialView];
    
    [self requestTheDefaulLoginScreen];
    
    NSLog(@"The value for the person logging in is : %@", [KeychainHelper returnValueIDForCurrentUser]);

}

- (void)dataFromAppDelegate:(NSDictionary *)user1776Info {
    self.user1776 = user1776Info;
}

- (void)requestTheDefaulLoginScreen {
    
    NSString *defaultLoginURLString;
    if (self.user1776) {
        defaultLoginURLString = [NSString stringWithFormat:@"something"];
    } else {
        defaultLoginURLString = [NSString stringWithFormat:@"%@", DEFAULT_LOGIN_SCREEN_OR_FEED];
    }
    NSURL *loginURL = [NSURL URLWithString:defaultLoginURLString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:loginURL];
    [self.webView loadRequest:urlRequest];
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
            
            self.cookieValueSecure = cookie.value;
        }
    }
    
    [KeychainHelper setUpCurrentUserInKeyChainWithValueID:self.cookieValue];
    
}

- (void)setUpOurInitialView {
    
    CGFloat heightOfIphone =[[UIScreen mainScreen] bounds].size.height;
    CGFloat widthOfIphone = [[UIScreen mainScreen] bounds].size.width;
    CGRect rectOfWebView = CGRectMake(0.0, 17.0, widthOfIphone, heightOfIphone-17.0);
    self.webView = [[UIWebView alloc] initWithFrame:rectOfWebView];
    [self.view addSubview:self.webView];
    self.webView.delegate = self;
}


- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

@end