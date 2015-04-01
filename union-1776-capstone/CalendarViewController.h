//
//  CalendarViewController.h
//  union-1776-capstone
//
//  Created by Bert Carr on 4/1/15.
//  Copyright (c) 2015 Flatiron School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface CalendarViewController : UIViewController <WKUIDelegate, WKNavigationDelegate>

@property (strong, nonatomic) WKWebView *webView;

@end
