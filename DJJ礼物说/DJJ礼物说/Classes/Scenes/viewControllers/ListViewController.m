//
//  ListViewController.m
//  DJJ礼物说
//
//  Created by lanou3g on 15/11/17.
//  Copyright © 2015年 小杜. All rights reserved.
//

#import "ListViewController.h"
#import "CommonModel.h"
#import "ListViewCell.h"
#import "DataHandle.h"
#import "CarouselModel.h"
#import "DetailViewController.h"

@interface ListViewController ()

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"ListViewCell" bundle:nil] forCellReuseIdentifier:@"1"];
    // 添加tableview的头视图
    if ([self.url isEqualToString:kURL_1]) {
        self.tableView.tableHeaderView = [self customHeaderView];
    }
    [self requestDataWithURLStr:[NSString stringWithFormat:_url,0]];
    a = 0;
    // 集成刷新控件
    [self setupRefresh];
}

- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    
    // 自动刷新(一进入程序就下拉刷新)
    [self.tableView headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
}

#pragma mark --- 懒加载
- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (NSMutableArray *)array
{
    if (_array == nil) {
        _array = [NSMutableArray array];
    }
    return _array;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 160;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"1" forIndexPath:indexPath];
    CommonModel *model = _dataArray[indexPath.row];
    cell.model =  model;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController * detailVC = [[DetailViewController alloc] init];
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:detailVC];
    CommonModel * common = _dataArray[indexPath.row];
    detailVC.url = common.url;
    // 已经模态一个界面了，不能再模态一个界面了
//    [self presentViewController:nav animated:YES completion:nil];
    [self.view.window.rootViewController presentViewController:nav animated:NO completion:nil];
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    NSString * strPath = [NSString stringWithFormat:_url, 0];
    [self requestDataWithURLStr:strPath];
    
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.tableView reloadData];
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.tableView headerEndRefreshing];
    });
}

- (void)footerRereshing
{
    a+=20;
    NSString * strPath = [NSString stringWithFormat:_url, a];
    [self requestDataWithURLStr:strPath];
    
    // 2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        // 刷新表格
        [self.tableView reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.tableView footerEndRefreshing];
    });
}

// 数据解析
- (void) requestDataWithURLStr:(NSString *)url
{
    [[DataHandle sharedHandle] sharedDataWithURL:url andBlock:^(id block) {
        if (_dataArray.count) {
            [_dataArray removeLastObject];
        }
        NSDictionary *dic =[(NSMutableDictionary *)block objectForKey:@"data"];
        NSArray *array = dic[@"items"];
        for (NSDictionary *dic in array) {
            CommonModel * model = [[CommonModel alloc] initWithDictionary:dic];
            [_dataArray addObject:model];
        }
//        NSLog(@"%ld",_dataArray.count);
        [self.tableView reloadData];
    }];
}

// 轮播图
- (UIView *)customHeaderView
{
    [[DataHandle sharedHandle] sharedDataWithURL:kURL_2 andBlock:^(id block) {
        NSDictionary * dataDict = [(NSMutableDictionary *)block objectForKey:@"data"];
        //        NSLog(@"获得数据成功");
        NSArray *array = dataDict[@"banners"];
        for (int i = 0; i < array.count; i++) {
            CarouselModel *carModel = [CarouselModel new];
            [carModel setValuesForKeysWithDictionary:array[i]];
            
            UIImageView * imgView = [[UIImageView alloc] initWithFrame:CGRectMake(kViewWidth*i, 0, kViewWidth, 160)];
            [imgView sd_setImageWithURL:[NSURL URLWithString:carModel.image_url]];
            [_scrollView addSubview:imgView];
            [self.array addObject:carModel];
        }
    }];
    
    // 创建一个view，将scrollView和pageControl添加到view上，再将view设为tableview的头视图
    UIView * view =[[UIView alloc] initWithFrame:CGRectMake(0, 42, kViewWidth, 180)];
    // 创建scrollView
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kViewWidth, 160)];
    _scrollView.contentSize = CGSizeMake(6*kViewWidth, 160);
    _scrollView.delegate = self;
    //整页翻动
    _scrollView.pagingEnabled = YES;
    _scrollView.backgroundColor = [UIColor whiteColor];
    
    [view addSubview:_scrollView];
    // 创建pageControl
    self.page = [[UIPageControl alloc] initWithFrame:CGRectMake(240, 140, 150, 20)];
    _page.currentPageIndicatorTintColor = [UIColor redColor];
    _page.numberOfPages = 5;
    _page.currentPage = 0;
    _page.pageIndicatorTintColor = [UIColor whiteColor];
    [_page addTarget:self action:@selector(pageAction:) forControlEvents:UIControlEventValueChanged];
    [view addSubview:_page];
    
    // 添加计时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
    
    return view;
}

- (void)timerAction:(NSTimer *)sender{
    static int i = 0;
    i++;
    if (i == 5) {
        i = 0;
    }
    _scrollView.contentOffset = CGPointMake(kViewWidth*i, 0);
    _page.currentPage = i;
}

- (void)pageAction:(UIPageControl *)sender
{
    NSInteger index = sender.currentPage;
    _scrollView.contentOffset = CGPointMake(kViewWidth*index, 0);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x/kViewWidth;
    _page.currentPage = index;
}



@end
