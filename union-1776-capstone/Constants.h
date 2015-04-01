//
//  Constants.h
//  union-1776-capstone
//
//  Created by Jim Campagno on 3/31/15.
//  Copyright (c) 2015 Flatiron School. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Constants : NSObject

//The main feed - if you try to hit this URL not logged in, it asks you to login
extern NSString *const DEFAULT_LOGIN_SCREEN_OR_FEED;

//This isn't working
extern NSString *const CALENDAR_FEED;

//A bunch of hastags, not that pretty
extern NSString *const EXPLORE_FEED;


//Working, being used with the KeychainHelper class
extern NSString *const SERVICE_ID_FOR_KEYCHAIN;
extern NSString *const ACCOUNT_ID_FOR_KEYCHAIN;

@end