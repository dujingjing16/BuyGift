//
//  LoginViewController.m
//  DJJ礼物说
//
//  Created by lanou3g on 15/11/19.
//  Copyright © 2015年 小杜. All rights reserved.
//

#import "LoginViewController.h"
#import "RegistViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:248/255.0 green:79/255.0 blue:78/255.0 alpha:1];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.title = @"登录";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStyleDone target:self action:@selector(back:)];;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"注册" style:UIBarButtonItemStyleDone target:self action:@selector(goRegist)];
    
    [self customView];
    
}

- (void)customView
{
    UITextField * textField1 = [[UITextField alloc] initWithFrame:CGRectMake(0, 90, kViewWidth, 40)];
    textField1.placeholder = @"手机号";
    textField1.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:textField1];
    
    UITextField * textField2 = [[UITextField alloc] initWithFrame:CGRectMake(0, 130, kViewWidth, 40)];
    textField2.placeholder = @"密码";
    textField2.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:textField2];
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(20, 200, kViewWidth-40, 40);
    [btn setTitle:@"登录" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor colorWithRed:248/255.0 green:79/255.0 blue:78/255.0 alpha:0.8];
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 5;
    [self.view addSubview:btn];
    
}

- (void)back:(UIBarButtonItem *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)goRegist
{
    RegistViewController * registVC = [[RegistViewController alloc] init];
    [self.navigationController pushViewController:registVC animated:YES];
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
