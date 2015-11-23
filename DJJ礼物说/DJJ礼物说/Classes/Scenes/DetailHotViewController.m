//
//  DetailHotViewController.m
//  DJJ礼物说
//
//  Created by lanou3g on 15/11/18.
//  Copyright © 2015年 小杜. All rights reserved.
//

#import "DetailHotViewController.h"
#import <Social/Social.h>
#import "DataHandle.h"

@interface DetailHotViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) NSArray * dataArray;
@end

@implementation DetailHotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"商品详情";

    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    // 初始化分享按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_action_compact_share"] style:UIBarButtonItemStyleDone target:self action:@selector(share:)];
    
    [self customView];
    
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}


// 分享按钮触发的事件
- (void)share:(UIBarButtonItem *)sender
{
    
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"5650518e67e58e52030019e4"
                                      shareText:_hot.url
                                     shareImage:[UIImage imageNamed:@"1"]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToWechatSession,UMShareToQQ,nil]
                                       delegate:nil];

}

//-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
//{
//    //根据`responseCode`得到发送结果,如果分享成功
//    if(response.responseCode == UMSResponseCodeSuccess)
//    {
//        //得到分享到的微博平台名
//        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
//
//    }
//
//}


- (void)customView
{
    // 获取数组中的图片
    self.dataArray = _hot.image_urls;
    // 创建轮播图
    UIScrollView * scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kViewWidth, kViewHeight/2)];
    scroll.contentSize = CGSizeMake(kViewWidth*5, 0);
    scroll.pagingEnabled = YES;
    scroll.backgroundColor = [UIColor whiteColor];
    scroll.delegate = self;
    [self.view addSubview:scroll];
    
    for (int i = 0; i < 5; i++) {
        UIImageView * imgView = [[UIImageView alloc] initWithFrame:CGRectMake(kViewWidth*i, 0, kViewWidth, kViewHeight/2)];
        [imgView sd_setImageWithURL:[NSURL URLWithString:_hot.image_urls[i]]];
        [scroll addSubview:imgView];
        
    }

    UILabel * nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10+kViewHeight/2, kViewWidth-20, 30)];
    nameLabel.text = _hot.name;
//    nameLabel.backgroundColor = [UIColor redColor];
    [self.view addSubview:nameLabel];
    
    UILabel * priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 40+kViewHeight/2, kViewWidth-20, 30)];
    priceLabel.text = [NSString stringWithFormat:@"￥%@",_hot.price];
    priceLabel.textColor = [UIColor redColor];
    [self.view addSubview:priceLabel];
    
    UILabel * descripLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 70+kViewHeight/2, kViewWidth-20, 100)];
    descripLabel.text = _hot.despt;
    descripLabel.numberOfLines = 0;
    [self.view addSubview:descripLabel];
    
}

#pragma mark ----- 懒加载
- (NSArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSArray array];
    }
    return _dataArray;
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
