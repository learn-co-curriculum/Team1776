//
//  UnionDataStore.m
//  union-1776-capstone
//
//  Created by Nicolas Rizk on 4/16/15.
//  Copyright (c) 2015 Flatiron School. All rights reserved.
//

#import "UnionDataStore.h"

@implementation UnionDataStore

+ (instancetype)sharedDataStore {
    static UnionDataStore *_sharedDataStore = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedDataStore = [[UnionDataStore alloc] init];
    });
    
    return _sharedDataStore;
}

@end
