//
//  NSURLConnectionClient.m
//  union-1776-capstone
//
//  Created by Bert Carr on 4/14/15.
//  Copyright (c) 2015 Flatiron School. All rights reserved.
//

#import "NSURLConnectionClient.h"
#import <MBProgressHUD.h>
#import <MBProgressHUD.h>

@interface NSURLConnectionClient ()

@property (strong, nonatomic) NSURLRequest *urlRequest;

@property (strong, nonatomic) UIWebView *webView;

@end

@implementation NSURLConnectionClient

- (instancetype)initWithUrlRequest:(NSURLRequest *)urlRequest forWebView:(UIWebView *)webView {
    self = [super init];
    
    if (self)
    {
        _urlRequest = urlRequest;
        _webView = webView;
    }
    
    return self;
}

- (void)testConnection {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.webView animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.labelText = @"Loading";
    
    [[NSURLConnection alloc] initWithRequest:self.urlRequest delegate:self];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    
    [MBProgressHUD hideHUDForView:self.webView animated:YES];

    [self showAlert:@"Connection error" withMessage:@"Error connecting to page.  Please check your 3G and/or Wifi settings."];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    
    //Check for server error
    if ([httpResponse statusCode] >= 400)
    {
        [self showAlert:@"Server error" withMessage:@"Error connecting to page.  If error persists, please contact support."];
    }

    [self.webView loadRequest:self.urlRequest];
}

- (void)showAlert:(NSString *)title withMessage:(NSString *)message {
    
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:NSLocalizedString(@"OK", @"OK action")
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *action)
                               {
                               }];
    
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:title
                                          message:message
                                          preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:okAction];
    
    UIViewController *viewC = (UIViewController *)self.webView.delegate;
    
    [viewC presentViewController:alertController animated:YES completion:nil];
}
@end
