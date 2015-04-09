//
//  APIClient.m
//  union-1776-capstone
//
//  Created by Jim Campagno on 4/2/15.
//  Copyright (c) 2015 Flatiron School. All rights reserved.
//

#import "APIClient.h"
#import <AFNetworking.h>
#import "KeychainHelper.h"

@implementation APIClient

+ (void)loadTheInitialFeedOrLoginScreenWithWebView:(UIWebView *)webview {
    
          
          
    //    union/user/getAttributeCollection?userId=3f7375a1-d70b-11e4-bf54-06867e4d05a8&categorizationName=NotificationChannels
    
//    "http://dev.1776union.io/union/user/getAttributeCollection?userId=3f7375a1-d70b-11e4-bf54-06867e4d05a8&categorizationName=NotificationChannels
//    3f7375a1-d70b-11e4-bf54-06867e4d05a8
    

    NSString *defaultLoginURLString = [NSString stringWithFormat:@"http://dev.1776union.io/union/user/getAttributeCollection?userId=3f7375a1-d70b-11e4-bf54-06867e4d05a8&categorizationName=NotificationChannels"];
//    NSString *defaultLoginURLString = [NSString stringWithFormat:@"%@", DEFAULT_LOGIN_SCREEN_OR_FEED];

    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [manager GET:defaultLoginURLString
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             
             
             
             NSLog(@"%@", responseObject);
//             NSArray *entries = responseObject[@"entries"];
//             NSDictionary *oneEntry = entries[0]; // MORE THAN ONE (MAYBE?!)
//             NSArray *attributes = [oneEntry valueForKey:@"attributes"];
//             NSDictionary *oneAttribute = attributes[0]; // MORE THAN ONE (MAYBE?!)
//             
//             NSLog(@"THIS!: %@", oneAttribute);
             
             
            
             
             
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"Error: %@", error);
         }];
    
    
    
    
    
    
//    NSString *defaultLoginURLString = [NSString stringWithFormat:@"%@", DEFAULT_LOGIN_SCREEN_OR_FEED];
//    NSURL *loginURL = [NSURL URLWithString:defaultLoginURLString];
//    
//    NSMutableURLRequest *testRequest = [[NSMutableURLRequest alloc] initWithURL:loginURL];
//    [testRequest addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//    [webview loadRequest:testRequest];
    
//    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:loginURL];
//    [webview loadRequest:urlRequest];
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