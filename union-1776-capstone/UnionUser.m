//
//  UnionUser.m
//  union-1776-capstone
//
//  Created by Nicolas Rizk on 4/6/15.
//  Copyright (c) 2015 Flatiron School. All rights reserved.
//

#import "UnionUser.h"

@implementation UnionUser

- (instancetype)initWithUserID:(NSString *)userID NotificationChannels:(NSArray *)notificationChannels {
    self = [super init];
    
    if (self) {
        _userID = userID;
        _notificationChannels = notificationChannels;
    }
    
    return self;
}

+ (UnionUser *)createUnionUser: (NSDictionary *)userDictionary {
    
    NSMutableArray *notificationChannels = [[NSMutableArray alloc] init];
    
    NSArray *lookupValuesArray = userDictionary[@"attributes"][@"entityAttributes"][0][@"lookupValues"];
    
    for (NSDictionary *notificationChannelDictionary in lookupValuesArray) {
        NSString *notificationChannel = notificationChannelDictionary[@"name"];
        [notificationChannels addObject:notificationChannel];
    }
    
    UnionUser *user = [[UnionUser alloc] initWithUserID:userDictionary[@"user"][@"id"] NotificationChannels:notificationChannels];
    return user;
}
@end
