//
//  UnionTabBarViewController.m
//  union-1776-capstone
//
//  Created by Bert Carr on 4/7/15.
//  Copyright (c) 2015 Flatiron School. All rights reserved.
//

#import "UnionTabBarViewController.h"
#import "LoginViewController.h"

typedef enum {
    FEED,
    CALENDAR,
    EXPLORE,
    MORE
} tabItem;

@interface UnionTabBarViewController ()

@property (nonatomic) tabItem currentTab;

@end

@implementation UnionTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.currentTab = FEED;
}

#pragma mark - UITabBarControllerDelegate Methods

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    if ( ( item.tag == self.currentTab ) && ( self.currentTab == FEED ) )
    {
        NSLog(@"Selected Feed while on Feed");
        
        UINavigationController *selectedVC = [self.viewControllers objectAtIndex:self.tabBarController.selectedIndex];
        
        LoginViewController *loginVC = [selectedVC.viewControllers objectAtIndex:0];
        
        [loginVC reloadWebView];
    }
    else
    {
        switch (item.tag) {
            case 0:
                self.currentTab = FEED;
                break;
                
            case 1:
                self.currentTab = CALENDAR;
                break;
                
            case 2:
                self.currentTab = EXPLORE;
                break;
                
            case 3:
                self.currentTab = MORE;
                break;
                
            default:
                break;
        };
    }
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
