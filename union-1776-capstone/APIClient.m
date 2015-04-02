//
//  APIClient.m
//  union-1776-capstone
//
//  Created by Jim Campagno on 4/2/15.
//  Copyright (c) 2015 Flatiron School. All rights reserved.
//

#import "APIClient.h"

@implementation APIClient

+ (void)loadTheInitialFeedOrLoginScreenWithWebView:(UIWebView *)webview {
    
    NSString *defaultLoginURLString = [NSString stringWithFormat:@"%@", DEFAULT_LOGIN_SCREEN_OR_FEED];
    NSURL *loginURL = [NSURL URLWithString:defaultLoginURLString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:loginURL];
    [webview loadRequest:urlRequest];
}

+ (void)loadTheFeedWithNotification:(NSDictionary *)notification withWebView:(UIWebView *)webview; {
    
    NSString *stringToUseIfTrue = [NSString stringWithFormat:@"http://dev.1776union.io/union/feed/get?type=%@&feedItemId=%@", notification[@"type"], notification[@"feedItemId"]];
    NSURL *loginURL = [NSURL URLWithString:stringToUseIfTrue];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:loginURL];
    [webview loadRequest:urlRequest];
}

+ (void)loadTheCalendarFeedWithWebView:(UIWebView *)webview {
    
    NSString *calendarURLString = [NSString stringWithFormat:@"%@", CALENDAR_FEED];
    NSURL *calendarURL = [NSURL URLWithString:calendarURLString];
    NSURLRequest *calendarRequest = [NSURLRequest requestWithURL:calendarURL];
    [webview loadRequest:calendarRequest];
}

+ (void)loadTheExplorerFeedWitHWebView:(UIWebView *)webview {
    
    NSString *exploreURLString = [NSString stringWithFormat:@"%@", EXPLORE_FEED];
    NSURL *exploreURL = [NSURL URLWithString:exploreURLString];
    NSURLRequest *exploreRequest = [NSURLRequest requestWithURL:exploreURL];
    [webview loadRequest:exploreRequest];
}

+ (void)loadTheProfilePageWithUserIDforWebView:(UIWebView *)webview {

    NSString *userID = [KeychainHelper returnValueIDForCurrentUser];
    NSString *profileURLString = [NSString stringWithFormat:@"http://dev.1776union.io/union/user/profile?userId=%@", userID];
    NSURL *profileURL = [NSURL URLWithString:profileURLString];
    NSURLRequest *profileRequest = [NSURLRequest requestWithURL:profileURL];
    [webview loadRequest:profileRequest];
}

+ (void)loadTheUpdateProfilePageWithUserIDforWebView:(UIWebView *)webview {
    
    NSString *categorizationNameParam = @"User%20Registration";
    NSString *userID = [KeychainHelper returnValueIDForCurrentUser];
    NSString *profileURLString = [NSString stringWithFormat:@"http://dev.1776union.io/union/user/getAttributeCollection?userId=%@&categorizationName=%@", userID,categorizationNameParam];
    NSURL *profileURL = [NSURL URLWithString:profileURLString];
    NSURLRequest *profileRequest = [NSURLRequest requestWithURL:profileURL];
    [webview loadRequest:profileRequest];
}

@end