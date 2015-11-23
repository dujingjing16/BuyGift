//
//  RootTabBarController.m
//  礼物购
//
//  Created by lanou3g on 15/11/16.
//  Copyright © 2015年 小杜. All rights reserved.
//

#import "RootTabBarController.h"
#import "UserController.h"
#import "ClassifyViewController.h"
#import "HotViewController.h"
#import "ListViewController.h"
#import "HeaderSelectController.h"

@interface RootTabBarController ()

@end

@implementation RootTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    HeaderSelectController * homeVC = [[HeaderSelectController alloc] init];
    UINavigationController * homeNC = [[UINavigationController alloc] initWithRootViewController:homeVC];
    
    // 创建集合视图之前必须要先设置布局
    UICollectionViewFlowLayout * flowLayout2 = [[UICollectionViewFlowLayout alloc] init];
    ClassifyViewController * classifyVC = [[ClassifyViewController alloc] initWithCollectionViewLayout:flowLayout2];
    UINavigationController * classifyNC = [[UINavigationController alloc] initWithRootViewController:classifyVC];
    
    // 创建集合视图之前必须要先设置布局
    UICollectionViewFlowLayout * flowLayout1 = [[UICollectionViewFlowLayout alloc] init];
    HotViewController * hotVC = [[HotViewController alloc] initWithCollectionViewLayout:flowLayout1];
    UINavigationController * hotNC = [[UINavigationController alloc] initWithRootViewController:hotVC];
    
    UserController * userVC = [[UserController alloc] init];
    self.viewControllers = @[homeNC,hotNC,classifyNC,userVC];
//    self.tabBarController.selectedIndex = 1;
    self.tabBar.barStyle = UIBarStyleDefault;
    
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
