//
//  ViewController.h
//  TestingCookieStorage
//
//  Created by Jim Campagno on 3/30/15.
//  Copyright (c) 2015 Gamesmith, LLC. All rights reserved.
//

#import "AppDelegate.h"

@interface LoginViewController : UIViewController <UIWebViewDelegate, AppDelegateDelegate>
@property (strong, nonatomic) AppDelegate *appDelegate;
-(void)reloadWebView;

@end