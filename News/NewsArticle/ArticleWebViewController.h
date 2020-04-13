//
//  ArticleWebViewController.h
//  News
//
//  Created by Shivani on 12/04/20.
//  Copyright © 2020 smallcase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ArticleWebViewController : UIViewController <WKNavigationDelegate, UIWebViewDelegate>

@property(strong,nonatomic) WKWebView *webView;
@property (strong, nonatomic) NSURL *newsURL;
@property (strong, nonatomic) UIActivityIndicatorView *spinner;


@end

NS_ASSUME_NONNULL_END
