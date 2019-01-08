//
//  ASWebViewViewController.m
//  RippleSENS8
//
//  Created by 周建顺 on 2018/8/31.
//  Copyright © 2018年 RippleInfo. All rights reserved.
//

// 参考
// https://www.jianshu.com/p/833448c30d70
// http://www.cocoachina.com/ios/20180314/22589.html

#import "ZJSWebViewController.h"

#import <Masonry/Masonry.h>

#import "ZJSColorsMacros.h"
#import "ZJSDebugMacros.h"

#define  KScreenWidth CGRectGetWidth(self.view.frame)

NSString* const kWebViewObserverKeyEstimatedProgress = @"estimatedProgress";
NSString* const kWebViewObserverKeyTitle = @"title";

@interface ZJSWebViewController ()

@property (nonatomic,weak) CALayer *progressLayer;

@end

@implementation ZJSWebViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self wb_commonInit];
    [self addWebViewObservers];
    
    if (self.url) {
        [self loadRequestWithUrl:[NSURL URLWithString:self.url]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    [self removeWebViewObservers];
}

-(void)wb_commonInit{
    [self addCloseButton];
    [self.view addSubview:self.webView];
    [self wb_layoutPageSubViews];
    [self setupProgress];
}

-(void)wb_layoutPageSubViews{
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

-(void)addCloseButton{
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setTitle:@"关闭" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:15.f];
    [rightBtn addTarget:self action:@selector(closeAction:)
       forControlEvents:UIControlEventTouchUpInside];
    [rightBtn sizeToFit];
    self.navigationItem.rightBarButtonItem =  [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
}

-(void)setupProgress{
    UIView *progress = [[UIView alloc]init];
    progress.backgroundColor = [UIColor  clearColor];
    [self.view addSubview:progress];
    [progress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_topLayoutGuide);
        make.leading.equalTo(self.view);
        make.trailing.equalTo(self.view);
        make.height.equalTo(@3);
    }];
    
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(0, 0, 0, 3);
    layer.backgroundColor = RGBHEX(0x54D96A).CGColor;
    [progress.layer addSublayer:layer];
    self.progressLayer = layer;
}

-(void)loadRequestWithUrl:(NSURL*)url{
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

#pragma mark - override



-(void)backBtnClicked:(UIButton *)sender{
    if (self.webView.canGoBack) {
        [self.webView goBack];
    }else{
        [self closeAction:nil];
    }
}

#pragma mark - observers

-(void)addWebViewObservers{
    [self.webView addObserver:self forKeyPath:kWebViewObserverKeyEstimatedProgress options:NSKeyValueObservingOptionNew context:nil];
    [self.webView addObserver:self forKeyPath:kWebViewObserverKeyTitle options:NSKeyValueObservingOptionNew context:NULL];
}

-(void)removeWebViewObservers{
    [_webView removeObserver:self forKeyPath:kWebViewObserverKeyEstimatedProgress];
    [_webView removeObserver:self forKeyPath:kWebViewObserverKeyTitle];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:kWebViewObserverKeyEstimatedProgress]) {
        self.progressLayer.opacity = 1;
        if ([change[@"new"] floatValue] <[change[@"old"] floatValue]) {
            return;
        }
        self.progressLayer.frame = CGRectMake(0, 0, KScreenWidth*[change[@"new"] floatValue], 3);
        if ([change[@"new"] floatValue] == 1.0) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progressLayer.opacity = 0;
                self.progressLayer.frame = CGRectMake(0, 0, 0, 3);
            });
        }
        
        DLog(@"WKWebView progress:%@",change[@"new"]);
    }else if ([keyPath isEqualToString:kWebViewObserverKeyTitle]){
        if (self.autoUpdateTitle) {
             self.title = change[@"new"];
        }
       
    }
}


#pragma mark - WKNavigationDelegate

/* 在发送请求之前，决定是否跳转 */
// 决定导航的动作，通常用于处理跨域的链接能否导航。
// WebKit对跨域进行了安全检查限制，不允许跨域，因此我们要对不能跨域的链接单独处理。
// 但是，对于Safari是允许跨域的，不用这么处理。
// 这个是决定是否Request
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    //允许跳转
    decisionHandler(WKNavigationActionPolicyAllow);
    //不允许跳转
    //decisionHandler(WKNavigationActionPolicyCancel);
}

