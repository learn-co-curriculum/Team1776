//
//  UnionAPIClient.m
//  union-1776-capstone
//
//  Created by Nicolas Rizk on 4/6/15.
//  Copyright (c) 2015 Flatiron School. All rights reserved.
//

#import "UnionAPIClient.h"
#import <AFNetworking.h>
#import "UnionUser.h"

@implementation UnionAPIClient

+ (instancetype)sharedProxy
{
    static UnionAPIClient *sharedProxy;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedProxy = [[self alloc] init];
    });
    return sharedProxy;
    
}

- (void)getNotificationsForUserID: (NSString *)userID CompletionHandler:(void (^)(UnionUser *unionUser))completionBlock {
    NSString *unionURL = @"http://dev.1776union.io/union/user/getAttributeCollection?";
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSDictionary *urlParams = @{@"userID" : userID, @"categorizationName" : @"NotificationChannels"};
    
    [manager GET:unionURL parameters:urlParams success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"I am accessing Union's API");
        
        completionBlock([UnionUser createUnionUser:responseObject]);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Fail to access Union's API");
              }];
}

@end
