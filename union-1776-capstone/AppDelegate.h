//
//  AppDelegate.h
//  union-1776-capstone
//
//  Created by Nicolas Rizk on 3/30/15.
//  Copyright (c) 2015 Flatiron School. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol AppDelegateDelegate <NSObject>

@required
- (void)dataFromAppDelegate:(NSDictionary *)user1776Info;
@end
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (weak, nonatomic) id<AppDelegateDelegate> delegate;

@end

