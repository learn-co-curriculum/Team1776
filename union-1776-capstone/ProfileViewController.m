//
//  ProfileViewController.m
//  union-1776-capstone
//
//  Created by Bert Carr on 4/1/15.
//  Copyright (c) 2015 Flatiron School. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.webView = [[WKWebView alloc] initWithFrame:self.view.frame];
    
    [self.view addSubview:self.webView];
    
    [self.webView setNavigationDelegate:self];
    [self.webView setUIDelegate:self];
    
    NSString *profileURLString = [NSString stringWithFormat:@"http://dev.1776union.io/union/user/profile?userId=%@", @""];
//    NSString *profileURLString = [NSString stringWithFormat:@"http://dev.1776union.io/union/explore/index"];
    
    NSURL *profileURL = [NSURL URLWithString:profileURLString];
    
    NSURLRequest *profileRequest = [NSURLRequest requestWithURL:profileURL];
    
    [self.webView loadRequest:profileRequest];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
