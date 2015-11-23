//
//  NextDetailController.m
//  DJJ礼物说
//
//  Created by lanou3g on 15/11/20.
//  Copyright © 2015年 小杜. All rights reserved.
//

#import "NextDetailController.h"

@interface NextDetailController ()
@property (nonatomic, strong) UIWebView * webView;
@end

@implementation NextDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
#pragma mark — WebView
    // 添加webView
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kViewWidth, kViewHeight + 65)];
    // 创建请求对象
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:_url]];
    //    NSLog(@"%@",_url);
    // 取消反弹
    self.webView.scrollView.bounces = NO;
    // 对页面进项自适应操作
    _webView.scalesPageToFit = YES;
    
    //    self.webView.delegate = self;
    [_webView loadRequest:request];
    
    [self.view addSubview:_webView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
