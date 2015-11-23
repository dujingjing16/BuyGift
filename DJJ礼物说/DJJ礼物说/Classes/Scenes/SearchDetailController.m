//
//  SearchDetailController.m
//  DJJ礼物说
//
//  Created by lanou3g on 15/11/21.
//  Copyright © 2015年 小杜. All rights reserved.
//

#import "SearchDetailController.h"

@interface SearchDetailController ()

@end

@implementation SearchDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"商品详情";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:248/255.0 green:79/255.0 blue:78/255.0 alpha:1];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];

    [self customView];
}

- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)customView
{
    
    UIImageView * imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 49, kViewWidth, self.view.frame.size.height/2-49)];
    
    [imgView sd_setImageWithURL:[NSURL URLWithString:_result.cover_image_url]];
    [self.view addSubview:imgView];
    
    UILabel * nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10+self.view.frame.size.height/2, kViewWidth-20, 30)];
    nameLabel.text = _result.name;
    //    nameLabel.backgroundColor = [UIColor redColor];
    [self.view addSubview:nameLabel];
    
    UILabel * priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 40+self.view.frame.size.height/2, kViewWidth-20, 30)];
    priceLabel.text = [NSString stringWithFormat:@"￥%@",_result.price];
    priceLabel.textColor = [UIColor redColor];
    [self.view addSubview:priceLabel];
    
    UILabel * descripLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 70+self.view.frame.size.height/2, kViewWidth-20, 100)];
    descripLabel.text = _result.descrip;
    descripLabel.numberOfLines = 0;
    [self.view addSubview:descripLabel];
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
