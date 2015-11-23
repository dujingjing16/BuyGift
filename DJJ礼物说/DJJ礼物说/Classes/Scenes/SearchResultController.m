//
//  SearchResultController.m
//  DJJ礼物说
//
//  Created by lanou3g on 15/11/21.
//  Copyright © 2015年 小杜. All rights reserved.
//

#import "SearchResultController.h"
#import "DataHandle.h"
#import "SearchResult.h"
#import "ListCollectionViewCell.h"
#import "SearchDetailController.h"

@interface SearchResultController ()
@property (nonatomic, strong) NSMutableArray * dataArray;
@end

@implementation SearchResultController

static NSString * const identifier = @"RusultCell";

- (void)viewWillAppear:(BOOL)animated
{
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",kURL_SEARCH,_str];
        NSLog(@"%@",urlStr);
    [self dataPaserWithURL:urlStr];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"ListCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:identifier];
    
}

- (void)goBack
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dataPaserWithURL:(NSString *)url
{
    [[DataHandle sharedHandle] sharedDataWithURL:url andBlock:^(id block) {
        NSDictionary * dictionary = [(NSMutableDictionary *)block objectForKey:@"data"];
        NSArray * array = dictionary[@"items"];
        for (NSDictionary * dic in array) {
            SearchResult * result = [SearchResult new];
            [result setValuesForKeysWithDictionary:dic];
            [self.dataArray addObject:result];
        }
//        NSLog(@"==%ld",_dataArray.count);
        [self.collectionView reloadData];
    }];
}

#pragma mark ----- 懒加载

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


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    SearchResult * result = _dataArray[indexPath.row];
    cell.imgView.layer.masksToBounds = YES;
    cell.imgView.layer.cornerRadius = 5;
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:result.cover_image_url]];
    cell.nameLable.text = result.name;
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(170, 200);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 10, 0, 15);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    SearchResult * result = _dataArray[indexPath.row];
    SearchDetailController * detailVC = [[SearchDetailController alloc] init];
    UINavigationController * detaNC = [[UINavigationController alloc] initWithRootViewController:detailVC];
    detailVC.result = result;
    [self.navigationController presentViewController:detaNC animated:YES completion:nil];
}

@end
