//
//  APIClient.h
//  union-1776-capstone
//
//  Created by Jim Campagno on 4/2/15.
//  Copyright (c) 2015 Flatiron School. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"
#import <WebKit/WebKit.h>

@interface APIClient : NSObject

+ (void)loadTheInitialFeedOrLoginScreenWithWebView:(UIWebView *)webview;
+ (void)loadTheFeedWithNotification:(NSDictionary *)notification withWebView:(UIWebView *)webview;
+ (void)loadTheCalendarFeedWithWebView:(UIWebView *)webview;
+ (void)loadTheExplorerFeedWitHWebView:(UIWebView *)webview;

@end