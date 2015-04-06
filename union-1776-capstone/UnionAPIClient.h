//
//  UnionAPIClient.h
//  union-1776-capstone
//
//  Created by Nicolas Rizk on 4/6/15.
//  Copyright (c) 2015 Flatiron School. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UnionUser.h"

@interface UnionAPIClient : NSObject

+ (instancetype)sharedProxy;
- (void)getNotificationsForUserID: (NSString *)userID CompletionHandler:(void (^)(UnionUser *unionUser))completionBlock;

@end
