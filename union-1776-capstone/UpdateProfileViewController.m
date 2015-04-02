//
//  UpdateProfileViewController.m
//  union-1776-capstone
//
//  Created by Bert Carr on 4/1/15.
//  Copyright (c) 2015 Flatiron School. All rights reserved.
//

#import "UpdateProfileViewController.h"
#import <SSKeychain.h>
#import <SSKeychainQuery.h>
#import "KeychainHelper.h"
#import "APIClient.h"

@interface UpdateProfileViewController ()
@property (strong, nonatomic) UIWebView *webView;
@end

@implementation UpdateProfileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:self.webView];
    [self.webView setDelegate:self];
    [APIClient loadTheUpdateProfilePageWithUserIDforWebView:self.webView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end