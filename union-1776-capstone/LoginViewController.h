//
//  ViewController.h
//  TestingCookieStorage
//
//  Created by Jim Campagno on 3/30/15.
//  Copyright (c) 2015 Gamesmith, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import <SSKeychain.h>
#import <SSKeychainQuery.h>

@interface LoginViewController : UIViewController <UIWebViewDelegate, WKNavigationDelegate>

@property (strong, nonatomic) NSString *loginURL;
@property (strong, nonatomic) NSString *cookieValue;
@property (strong, nonatomic) NSString *cookieValueSecure;

@property (strong, nonatomic) UIWebView *webView;

@end

