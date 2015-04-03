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
    [SSKeychain deletePasswordForService:@"Union" account:@"CurrentUser"];
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

@end