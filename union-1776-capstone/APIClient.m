//
//  APIClient.m
//  union-1776-capstone
//
//  Created by Jim Campagno on 4/2/15.
//  Copyright (c) 2015 Flatiron School. All rights reserved.
//

#import "APIClient.h"
#import "NSURLConnectionClient.h"

@implementation APIClient



+ (NSURLRequest *)getURLWithFeedItemIdfromNotification:(NSDictionary *)notification {
    
    NSString *stringToUseIfTrue = [NSString stringWithFormat:@"http://dev.1776union.io/union/feed/get?type=%@&feedItemId=%@", notification[@"type"], notification[@"feedItemId"]];
    NSURL *loginURL = [NSURL URLWithString:stringToUseIfTrue];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:loginURL];
    //    [webview loadRequest:urlRequest];
    
    return urlRequest;
}

+ (NSURLRequest *)getURLWithTagsfromNotification:(NSDictionary *)notification {
    
    NSString *stringToUseIfTrue = [NSString stringWithFormat:@"http://dev.1776union.io/union/feed/get?type=%@&tags=%@", notification[@"type"], notification[@"tags"]];
    NSURL *loginURL = [NSURL URLWithString:stringToUseIfTrue];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:loginURL];
    //    [webview loadRequest:urlRequest];
    
    return urlRequest;
}


+ (NSURLRequest *)getURLWithTypefromNotification:(NSDictionary *)notification {
    
    NSString *stringToUseIfTrue = [NSString stringWithFormat:@"http://dev.1776union.io/union/feed/get?type=%@", notification[@"type"]];
    NSURL *loginURL = [NSURL URLWithString:stringToUseIfTrue];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:loginURL];
    //    [webview loadRequest:urlRequest];
    
    return urlRequest;
}

+ (void)loadTheInitialFeedOrLoginScreenWithWebView:(UIWebView *)webview {
    
    NSString *defaultLoginURLString = [NSString stringWithFormat:@"%@", DEFAULT_LOGIN_SCREEN_OR_FEED];
    NSURL *loginURL = [NSURL URLWithString:defaultLoginURLString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:loginURL];
    //    [webview loadRequest:urlRequest];
    
    [APIClient testConnection:urlRequest forWebView:webview];
}

+ (void)loadTheFeedWithNotification:(NSDictionary *)notification withWebView:(UIWebView *)webview; {
    
    NSURLRequest *urlRequest = [[NSURLRequest alloc] init];
    
    if ([[notification allKeys] containsObject:@"feedItemId"]) {
        
        urlRequest = [APIClient getURLWithFeedItemIdfromNotification:notification];
    }
    else if ([[notification allKeys] containsObject:@"tags"])
        
        urlRequest = [APIClient getURLWithTagsfromNotification:notification];
    
    else if ([[notification allKeys] containsObject:@"type"]) {
        
        urlRequest = [APIClient getURLWithTypefromNotification:notification];
        
    } else {
        
        NSLog(@"None of the conditions are met, something is wrong - from API CLIENT");
        
    }
    
        [APIClient testConnection:urlRequest forWebView:webview];
}

+ (void)loadTheCalendarFeedWithWebView:(UIWebView *)webview {
    
    NSString *calendarURLString = [NSString stringWithFormat:@"%@", CALENDAR_FEED];
    NSURL *calendarURL = [NSURL URLWithString:calendarURLString];
    NSURLRequest *calendarRequest = [NSURLRequest requestWithURL:calendarURL];
    //    [webview loadRequest:calendarRequest];
    
    [APIClient testConnection:calendarRequest forWebView:webview];
}

+ (void)loadTheExplorerFeedWitHWebView:(UIWebView *)webview {
    
    NSString *exploreURLString = [NSString stringWithFormat:@"%@", EXPLORE_FEED];
    NSURL *exploreURL = [NSURL URLWithString:exploreURLString];
    NSURLRequest *exploreRequest = [NSURLRequest requestWithURL:exploreURL];
    //    [webview loadRequest:exploreRequest];
    
    [APIClient testConnection:exploreRequest forWebView:webview];
}

+ (void)loadTheProfilePageWithUserIDforWebView:(UIWebView *)webview {
    
    NSString *userID = [KeychainHelper returnValueIDForCurrentUser];
    NSString *profileURLString = [NSString stringWithFormat:@"http://dev.1776union.io/union/user/profile?userId=%@", userID];
    NSURL *profileURL = [NSURL URLWithString:profileURLString];
    NSURLRequest *profileRequest = [NSURLRequest requestWithURL:profileURL];
    //    [webview loadRequest:profileRequest];
    
    [APIClient testConnection:profileRequest forWebView:webview];
}

+ (void)loadTheUpdateProfilePageWithUserIDforWebView:(UIWebView *)webview {
    
    NSString *categorizationNameParam = @"User%20Registration";
    NSString *userID = [KeychainHelper returnValueIDForCurrentUser];
    NSString *profileURLString = [NSString stringWithFormat:@"http://dev.1776union.io/union/user/getAttributeCollection?userId=%@&categorizationName=%@", userID,categorizationNameParam];
    NSURL *profileURL = [NSURL URLWithString:profileURLString];
    NSURLRequest *profileRequest = [NSURLRequest requestWithURL:profileURL];
    //    [webview loadRequest:profileRequest];
    
    [APIClient testConnection:profileRequest forWebView:webview];
}

+ (void)testConnection:(NSURLRequest *)urlRequest forWebView:(UIWebView *)webview
{
    NSURLConnectionClient *connection = [[NSURLConnectionClient alloc] initWithUrlRequest:urlRequest forWebView:webview];
    
    [connection testConnection];
}


@end