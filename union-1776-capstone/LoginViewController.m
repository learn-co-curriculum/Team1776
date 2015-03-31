//
//  ViewController.m
//  TestingCookieStorage
//
//  Created by Jim Campagno on 3/30/15.
//  Copyright (c) 2015 Gamesmith, LLC. All rights reserved.
//

#import "LoginViewController.h"


@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    
    self.webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:self.webView];
    self.webView.delegate = self;
    
    BOOL jim = YES;
    
    
    
    
    
    if (jim) {
        
        
        NSLog (@"is this running");
        
        NSString *testURL = [NSString stringWithFormat:@"http://dev.1776union.io/union/feed/get?type=default"];
        
        NSURL *urlToUse = [NSURL URLWithString:testURL];
        
        NSURLRequest *requestToUse = [NSURLRequest requestWithURL:urlToUse];
        
        [self.webView loadRequest:requestToUse];
        
    }
    else {
        
        NSLog (@"TEST");
        
        self.loginURL = [NSString stringWithFormat:@"http://dev.1776union.io/union/user/loginOptions"];
        
        NSURL *url = [NSURL URLWithString:self.loginURL];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        [self.webView loadRequest:request];
        
    }
    
    //
    //    WKWebViewConfiguration *theConfiguration = [[WKWebViewConfiguration alloc] init];
    //    WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:theConfiguration];
    //    self.webView.navigationDelegate = self;
    //    NSURL *nsurl=[NSURL URLWithString:@"http://dev.1776union.io/union/user/loginOptions"];
    //    NSURLRequest *nsrequest=[NSURLRequest requestWithURL:nsurl];
    //    [webView loadRequest:nsrequest];
    //    [self.view addSubview:webView];
    
    
    
}


- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    
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
