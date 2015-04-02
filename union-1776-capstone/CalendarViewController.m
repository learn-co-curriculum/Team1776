//
//  CalendarViewController.m
//  union-1776-capstone
//
//  Created by Bert Carr on 4/1/15.
//  Copyright (c) 2015 Flatiron School. All rights reserved.
//

#import "CalendarViewController.h"
#import "Constants.h"

@interface CalendarViewController ()

@property (weak, nonatomic) IBOutlet UIBarButtonItem *UIBack;

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
    //    [self.webView setNavigationDelegate:self];
    //    [self.webView setUIDelegate:self];
    
    NSString *calendarURLString = [NSString stringWithFormat:@"%@", CALENDAR_FEED];
    NSURL *calendarURL = [NSURL URLWithString:calendarURLString];
    NSURLRequest *calendarRequest = [NSURLRequest requestWithURL:calendarURL];
    [self.webView loadRequest:calendarRequest];
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
    // Dispose of any resources that can be recreated.
}

- (IBAction)backTapped:(id)sender
{
    if ([self.webView canGoBack])
    {
        [self.webView goBack];
    }
}
@end
