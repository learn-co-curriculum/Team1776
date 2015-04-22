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
#import "Constants.h"

@implementation UnionAPIClient

+ (instancetype)sharedProxy {
    static UnionAPIClient *sharedProxy;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedProxy = [[self alloc] init];
    });
    return sharedProxy;
    
}

- (void)getNotificationsForUserID: (NSString *)userID
                CompletionHandler:(void (^)(UnionUser *unionUser))completionBlock {

    NSString *defaultLoginURLString = [NSString stringWithFormat:@"http://dev.1776union.io/union/user/getAttributeCollection?userId=%@&categorizationName=NotificationChannels", userID];
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [manager GET:defaultLoginURLString
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSLog(@"I am accessing Union Notifications API");
             
             completionBlock([UnionUser createUnionUser:responseObject]);
             
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"Error: %@", error);
         }];
    
}

@end
