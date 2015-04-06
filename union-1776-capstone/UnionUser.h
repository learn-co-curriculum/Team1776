//
//  UnionUser.h
//  union-1776-capstone
//
//  Created by Nicolas Rizk on 4/6/15.
//  Copyright (c) 2015 Flatiron School. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UnionUser : NSObject

- (instancetype)initWithUserID: (NSString *)userID
          NotificationChannels: (NSArray *)notificationChannels;
+ (UnionUser *)createUnionUser: (NSDictionary *)userDictionary;

@property (strong, nonatomic) NSString *userID;
@property (strong, nonatomic) NSArray *notificationChannels;

@end
