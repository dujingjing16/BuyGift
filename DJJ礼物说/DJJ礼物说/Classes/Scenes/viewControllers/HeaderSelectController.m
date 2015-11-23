//
//  HeaderSelectController.m
//  DJJ礼物说
//
//  Created by lanou3g on 15/11/17.
//  Copyright © 2015年 小杜. All rights reserved.
//

#import "HeaderSelectController.h"
#import "ListViewController.h"
#import "SearchViewController.h"

@interface HeaderSelectController ()<SUNSlideSwitchViewDelegate>
//列表
@property (nonatomic, strong) ListViewController *vc1;
@property (nonatomic, strong) ListViewController *vc2;
@property (nonatomic, strong) ListViewController *vc3;
@property (nonatomic, strong) ListViewController *vc4;
@property (nonatomic, strong) ListViewController *vc5;
@property (nonatomic, strong) ListViewController *vc6;
@property (nonatomic, strong) ListViewController *vc7;

@end

@implementation HeaderSelectController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:[[UIImage imageNamed:@"ic_tab_home_normal"]imageWithRenderingMode:UIImageRenderingModeAutomatic] tag:1000];
        [self.tabBarItem setSelectedImage:[UIImage imageNamed:@"ic_tab_home_selected"]];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"abc_ic_search"] style:UIBarButtonItemStyleDone target:self action:@selector(search)];
        
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Left" style:UIBarButtonItemStylePlain target:self action:@selector(presentLeftMenuViewController:)];
    }
    return self;

}

- (void)search{

    SearchViewController * searchVC = [[SearchViewController alloc] init];
    UINavigationController * searchNC = [[UINavigationController alloc] initWithRootViewController:searchVC];
    [self presentViewController:searchNC animated:YES completion:nil];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.tabBarController.tabBar.tintColor = [UIColor redColor];
    self.navigationItem.title = @"礼物说";
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:248/255.0 green:79/255.0 blue:78/255.0 alpha:1];
    
    [self initSliderSwitchView];
    
    
}

// 初始化头部点击的视图
- (void)initSliderSwitchView
{    
    self.slideSwitchView = [[SUNSlideSwitchView alloc] initWithFrame:self.view.frame];
    _slideSwitchView.slideSwitchViewDelegate = self;
    [self.view addSubview:_slideSwitchView];
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    //设置滑块文字的属性
    self.slideSwitchView.tabItemNormalColor = [SUNSlideSwitchView colorFromHexRGB:@"868686"];
    self.slideSwitchView.tabItemSelectedColor = [SUNSlideSwitchView colorFromHexRGB:@"000000"];
    self.slideSwitchView.shadowImage = [UIImage imageNamed:@"red_line_and_shadow.png"];
    
    //设置滑动标题
    self.vc1 = [[ListViewController alloc] initWithStyle:UITableViewStylePlain];
    self.vc1.title = @"精选";
    _vc1.url = kURL_1;
    
    self.vc2 = [[ListViewController alloc] initWithStyle:UITableViewStylePlain];
    self.vc2.title = @"礼物";
    _vc2.url = kURL_4;
    
    self.vc3 = [[ListViewController alloc] initWithStyle:UITableViewStylePlain];
    self.vc3.title = @"海淘";
    _vc3.url = kURL_8;
    
    self.vc4 = [[ListViewController alloc] initWithStyle:UITableViewStylePlain];
    self.vc4.title = @"美食";
    _vc4.url = kURL_5;
    
    self.vc5 = [[ListViewController alloc] initWithStyle:UITableViewStylePlain];
    self.vc5.title = @"数码";
    _vc5.url = kURL_6;
    
    self.vc6 = [[ListViewController alloc] initWithStyle:UITableViewStylePlain];
    self.vc6.title = @"运动";
    _vc6.url = kURL_7;
    
    [self.slideSwitchView buildUI];
    
}

//设置按钮的个数
- (NSUInteger)numberOfTab:(SUNSlideSwitchView *)view
{
    return 6;
}

#pragma mark ------- SUNSlideSwitchViewDelegate
//根据点击按钮的下标切换到对应的视图控制器
- (UIViewController *)slideSwitchView:(SUNSlideSwitchView *)view viewOfTab:(NSUInteger)number
{
    if (number == 0) {
        return self.vc1;
    } else if (number == 1) {
        return self.vc2;
    } else if (number == 2) {        
        return self.vc3;
    } else if (number == 3) {
        return self.vc4;
    } else if (number == 4) {
        return self.vc5;
    } else if (number == 5) {
        return self.vc6;
    }else{
        return nil;
    }
    
}
//点击某的下标的按钮
- (void)slideSwitchView:(SUNSlideSwitchView *)view didselectTab:(NSUInteger)number
{
    ListViewController *vc = nil;
    if (number == 0) {
        vc = self.vc1;
    } else if (number == 1) {
        vc = self.vc2;
    } else if (number == 2) {
        vc = self.vc3;
    } else if (number == 3) {
        vc = self.vc4;
    } else if (number == 4) {
        vc = self.vc5;
    } else if (number == 5) {
        vc = self.vc6;
    } else if (number == 6) {
        vc = self.vc7;
    }
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
