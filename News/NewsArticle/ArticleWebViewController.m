//
//  ArticleWebViewController.m
//  News
//
//  Created by Shivani on 12/04/20.
//  Copyright © 2020 smallcase. All rights reserved.
//

#import "ArticleWebViewController.h"

@interface ArticleWebViewController ()

@end

@implementation ArticleWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeWebView];
    [self startSpinner];
    [self loadUrl];
    
}

-(void) initializeWebView {
    
    // Initialize Web View
    _webView = [[WKWebView alloc] initWithFrame:self.view.frame];
    _webView.navigationDelegate = self;
    
    _webView.frame = CGRectMake(self.view.frame.origin.x,self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:_webView];
}

-(void) loadUrl {
    
    NSURLRequest *request = [NSURLRequest requestWithURL:_newsURL];
    [_webView loadRequest:request];
}

-(void) startSpinner {
    _spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleLarge];
    _spinner.tag = 100;
    [self.view addSubview:_spinner];
    [_spinner setCenter:CGPointMake(self.view.center.x, self.view.center.y)];
    [_webView bringSubviewToFront:_spinner];
    
    [_spinner startAnimating];
    
}

-(void) stopSpinner {
    
    [_spinner removeFromSuperview];
}


- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
    [self stopSpinner];
}

@end
