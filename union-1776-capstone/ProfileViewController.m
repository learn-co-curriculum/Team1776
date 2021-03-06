//
//  ProfileViewController.m
//  union-1776-capstone
//
//  Created by Bert Carr on 4/1/15.
//  Copyright (c) 2015 Flatiron School. All rights reserved.
//

#import "ProfileViewController.h"
#import <SSKeychain.h>
#import <SSKeychainQuery.h>
#import "KeychainHelper.h"
#import "APIClient.h"
#import <MBProgressHUD.h>

@interface ProfileViewController ()
@property (strong, nonatomic) UIWebView *webView;
@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    
    [self.view addSubview:self.webView];
    
    [self.webView setDelegate:self];
    
    [APIClient loadTheProfilePageWithUserIDforWebView:self.webView];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [MBProgressHUD hideHUDForView:webView animated:YES];
}

@end