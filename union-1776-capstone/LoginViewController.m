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

@end

@implementation LoginViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    CGFloat heightOfIphone =[[UIScreen mainScreen] bounds].size.height;
    CGFloat widthOfIphone = [[UIScreen mainScreen] bounds].size.width;
    
    NSLog (@"Height of iPhone is %f", heightOfIphone);
    NSLog (@"Width of iPhone is %f", widthOfIphone);
    
    CGRect rectOfWebView = CGRectMake(0.0, 17.0, widthOfIphone, heightOfIphone-17.0);
    
    self.webView = [[UIWebView alloc] initWithFrame:rectOfWebView];
    [self.view addSubview:self.webView];
    
    self.webView.delegate = self;
    
    [SSKeychain setPassword:@"3f7375a1-d70b-11e4-bf54-06867e4d05a8"
                 forService:@"Union"
                    account:@"CurrentUser"
                      error:nil];
    
    NSString *uniqueIdentifier = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    NSLog(@"This should be the uniqueIdentifier:%@", uniqueIdentifier);
    
    
    NSString *passwordForAccount = [SSKeychain passwordForService:@"Union" account:@"CurrentUser"];
    NSLog (@"This should be the password set in the keychain above: %@", passwordForAccount);
    
    NSString *testURL = [NSString stringWithFormat:@"%@", DEFAULT_LOGIN_SCREEN_OR_FEED];
    NSURL *urlToUse = [NSURL URLWithString:testURL];
    
    NSString *html = [NSString stringWithContentsOfURL:urlToUse encoding:[NSString defaultCStringEncoding] error:nil];
    
    
//    NSRange range = [html rangeOfString:@"<body"];
//    
//    
//#warning with iPhone 4S - make the inset 60!!!
//    if(range.location != NSNotFound) {
//        // Adjust style for mobile
//        float inset = 40;
//        NSString *style = [NSString stringWithFormat:@"<style>div {max-width: %fpx;}</style>", self.view.bounds.size.width - inset];
//        html = [NSString stringWithFormat:@"%@%@%@", [html substringToIndex:range.location], style, [html substringFromIndex:range.location]];
//    }
    
    [self.webView loadHTMLString:html baseURL:urlToUse];
    
//    
//    NSURLRequest *requestToUse = [NSURLRequest requestWithURL:urlToUse];
//    
//    [self.webView loadRequest:requestToUse];
    
    
    
 
//        WKWebViewConfiguration *theConfiguration = [[WKWebViewConfiguration alloc] init];
//        WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:theConfiguration];
//        self.webView.navigationDelegate = self;
//        NSURL *nsurl=[NSURL URLWithString:@"http://dev.1776union.io/union/user/loginOptions"];
//        NSURLRequest *nsrequest=[NSURLRequest requestWithURL:nsurl];
//        [webView loadRequest:nsrequest];
//        [self.view addSubview:webView];
    
    NSArray *keychainAccounts = [SSKeychain allAccounts];
    NSLog (@"THIS WOULD BE COOL: %@", keychainAccounts);
    
    
    
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    //This opens up any links clicked in safari
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        [[UIApplication sharedApplication] openURL:[request URL]];
        return NO;
    }
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    
    //To disable horizontal scrolling
    [webView.scrollView setContentSize: CGSizeMake(webView.frame.size.width, webView.scrollView.contentSize.height)];

    
    NSHTTPCookie *cookie;
    
    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    
    //    name:\"1776dc_uid\" value:\"3f7375a1-d70b-11e4-bf54-06867e4d05a8
    

    for (cookie in [cookieJar cookies]) {
        
        if ([cookie.name isEqualToString:@"1776dc_uid"]) {
            
            self.cookieValue = cookie.value;
        }
        
        if ([cookie.name isEqualToString:@"1776dc_uid_secure"]) {
            
            self.cookieValueSecure = cookie.value;
            
        }
    }
    
    NSLog(@"%@", cookieJar);
    
    NSLog (@"%@", self.cookieValue);
    NSLog (@"%@", self.cookieValueSecure);
    
    
    //
    //    "<NSHTTPCookie version:0 name:\"1776dc_uid\" value:\"3f7375a1-d70b-11e4-bf54-06867e4d05a8\" expiresDate:2015-04-06 21:42:43 +0000 created:2015-03-30 21:42:44 +0000 (4.49445e+08) sessionOnly:FALSE domain:\".1776union.io\" path:\"/\" isSecure:FALSE>",
    //
    //    "<NSHTTPCookie version:0 name:\"1776dc_uid_secure\" value:\"%2Fcj5RvV6nfF0hhg0gvDtKV79bwx400RnsDiBNb2E5qAmADia%2FYNIR9fqyLS%2F5QJXi6UKMf5FPlrc%0Ae%2BMOlWEVNweFdrLqY6%2BrQAxiZqfqc38%2F5O8PBJvtcw2MiEcibu29oRcYcbkEEGsB7zE%2Fs7ovv9F9%0AOnM8neTnDpxx5TRuctw%3D\" expiresDate:2015-04-06 21:42:43 +0000 created:2015-03-30 21:42:44 +0000 (4.49445e+08) sessionOnly:FALSE domain:\".1776union.io\" path:\"/\" isSecure:FALSE>",
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
