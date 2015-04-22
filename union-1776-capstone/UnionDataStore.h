//
//  UnionDataStore.h
//  union-1776-capstone
//
//  Created by Nicolas Rizk on 4/16/15.
//  Copyright (c) 2015 Flatiron School. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UnionDataStore : NSObject

+ (instancetype)sharedDataStore;
@property (strong, nonatomic) NSDictionary *notificationDictionary;

@end
