//
//  DetailViewController.m
//  DJJ礼物说
//
//  Created by lanou3g on 15/11/18.
//  Copyright © 2015年 小杜. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView * webView;
@end

@implementation DetailViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.tabBarController.tabBar.tintColor = [UIColor redColor];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:248/255.0 green:79/255.0 blue:78/255.0 alpha:1];
    self.navigationItem.title = @"攻略详情";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    
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

- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
