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
#import "KeychainHelper.h"

@interface LoginViewController : UIViewController <UIWebViewDelegate>

@property (strong, nonatomic) NSString *cookieValue;
@property (strong, nonatomic) NSString *cookieValueSecure;

@end

