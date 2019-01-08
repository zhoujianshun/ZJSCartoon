//
//  ASWebViewViewController.h
//  RippleSENS8
//
//  Created by 周建顺 on 2018/8/31.
//  Copyright © 2018年 RippleInfo. All rights reserved.
//


#import <WebKit/WebKit.h>

#import "ZJSViewController.h"

@interface ZJSWebViewController : ZJSViewController<WKNavigationDelegate, WKUIDelegate>

@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, assign) BOOL autoUpdateTitle;

@property (nonatomic, copy) NSString *url;
-(void)loadRequestWithUrl:(NSURL*)url;

@end
