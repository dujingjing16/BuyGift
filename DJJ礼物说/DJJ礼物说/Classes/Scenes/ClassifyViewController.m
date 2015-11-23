//
//  ClassifyViewController.m
//  DJJ礼物说
//
//  Created by lanou3g on 15/11/18.
//  Copyright © 2015年 小杜. All rights reserved.
//

#import "ClassifyViewController.h"
#import "ClassifyCell.h"
#import "ClassifyModel.h"
#import "DataHandle.h"
#import "ClassifyReusableView.h"
#import "DetailClassifyController.h"

@interface ClassifyViewController ()
@property (nonatomic, strong) NSMutableArray * array;
@property (nonatomic, strong) NSMutableArray * dataArray;
@property (nonatomic, strong) NSMutableDictionary * dataDic;
@property (nonatomic, strong) UISegmentedControl * segeControl;
@end

@implementation ClassifyViewController

static NSString * const reuseIdentifier1 = @"Cell1";

// header重用标识符
static NSString * headerIdentifier = @"headerReuse";

- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout
{
    if (self = [super initWithCollectionViewLayout:layout]) {
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"分类" image:[[UIImage imageNamed:@"ic_tab_category_normal"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] tag:1002];
        [self.tabBarItem setSelectedImage:[UIImage imageNamed:@"ic_tab_category_selected"]];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray * array = @[@"攻略",@"礼物"];
    // 初始化segmentedControl
    self.segeControl = [[UISegmentedControl alloc] initWithItems:array];
    // 设置属性
    _segeControl.frame = CGRectMake(kViewWidth/2-90, 5, 180, 30);
    _segeControl.tintColor = [UIColor whiteColor];
    _segeControl.selectedSegmentIndex = 0;
    [_segeControl addTarget:self action:@selector(segAction:) forControlEvents:UIControlEventValueChanged];
    [self.navigationController.navigationBar addSubview:_segeControl];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.tabBarController.tabBar.tintColor = [UIColor redColor];
//    self.navigationItem.title = @"分类";
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:248/255.0 green:79/255.0 blue:78/255.0 alpha:1];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"ClassifyCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier1];
    // 注册增补视图
    [self.collectionView registerNib:[UINib nibWithNibName:@"ClassifyReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentifier];
    
    [self dataPaser];
}

- (void)segAction:(UISegmentedControl *)sender
{
    if (self.segeControl.selectedSegmentIndex == 0) {
        
    }
}

- (void)dataPaser
{
    [[DataHandle sharedHandle] sharedDataWithURL:kURL_34 andBlock:^(id block) {
        NSDictionary *dic = block[@"data"];
        self.array = dic[@"channel_groups"];
        
        for (NSDictionary *dic in _array) {
            
            NSArray * smallArray = dic[@"channels"];
            NSString * nameStr = dic[@"name"];
            NSMutableArray * dataArray = [NSMutableArray array];
            for (NSDictionary * dic1 in smallArray) {
                ClassifyModel *model = [[ClassifyModel alloc] initWithDictionary:dic1];
                [dataArray addObject:model];
            }
            [self.dataDic setObject:dataArray forKey:nameStr];
//            NSLog(@"%@",_dataDic);
//            NSLog(@"%@",_dataArray);
        }
        
        [self.collectionView reloadData];
    }];
}

- (NSMutableDictionary *)dataDic
{
    if (_dataDic == nil) {
        _dataDic = [NSMutableDictionary dictionary];
    }
    return _dataDic;
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
    return _array.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    NSArray * arr = [_dataDic allKeys];
    NSString * key = arr[section];
    NSArray * array  = _dataDic[key];
//    NSLog(@"----%ld",array.count);
    return array.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ClassifyCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier1 forIndexPath:indexPath];
    
    NSArray * arr = [_dataDic allKeys];
    NSString * key = arr[indexPath.section];
    NSArray * array  = _dataDic[key];
//    NSLog(@"%ld",array.count);
    ClassifyModel * claModel = array[indexPath.row];
    cell.nameLabel.text = claModel.name;
    cell.imgView.layer.masksToBounds = YES;
    cell.imgView.layer.cornerRadius = 20;
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:claModel.icon_url]];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(60, 100);
}

//设置item内间距大小(顺序是上左下右)
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(5, 20, 0, 25);
}

// 返回增补视图

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    // 从重用池里面取出来
    ClassifyReusableView  * headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentifier forIndexPath:indexPath];
    NSArray * arr = [_dataDic allKeys];
    headerView.headerLabel.text = arr[indexPath.section];
    return headerView;

}

// 设置header的高度(不设置的话出不来)
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    CGSize size = CGSizeMake(kViewWidth, 50);
    return size;
}


#pragma mark <UICollectionViewDelegate>

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    DetailClassifyController * detaVC = [[DetailClassifyController alloc] init];
    NSArray * arr = [_dataDic allKeys];
    
    NSString * key = arr[indexPath.section];
    NSArray * array  = _dataDic[key];
//    NSLog(@"%ld",array.count);
    ClassifyModel * claModel = array[indexPath.row];
    NSString * url = [NSString stringWithFormat:kURL_CLASSIFY,claModel.ID];
    detaVC.urlStr = url;
    
    [self.navigationController pushViewController:detaVC animated:YES];
    
}


@end
