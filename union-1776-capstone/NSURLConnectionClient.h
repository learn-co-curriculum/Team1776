//
//  NSURLConnectionClient.h
//  union-1776-capstone
//
//  Created by Bert Carr on 4/14/15.
//  Copyright (c) 2015 Flatiron School. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

@interface NSURLConnectionClient : NSObject <NSURLConnectionDelegate>

-(instancetype)initWithUrlRequest:(NSURLRequest *)urlRequest forWebView:(UIWebView *)webView;

-(void)testConnection;

@end
