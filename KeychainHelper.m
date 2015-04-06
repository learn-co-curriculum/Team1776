//
//  KeychainHelperMethods.m
//  union-1776-capstone
//
//  Created by Jim Campagno on 4/1/15.
//  Copyright (c) 2015 Flatiron School. All rights reserved.
//

#import "KeychainHelper.h"

@implementation KeychainHelper

+ (void)deleteTheCurrentUserInfoFromKeyChain {
    
    [SSKeychain deletePasswordForService:SERVICE_ID_FOR_KEYCHAIN account:ACCOUNT_ID_FOR_KEYCHAIN];
    [SSKeychain deletePasswordForService:DEVICE_ID_FOR_KEYCHAIN account:ACCOUNT_ID_FOR_DEVICEID];
}

+ (void)setUpCurrentUserInKeyChainWithValueID:(NSString *)valueID {
    
    [SSKeychain setPassword:valueID
                 forService:SERVICE_ID_FOR_KEYCHAIN
                    account:ACCOUNT_ID_FOR_KEYCHAIN
                      error:nil];
    
}

+ (void)printAllAccountsInKeychainInConsole {
    
    NSLog(@"This is all of the accounts in keychain: %@", [SSKeychain allAccounts]);
}

+ (NSString *)returnValueIDForCurrentUser {
    
    return [SSKeychain passwordForService:SERVICE_ID_FOR_KEYCHAIN account:ACCOUNT_ID_FOR_KEYCHAIN];
    
}

+ (void)storeDeviceIDintoPhone:(NSString *)deviceID {
    
    [SSKeychain setPassword:deviceID
                 forService:DEVICE_ID_FOR_KEYCHAIN
                    account:ACCOUNT_ID_FOR_DEVICEID
                      error:nil];
}

+ (NSString *)returnDeviceIDForCurrentUser {
    
    return [SSKeychain passwordForService:DEVICE_ID_FOR_KEYCHAIN account:ACCOUNT_ID_FOR_DEVICEID];
}

+ (void)storeSecureIDintoPhone:(NSString *)secureID {
    
    [SSKeychain setPassword:secureID
                 forService:SECURE_ID_FOR_KEYCHAIN
                    account:ACCOUNT_ID_FOR_SECUREID
                      error:nil];
}

+ (NSString *)returnSecureIDforPhone {
    
    return [SSKeychain passwordForService:SECURE_ID_FOR_KEYCHAIN account:ACCOUNT_ID_FOR_SECUREID];
    
}

@end