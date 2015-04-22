//
//  ExploreViewController.m
//  union-1776-capstone
//
//  Created by Bert Carr on 4/1/15.
//  Copyright (c) 2015 Flatiron School. All rights reserved.
//

#import "ExploreViewController.h"
#import "Constants.h"
#import "APIClient.h"
#import <MBProgressHUD.h>

@interface ExploreViewController ()

- (IBAction)backTapped:(id)sender;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *UIBack;
@property (strong, nonatomic) UIWebView *webView;
@end

@implementation ExploreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.UIBack.enabled = NO;
    [self.UIBack setTintColor:[UIColor clearColor]];
    
    self.webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:self.webView];
    self.webView.delegate = self;
    [APIClient loadTheExplorerFeedWitHWebView:self.webView];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    self.UIBack.enabled = self.webView.canGoBack;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [MBProgressHUD hideHUDForView:webView animated:YES];
    
    //To disable horizontal scrolling
    [webView.scrollView setContentSize: CGSizeMake(webView.frame.size.width, webView.scrollView.contentSize.height)];
    
    if (webView.canGoBack == YES)
    {
        self.UIBack.enabled = YES;
        [self.UIBack setTintColor:[UIColor blueColor]];
    }
    else
    {
        self.UIBack.enabled = NO;
        [self.UIBack setTintColor:[UIColor clearColor]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)backTapped:(id)sender {
    if ([self.webView canGoBack])
    {
        [self.webView goBack];
    }
}

@end
