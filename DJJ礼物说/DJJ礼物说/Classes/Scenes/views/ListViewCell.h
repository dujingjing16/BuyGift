//
//  DetailHotViewController.m
//  DJJ礼物说
//
//  Created by lanou3g on 15/11/18.
//  Copyright © 2015年 小杜. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonModel.h"
@interface ListViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *imgeView;
@property (strong, nonatomic) IBOutlet UILabel *titleLable;
@property (strong, nonatomic) IBOutlet UIImageView *titleImgView;
@property (strong, nonatomic) IBOutlet UIImageView *favImgView;

@property (strong, nonatomic) IBOutlet UILabel *sumberLable;

@property (nonatomic, strong) CommonModel * model;

@end
