//
//  KeychainHelperMethods.h
//  union-1776-capstone
//
//  Created by Jim Campagno on 4/1/15.
//  Copyright (c) 2015 Flatiron School. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SSKeychain.h>
#import <SSKeychainQuery.h>
#import "Constants.h"

@interface KeychainHelper : NSObject

+ (void)deleteTheCurrentUserInfoFromKeyChain;
+ (void)setUpCurrentUserInKeyChainWithValueID:(NSString *)valueID;
+ (void)printAllAccountsInKeychainInConsole;
+ (NSString *)returnValueIDForCurrentUser;
+ (void)storeDeviceIDintoPhone:(NSString *)deviceID;
+ (NSString *)returnDeviceIDForCurrentUser;
+ (void)storeSecureIDintoPhone:(NSString *)secureID;
+ (NSString *)returnSecureIDforPhone;

@end