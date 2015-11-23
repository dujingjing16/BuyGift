//
//  ListViewController.h
//  DJJ礼物说
//
//  Created by lanou3g on 15/11/17.
//  Copyright © 2015年 小杜. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ListViewController;

@interface ListViewController : UITableViewController
{
    int a;
}
//存放model类的数组
@property (nonatomic, retain) NSMutableArray * dataArray;
//存放轮播图model类的数组
@property (nonatomic, retain) NSMutableArray * array;
@property (nonatomic, strong) NSString * url;
//滚动视图
@property (nonatomic, strong) UIScrollView * scrollView;
@property (nonatomic, strong) UIPageControl * page;
//定时器
@property (nonatomic, strong) NSTimer * timer;

@end
