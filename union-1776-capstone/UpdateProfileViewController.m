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

@interface UpdateProfileViewController ()

@end

@implementation UpdateProfileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    
    [self.view addSubview:self.webView];
    
    [self.webView setDelegate:self];
    
    NSString *categorizationNameParam = @"User%20Registration";
    
    NSString *userID = [KeychainHelper returnValueIDForCurrentUser];
    
    NSString *profileURLString = [NSString stringWithFormat:@"http://dev.1776union.io/union/user/getAttributeCollection?userId=%@&categorizationName=%@", userID,categorizationNameParam];
    
    NSURL *profileURL = [NSURL URLWithString:profileURLString];
    
    NSURLRequest *profileRequest = [NSURLRequest requestWithURL:profileURL];
    
    [self.webView loadRequest:profileRequest];
}

//-(void)webViewDidStartLoad:(UIWebView *)webView
//{
//    self.UIBack.enabled = self.webView.canGoBack;
//}
//
//-(void)webViewDidFinishLoad:(UIWebView *)webView
//{
//    if (webView.canGoBack == YES)
//    {
//        self.UIBack.enabled = YES;
//        [self.UIBack setTintColor:[UIColor blueColor]];
//    }
//    else
//    {
//        self.UIBack.enabled = NO;
//        [self.UIBack setTintColor:[UIColor clearColor]];
//    }
//}

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
