//
//  CalendarViewController.m
//  union-1776-capstone
//
//  Created by Bert Carr on 4/1/15.
//  Copyright (c) 2015 Flatiron School. All rights reserved.
//

#import "CalendarViewController.h"
#import "Constants.h"
#import "APIClient.h"

@interface CalendarViewController ()

@property (weak, nonatomic) IBOutlet UIBarButtonItem *UIBack;
@property (strong, nonatomic) UIWebView *webView;

- (IBAction)backTapped:(id)sender;

@end

@implementation CalendarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.UIBack.enabled = NO;
    [self.UIBack setTintColor:[UIColor clearColor]];
    
    self.webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:self.webView];
    
    self.webView.delegate = self;
    
    [APIClient loadTheCalendarFeedWithWebView:self.webView];
    
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
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)backTapped:(id)sender
{
    if ([self.webView canGoBack])
    {
        [self.webView goBack];
    }
}
@end
