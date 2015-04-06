//
//  MoreTableViewController.m
//  union-1776-capstone
//
//  Created by Bert Carr on 4/1/15.
//  Copyright (c) 2015 Flatiron School. All rights reserved.
//

#import "MoreTableViewController.h"
#import "KeychainHelper.h"

@interface MoreTableViewController ()

@end

@implementation MoreTableViewController

- (void)viewDidLoad {
    
    [KeychainHelper printAllAccountsInKeychainInConsole];
    
    [super viewDidLoad];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 2;
    }
    else {
        return 1;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //Row 0, section 2 is the logout tableViewCell
    NSIndexPath *logOutIndexPath = [NSIndexPath indexPathForRow:0 inSection:2];
    NSIndexPath *selectedIndexPath = [tableView indexPathForSelectedRow];
    
    if ([selectedIndexPath isEqual:logOutIndexPath]) {
        
        [KeychainHelper deleteTheCurrentUserInfoFromKeyChain];
        [KeychainHelper printAllAccountsInKeychainInConsole];
        
        NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        for (NSHTTPCookie *cookie in [storage cookies]) {
            [storage deleteCookie:cookie];
        }
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        UIAlertView *messageAlert = [[UIAlertView alloc]
                                     initWithTitle:@"Message" message:@"You've Logged Out" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        // Display Alert Message
        [messageAlert show];
        
        for (UIView *view in self.view.subviews) {
            
            [view removeFromSuperview];
        }
        
        
        UIStoryboard *mainSB = self.storyboard;
        UINavigationController *navController = [mainSB instantiateInitialViewController];
        
        [self.view.subviews makeObjectsPerformSelector:@selector(viewDidLoad)];
        
        [[UIApplication sharedApplication].delegate.window setRootViewController:navController];
    }
}

@end