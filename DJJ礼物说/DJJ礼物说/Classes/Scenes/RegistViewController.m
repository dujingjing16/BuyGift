//
//  RegistViewController.m
//  DJJ礼物说
//
//  Created by lanou3g on 15/11/23.
//  Copyright © 2015年 小杜. All rights reserved.
//

#import "RegistViewController.h"

@interface RegistViewController ()
@property (nonatomic, strong) UILabel * label;
@property (nonatomic, strong) UITextField * textField;

@end

@implementation RegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"注册";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(rigister:)];
    
    [self customView];

}

// 自定义视图
- (void)customView {
    
    NSArray *labelArray = @[@"用户名", @"密码", @"确认密码", @"邮箱", @"联系方式"];
    NSArray *textFieldArray = @[@"请输入用户名", @"请输入密码", @"请确认密码", @"请输入邮箱", @"请输入电话"];
    for (int i = 0 ; i < 5; i++) {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(50, 100 + 60 * i, 80, 40)];
        _label.text = labelArray[i];
        [self.view addSubview:_label];
        
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(130, 100 + 60 * i, 200, 40)];
        _textField.placeholder = textFieldArray[i];
        _textField.borderStyle = UITextBorderStyleRoundedRect;
        _textField.tag = 1001 + i; // 设定tag值，便于后面获取
        if (i == 1 || i == 2) {
            _textField.secureTextEntry = YES;
        }
        if (i == 3) {
            _textField.keyboardType = UIKeyboardTypeEmailAddress;
        }
        if (i == 4) {
            _textField.keyboardType = UIKeyboardTypeNumberPad;
        }
        [self.view addSubview:_textField];
    }
}

- (void)rigister:(UIBarButtonItem *)sender
{
    
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
