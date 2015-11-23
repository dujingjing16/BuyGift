//
//  HotViewController.m
//  DJJ礼物说
//
//  Created by lanou3g on 15/11/18.
//  Copyright © 2015年 小杜. All rights reserved.
//

#import "HotViewController.h"
#import "HotModel.h"
#import "ListCollectionViewCell.h"
#import "DataHandle.h"
#import "DetailHotViewController.h"

#define MJRandomColor [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1]

@interface HotViewController ()
@property (nonatomic, retain)NSMutableArray *dataArray;
@end

@implementation HotViewController

static NSString * const reuseIdentifier = @"Cell";

- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout
{
    if (self = [super initWithCollectionViewLayout:layout]) {
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"热门" image:[[UIImage imageNamed:@"ic_tab_select_normal"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] tag:1001];
        [self.tabBarItem setSelectedImage:[UIImage imageNamed:@"ic_tab_select_selected"]];
        
    }
    return self;
}

- (void)viewDidLoad {
   [super viewDidLoad];
   
   self.collectionView.backgroundColor = [UIColor whiteColor];
   self.tabBarController.tabBar.tintColor = [UIColor redColor];
   self.navigationItem.title = @"热门";
   
   self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:248/255.0 green:79/255.0 blue:78/255.0 alpha:1];
   //    self.useLayoutToLayoutNavigationTransitions = YES;
   
   [self.collectionView registerNib:[UINib nibWithNibName:@"ListCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
   
   offset = 0;
   [self dataPaser];
   
   [self addHeader];
   [self addFooter];
}

- (void)dataPaser
{
   offset+=3;
   NSString* strPath = [NSString stringWithFormat:kURL_10,offset];
    [[DataHandle sharedHandle] sharedDataWithURL:strPath andBlock:^(id block) {
        NSDictionary *dic = block[@"data"];
        NSArray *array = dic[@"items"];

        for (NSDictionary *dic in array) {
            HotModel *model = [[HotModel alloc] initWithDictionary:dic[@"data"]];
            [self.dataArray addObject:model];
        }
        [self.collectionView reloadData];
    }];

}

- (void)addHeader
{
   __weak typeof(self) vc = self;
   // 添加下拉刷新头部控件
   [self.collectionView addHeaderWithCallback:^{
      // 进入刷新状态就会回调这个Block
      
      //重新加载数据
//      [vc dataPaser];
      NSString* strPath = [NSString stringWithFormat:kURL_10,0];
      [[DataHandle sharedHandle] sharedDataWithURL:strPath andBlock:^(id block) {
         NSDictionary *dic = block[@"data"];
         
         NSArray *array = dic[@"items"];
         
         for (NSDictionary *dic in array) {
            
            HotModel *model = [[HotModel alloc] initWithDictionary:dic[@"data"]];
            [vc.dataArray addObject:model];
         }
         [vc.collectionView reloadData];
      }];
      
      // 模拟延迟加载数据，因此2秒后才调用）
      dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
         [vc.collectionView reloadData];
         // 结束刷新
         [vc.collectionView headerEndRefreshing];
      });
   }];
   
#warning 自动刷新(一进入程序就下拉刷新)
   [self.collectionView headerBeginRefreshing];
}

- (void)addFooter
{
   __weak typeof(self) vc = self;
   // 添加上拉刷新尾部控件
   [self.collectionView addFooterWithCallback:^{
      // 进入刷新状态就会回调这个Block
      
      //重新加载数据
      [vc dataPaser];
      
      // 模拟延迟加载数据，因此2秒后才调用）
      dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
         [vc.collectionView reloadData];
         // 结束刷新
         [vc.collectionView footerEndRefreshing];
      });
   }];
}


- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
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

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    HotModel *hot = self.dataArray[indexPath.row];
    
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:hot.cover_image_url]];
    cell.imgView.layer.masksToBounds = YES;
    cell.imgView.layer.cornerRadius = 5;
    cell.nameLable.text = hot.name;
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(170, 200);
}

//设置item内间距大小(顺序是上左下右)
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(5, 10, 0, 15);
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
   HotModel * hot = _dataArray[indexPath.row];
   DetailHotViewController * detailVC = [[DetailHotViewController alloc] init];
   detailVC.hot = hot;
   [self.navigationController pushViewController:detailVC animated:YES];
}

// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}




/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
