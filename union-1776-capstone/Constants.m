//
//  Constants.m
//  union-1776-capstone
//
//  Created by Jim Campagno on 3/31/15.
//  Copyright (c) 2015 Flatiron School. All rights reserved.
//

#import "Constants.h"

@implementation Constants

// Uncomment for PROD Links
 NSString *const DEFAULT_LOGIN_SCREEN =@"https://union.1776.vc/union/";
 NSString *const DEFAULT_LOGIN_SCREEN_OR_FEED =@"https://union.1776.vc/union/feed/get?type=default";
 NSString *const CALENDAR_FEED = @"https://union.1776.vc/union/feed/get?type=calendar";
 NSString *const EXPLORE_FEED = @"https://union.1776.vc/union/explore/index";


// These are the DEV Links
//NSString *const DEFAULT_LOGIN_SCREEN =@"http:dev.1776union.io/union/";
//NSString *const DEFAULT_LOGIN_SCREEN_OR_FEED =@"http:dev.1776union.io/union/feed/get?type=default";
//NSString *const CALENDAR_FEED = @"http:dev.1776union.io/union/feed/get?type=calendar";
//NSString *const EXPLORE_FEED = @"http:dev.1776union.io/union/explore/index";

NSString *const SERVICE_ID_FOR_KEYCHAIN = @"Union1776";
NSString *const ACCOUNT_ID_FOR_KEYCHAIN = @"CurrentUser";
NSString *const DEVICE_ID_FOR_KEYCHAIN = @"UnionID";
NSString *const ACCOUNT_ID_FOR_DEVICEID = @"IDUser";
NSString *const SECURE_ID_FOR_KEYCHAIN = @"Union1776Secure";
NSString *const ACCOUNT_ID_FOR_SECUREID = @"IDSecureUser";
NSString *const PARSE_APPLICATION_ID = @"g9XVmZMLsNgqDXQIxYMvK69Dx5b1C6XrkEKHaoD3";
NSString *const PARSE_CLIENT_KEY = @"Lr4D8Ohu1eZscS13I61ehS0C8DKWK5R748DawABg";

@end