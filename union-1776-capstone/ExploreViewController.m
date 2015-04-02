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

@interface ExploreViewController ()

- (IBAction)forwardTapped:(id)sender;
- (IBAction)backTapped:(id)sender;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *UIForward;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *UIBack;
@property (strong, nonatomic) UIWebView *webView;
@end

@implementation ExploreViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.UIBack.enabled = NO;
    [self.UIBack setTintColor:[UIColor clearColor]];
    self.UIForward.enabled = NO;
    [self.UIForward setTintColor:[UIColor clearColor]];
    
    self.webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    
    [self.view addSubview:self.webView];
    
    self.webView.delegate = self;
    
    [APIClient loadTheExplorerFeedWitHWebView:self.webView];

    [self.webView addObserver:self forKeyPath:@"loading" options:NSKeyValueObservingOptionNew context:nil];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ( [keyPath isEqualToString:@"loading"] )
    {
        self.UIBack.enabled = self.webView.canGoBack;
        if (self.webView.canGoBack)
        {
            [self.UIBack setTintColor:[UIColor blueColor]];
        }
        else
        {
            [self.UIBack setTintColor:[UIColor clearColor]];
        }
        
        self.UIForward.enabled = self.webView.canGoForward;
        if (self.webView.canGoForward)
        {
            [self.UIForward setTintColor:[UIColor blueColor]];
        }
        else
        {
            [self.UIForward setTintColor:[UIColor clearColor]];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)forwardTapped:(id)sender
{
    if ([self.webView canGoForward])
    {
        [self.webView goForward];
    }
}

- (IBAction)backTapped:(id)sender
{
    if ([self.webView canGoBack])
    {
        [self.webView goBack];
    }
}

@end
