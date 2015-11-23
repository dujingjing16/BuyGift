//
//  UserController.m
//  礼物购
//
//  Created by lanou3g on 15/11/16.
//  Copyright © 2015年 小杜. All rights reserved.
//

#import "UserController.h"
#import "MyCell.h"
#import "LoginViewController.h"


@interface UserController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView * tableView;

//@property (nonatomic, assign) BOOL isNight;
@end

@implementation UserController

static NSString * ident = @"myCell";

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的" image:[[UIImage imageNamed:@"ic_tab_profile_normal_male"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] tag:1003];
        [self.tabBarItem setSelectedImage:[UIImage imageNamed:@"ic_tab_profile_selected_male"]];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.tintColor = [UIColor redColor];
    
    [self addView];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kViewHeight/2-50, kViewWidth, 500) style:UITableViewStylePlain];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MyCell" bundle:nil] forCellReuseIdentifier:ident];
    
    [self.view addSubview:_tableView];
    
    @weakify(self);
    [self addColorChangedBlock:^{
        @strongify(self);
        self.view.normalBackgroundColor = [UIColor whiteColor];
        self.view.nightBackgroundColor = UIColorFromRGB(0x343434);
        self.tableView.normalBackgroundColor = [UIColor whiteColor];
        self.tableView.nightBackgroundColor = UIColorFromRGB(0x343434);
//        self.navigationController.navigationBar.nightTintColor = [UIColor redColor];
    }];

    
}

- (void)addView{
    UIImageView * imgView= [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kViewWidth, kViewHeight/2-50)];
    imgView.image = [UIImage imageNamed:@"bg_profile"];
    imgView.alpha = 0.7;
    // imageView默认是不可以点击的
    imgView.userInteractionEnabled = YES;
    [self.view addSubview:imgView];
    
    UIButton * btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setImage:[UIImage imageNamed:@"ig_profile_photo_default"] forState:UIControlStateNormal];
    btn1.frame = CGRectMake(kViewWidth/2-50, kViewHeight/4-100, 100, 100);
    [btn1 addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    [imgView addSubview:btn1];
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"请登录" forState:UIControlStateNormal];
    btn.frame = CGRectMake(kViewWidth/2-50, kViewHeight/4+30, 100, 40);
    [btn addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    [imgView addSubview:btn];

    UIButton * setingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    setingBtn.frame = CGRectMake(kViewWidth-40, 20, 30, 30);
//    setingBtn.backgroundColor = [UIColor redColor];
    [setingBtn setImage:[UIImage imageNamed:@"setting"] forState:UIControlStateNormal];
    [setingBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [imgView addSubview:setingBtn];
    
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyCell * cell = [tableView dequeueReusableCellWithIdentifier:ident forIndexPath:indexPath];
    cell.imgView.layer.masksToBounds = YES;
    cell.imgView.layer.cornerRadius = 5;
    // 隐藏cell的分割线
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (indexPath.row == 0) {
        cell.listCell.text = @"我的收藏";
        cell.imgView.image = [UIImage imageNamed:@"ic_action_favourite_pressed"];
    }else if (indexPath.row == 1){
        cell.listCell.text = @"我的订单";
        cell.imgView.image = [UIImage imageNamed:@"ic_more_credit"];
    }else if (indexPath.row == 2){
        cell.listCell.text = @"夜间模式";
        cell.imgView.image = [UIImage imageNamed:@"ic_more_night_mode"];
        
        UISwitch * swich = [[UISwitch alloc] initWithFrame:CGRectMake(300, 7, 20, 20)];
        [swich addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventValueChanged];
//        _isNight = YES;
        [cell addSubview:swich];
        
    }else {
        cell.listCell.text = @"清除缓存";
        cell.imgView.image = [UIImage imageNamed:@"ic_more_action_clean_cache"];
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(300, 15, 75, 20)];
//        label.text = @"0KB";
        label.tag = 1000;
        float fileSize=(float)[self fileSize];
        label.text=[NSString stringWithFormat:@"%.2fKB",fileSize];
        [cell addSubview:label];
    }
    
    [self addColorChangedBlock:^{
        cell.normalBackgroundColor = [UIColor whiteColor];
        cell.nightBackgroundColor = UIColorFromRGB(0x343434);
    }];

    return cell;
}

// 夜间模式
- (void)valueChange:(UISwitch *)sender
{
    if ([DKNightVersionManager currentThemeVersion] == DKThemeVersionNight) {
        [DKNightVersionManager dawnComing];
    } else {
        [DKNightVersionManager nightFalling];
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 3) {
        UILabel * label = (UILabel *)[self.view viewWithTag:1000];
        //求目录下文件的大小
        label.text = @"0.00KB";
        [self removeFile];
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"已清空缓存" message:@"点击继续" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alter show];
    }
    
}

- (void)login:(UIButton *)sender
{
    LoginViewController * loginVC = [[LoginViewController alloc] init];
    UINavigationController * loginNC = [[UINavigationController alloc] initWithRootViewController:loginVC];
    [self presentViewController:loginNC animated:YES completion:nil];
}

- (void)btnAction:(UIButton *)sender
{
    
}

-(float)fileSize//计算文件夹下文件的总大小
{
    NSFileManager *mgr = [NSFileManager defaultManager];
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    //    NSLog(@"%@", cachePath);
    // 获得缓存文件总大小
    // 获得所有的子路径
    NSArray *subArr = [mgr subpathsAtPath:cachePath];
    long long size = 0;
    for (NSString *subPath in subArr) {
        NSString *fullPath = [cachePath stringByAppendingPathComponent:subPath];
        BOOL dir = NO;
        [mgr fileExistsAtPath:fullPath isDirectory:&dir];
        if (dir == 0) {
            size += [[mgr attributesOfItemAtPath:fullPath error:nil][NSFileSize] longLongValue];
        }
    }
    CGFloat sizeKB = size/1024/1024.0;
    return sizeKB;
}

-(void)removeFile
{
    // 清除缓存
    NSFileManager *mgr = [NSFileManager defaultManager];
    // 主cache路径
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    
    NSArray *subArr = [mgr subpathsAtPath:cachePath];
    // 找到所有文件和文件夹
    for (NSString *subPath in subArr) {
        // 拼接全路径
        NSString *fullPath = [cachePath stringByAppendingPathComponent:subPath];
        [mgr removeItemAtPath:fullPath error:nil];
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
