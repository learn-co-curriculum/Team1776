//
//  parseAPIClient.m
//  union-1776-capstone
//
//  Created by Thomas Prezioso on 4/7/15.
//  Copyright (c) 2015 Flatiron School. All rights reserved.
//

#import "ParseAPIClient.h"
#import <Parse/Parse.h>
#import "KeychainHelper.h"

@implementation ParseAPIClient
+ (void)saveUserIDtoParse {
    
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    
    [currentInstallation setValue: [KeychainHelper returnValueIDForCurrentUser] forKey:@"userID_1776"];
    [currentInstallation saveInBackground];
    NSString *test = @"law";
    //    [[UnionAPIClient sharedProxy] getNotificationsForUserID:[KeychainHelper returnValueIDForCurrentUser] CompletionHandler:^(UnionUser *unionUser) {
    [currentInstallation setValue:test forKey:@"notificationChannels"];
    [currentInstallation saveInBackground];
    
    //    }];
    
}
@end