/* 在收到响应后，决定是否跳转 */
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    
    NSLog(@"%@",navigationResponse.response.URL.absoluteString);
    //允许跳转
    decisionHandler(WKNavigationResponsePolicyAllow);
    //不允许跳转
    //decisionHandler(WKNavigationResponsePolicyCancel);
}

//用于授权验证的API，与AFN、UIWebView的授权验证API是一样的
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential *__nullable credential))completionHandler{
    
    completionHandler(NSURLSessionAuthChallengePerformDefaultHandling ,nil);
}


/* 页面开始加载 */
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
}

// 当main frame接收到服务重定向时调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation{
    // 接收到服务器跳转请求之后调用
}

/* 页面加载失败 */
// 当main frame开始加载数据失败时，会回调
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    
}


/* 开始返回内容 */
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    
}
/* 页面加载完成 */
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    //self.title = webView.title;
}


// 当main frame最后下载数据失败时，会回调
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    DLog(@"didFailNavigation:%@", error)
}
// 当web content处理完成时，会回调
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView {
    
}

#pragma mark - WKUIDelegate
//这个代理方法, 主要是用来处理使用系统的弹框来替换JS中的一些弹框的,比如: 警告框, 选择框, 输入框, 主要使用的是下面三个代理方法:

//
///** webView中弹出警告框时调用, 只能有一个按钮
// @param webView webView
// @param message 提示信息
// @param frame 可用于区分哪个窗口调用的
// @param completionHandler 警告框消失的时候调用, 回调给JS
// */
//- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"警告" message:message preferredStyle:(UIAlertControllerStyleAlert)]; UIAlertAction *ok = [UIAlertAction actionWithTitle:@"我知道了" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) { completionHandler(); }]; [alert addAction:ok]; [self presentViewController:alert animated:YES completion:nil];
//
//}
///** 对应js的confirm方法 webView中弹出选择框时调用, 两个按钮
// @param webView webView description
// @param message 提示信息 @param frame 可用于区分哪个窗口调用的
// @param completionHandler 确认框消失的时候调用, 回调给JS, 参数为选择结果: YES or NO
// */
//- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler {
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请选择" message:message preferredStyle:(UIAlertControllerStyleAlert)];
//    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"同意" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
//        completionHandler(YES);
//
//    }];
//    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"不同意" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
//        completionHandler(NO);
//
//    }];
//    [alert addAction:ok];
//    [alert addAction:cancel];
//    [self presentViewController:alert animated:YES completion:nil];
//
//}
///** 对应js的prompt方法 webView中弹出输入框时调用, 两个按钮 和 一个输入框
// @param webView webView description
// @param prompt 提示信息
// @param defaultText 默认提示文本
// @param frame 可用于区分哪个窗口调用的
// @param completionHandler 输入框消失的时候调用, 回调给JS, 参数为输入的内容 */
//- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable result))completionHandler {
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请输入" message:prompt preferredStyle:(UIAlertControllerStyleAlert)];
//    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
//        textField.placeholder = @"请输入";
//
//    }];
//    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
//        UITextField *tf = [alert.textFields firstObject];
//        completionHandler(tf.text);
//
//    }]; UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
//        completionHandler(defaultText);
//
//    }];
//    [alert addAction:ok];
//    [alert addAction:cancel];
//    [self presentViewController:alert animated:YES completion:nil];
//
//}


#pragma mark - event response

-(void)closeAction:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - getters and setters
-(WKWebView *)webView{
    if (!_webView) {
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        config.selectionGranularity = WKSelectionGranularityDynamic;
        config.allowsInlineMediaPlayback = YES;
        WKPreferences *preferences = [WKPreferences new];
        //是否支持JavaScript
        preferences.javaScriptEnabled = YES;
        //不通过用户交互，是否可以打开窗口
        preferences.javaScriptCanOpenWindowsAutomatically = YES;
        config.preferences = preferences;
        WKWebView *webview = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) configuration:config];
        
        
        webview.navigationDelegate = self;
        webview.UIDelegate = self;
        
        _webView = webview;
    }
    return _webView;
}


@end
