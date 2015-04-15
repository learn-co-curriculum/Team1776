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
#import "UnionUser.h"
#import "UnionAPIClient.h"

@implementation ParseAPIClient

+ (void)saveUserIDtoParse {
    
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    NSString *userID = [KeychainHelper returnValueIDForCurrentUser];
    [currentInstallation setValue: userID forKey:@"userID_1776"];
    [currentInstallation saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
        if (succeeded) {
        [[UnionAPIClient sharedProxy] getNotificationsForUserID:userID CompletionHandler:^(UnionUser *unionUser) {
            [currentInstallation setValue:unionUser.notificationChannels forKey:@"notificationChannels"];
            [currentInstallation saveInBackground];
            
        }];
        }
        
    }];
    
    
    
}
@end
