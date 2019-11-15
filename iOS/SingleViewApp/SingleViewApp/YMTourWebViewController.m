//
//  TourWebViewController.m
//  SingleViewApp
//
//  Created by 赵一鸣 on 2019/11/9.
//  Copyright © 2019 zhaoyiming. All rights reserved.
//

#import "YMTourWebViewController.h"
#import "WebViewJavascriptBridge.h"

@interface YMTourWebViewController ()<WKNavigationDelegate, WKUIDelegate>

@property(nonatomic, strong, readwrite) WKWebView *webview;
@property(nonatomic, strong, readwrite) UIProgressView *progressView;
@property(nonatomic, strong, readwrite) WebViewJavascriptBridge *bridge;

@end

@implementation YMTourWebViewController

- (void)dealloc
{
    [self.webview removeObserver:self forKeyPath:@"estimatedProgress"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    WKWebView *webview = [[WKWebView alloc] initWithFrame:CGRectMake(0, 88, self.view.frame.size.width, 300)];
    
    NSString *url = [NSString stringWithFormat:@"http://127.0.0.1:8080/red-packet/index?b=1"];
    NSLog(@"url: %@", url);
    [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    
    self.webview = webview;
    self.webview.navigationDelegate = self;
    self.webview.UIDelegate = self;
    
    [self.view addSubview:webview];
    
    [self.view addSubview:({
        self.progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 88, self.view.frame.size.width, 20)];
        self.progressView;
    })];
    
    [self.webview addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    
    // JSBridge 与 URL Scheme 方式只能同时选用其中一种，目前仅测试使用
    [self setupJsBridge];
    
    UIView *naviveView = [[UIView alloc] initWithFrame:CGRectMake(0, 400, self.view.frame.size.width, self.view.frame.size.height - 400)];
    naviveView.backgroundColor = [UIColor blueColor];
    
    UIView *btn = [[UIView alloc] initWithFrame:CGRectMake(20, 20, 100, 50)];
    btn.backgroundColor = [UIColor redColor];
    [naviveView addSubview:btn];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btnClick)];
    [naviveView addGestureRecognizer:tapGesture];
    
    [self.view addSubview:naviveView];
}

- (void) btnClick {
    NSDictionary *nativeData = @{
        @"message": @"success",
        @"data": @{
                @"a": @(1),
                @"b": @(2)
        }
    };
    [self.bridge callHandler:@"jsbridge_getJsMessage" data:nativeData responseCallback:^(id responseData) {
        NSLog(@"%@", responseData);
    }];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"页面加载完毕了，可以关闭loading了");
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSLog(@"当前进度: %f", self.webview.estimatedProgress);
    self.progressView.progress = self.webview.estimatedProgress;
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSURLRequest *request = navigationAction.request;
    NSString *scheme = request.URL.scheme;
    NSString *host = request.URL.host;
    
    if (![scheme isEqualToString:@"app"]) {
        return decisionHandler(WKNavigationActionPolicyAllow);
    }
    
    if ([host isEqualToString:@"login"]) {
        NSString *urlString = [NSString stringWithFormat:@"%@", request.URL];
        
        if ([urlString containsString:@"?"]) {
            NSRange range = [urlString rangeOfString:@"?"];
            NSString *query = [urlString substringFromIndex:range.location+1];
            NSArray *params = [query componentsSeparatedByString:@"&"];
            
            NSMutableDictionary *paramsDic = [[NSMutableDictionary alloc] initWithDictionary:@{}];
            for (int i = 0; i < params.count; i++) {
                NSArray *temp = [params[i] componentsSeparatedByString:@"="];
                [paramsDic setValue:temp[1] forKey:temp[0]];
            }
            
            NSString *response = [NSString stringWithFormat:@"showResponse('%@', '%@')", paramsDic[@"uname"], paramsDic[@"password"]];
            [self.webview evaluateJavaScript:response completionHandler:^(id _Nullable response, NSError * _Nullable error) {
                if (error) {
                    NSLog(@"error");
                } else {
                    NSLog(@"success");
                }
            }];
        }
        
        return decisionHandler(WKNavigationActionPolicyCancel);
    }
}

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }])];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:prompt message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text = defaultText;
    }];
    [alertController addAction:([UIAlertAction actionWithTitle:@"完成" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(alertController.textFields[0].text?:@"");
    }])];

    [self presentViewController:alertController animated:YES completion:nil];
}

 - (void)setupJsBridge {
    if (self.bridge) return;
    // self.webview既可以是UIWebView，又可以是WKWebView
    self.bridge = [WebViewJavascriptBridge bridgeForWebView:self.webview];

    [self.bridge registerHandler:@"login" handler:^(id data, WVJBResponseCallback responseCallback) {
      if (data == nil || ![data isKindOfClass:[NSDictionary class]]) {
          NSDictionary *response = @{@"error": @(-1), @"message": @"调用参数有误"};
          responseCallback([[NSString alloc] initWithData:(NSData *)response encoding:NSUTF8StringEncoding]);
          return;
      }
      
      NSString *uname = data[@"uname"];
      NSString *password = data[@"password"];
      NSDictionary *response = @{@"error": @(0), @"message": @"登录成功", @"data" : [NSString stringWithFormat:@"执行登录操作，账号为：%@、密码为：@%@", uname, password]};
      
      [self.bridge callHandler:@"event-from-native" data:@"收到消息a啦" responseCallback:^(id responseData) {
          NSLog(@"message from h5: %@", responseData);
      }];
      
      responseCallback(response);
    }];
     
     [self.bridge registerHandler:@"getUserIdFromObjC" handler:^(id data, WVJBResponseCallback responseCallback) {
         NSDictionary *userInfo = @{
             @"uid": @"1234567890",
             @"token": @"abcdefg"
         };
         responseCallback([self dictionaryToJson:userInfo]);
     }];
     
     [self.bridge registerHandler:@"getUA" handler:^(id data, WVJBResponseCallback responseCallback) {
         responseCallback(@"iOS");
     }];
};

- (NSString*)dictionaryToJson:(NSDictionary *)dic {
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

@end
