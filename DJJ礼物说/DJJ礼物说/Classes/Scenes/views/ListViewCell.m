//
//  DetailHotViewController.m
//  DJJ礼物说
//
//  Created by lanou3g on 15/11/18.
//  Copyright © 2015年 小杜. All rights reserved.
//

#import "ListViewCell.h"

@implementation ListViewCell

- (void)setModel:(CommonModel *)model{
    self.titleImgView.layer.masksToBounds = YES;
    self.titleImgView.layer.cornerRadius = 10;
    
    self.imgeView.layer.masksToBounds = YES;
    self.imgeView.layer.cornerRadius = 5;
    
    [self.imgeView sd_setImageWithURL:[NSURL URLWithString:model.cover_image_url]];
    NSString *str = model.likes_count;
    self.sumberLable.text = [NSString stringWithFormat:@"%@",str];
//    NSLog(@"%@",str);
    
    self.titleLable.text = model.title;
}

@end
