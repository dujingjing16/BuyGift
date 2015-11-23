//
//  SearchViewController.m
//  DJJ礼物说
//
//  Created by lanou3g on 15/11/21.
//  Copyright © 2015年 小杜. All rights reserved.
//

#import "SearchViewController.h"
#import "DataHandle.h"
#import "SearchResultController.h"

@interface SearchViewController ()<UISearchBarDelegate>
// 搜索框
@property (nonatomic, strong) UISearchBar * search;
@property (nonatomic, strong) NSString * placeholder;
@property (nonatomic, strong) NSArray * array;
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:248/255.0 green:79/255.0 blue:78/255.0 alpha:1];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(20, 80, 200, 30)];
    label.text = @"大家都在搜这些：";
    label.textColor = [UIColor darkGrayColor];
    label.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:label];
    [self addSearchView];
    [self addButton];

    
}

- (void)goBack
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)addSearchView
{
    self.search = [[UISearchBar alloc] initWithFrame:CGRectMake(10, 5, kViewWidth-60, 30)];
    _search.showsSearchResultsButton = YES;
    _search.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _search.autocorrectionType = UITextAutocorrectionTypeDefault;
    _search.delegate = self;
    _search.placeholder = @"选份礼物给最爱的人";
    [self.navigationController.navigationBar addSubview:_search];
}

- (void)addButton
{
    self.array = @[@"戒指",@"手机壳",@"双肩包",@"钱包",@"情侣",@"手表",@"泳衣",@"杯子",@"手链",@"樱花",@"手工",@"项链"];
    for (int i = 0; i < 4; i++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(20+90*i, 120, 70, 40);
        btn.backgroundColor = [UIColor lightGrayColor];
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 10;
        [btn setTitle:_array[i] forState:UIControlStateNormal];
        btn.tag = 100+i;
        [btn addTarget:self action:@selector(next:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
    
    for (int i = 0; i < 4; i++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(20+90*i, 180, 70, 40);
        btn.backgroundColor = [UIColor lightGrayColor];
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 10;
        [btn setTitle:_array[i+4] forState:UIControlStateNormal];
        btn.tag = 100+i+4;
        [btn addTarget:self action:@selector(next:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
    
    
    for (int i = 0; i < 4; i++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(20+90*i, 240, 70, 40);
        btn.backgroundColor = [UIColor lightGrayColor];
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 10;
        [btn setTitle:_array[i+8] forState:UIControlStateNormal];
        btn.tag = 100+i+8;
        [btn addTarget:self action:@selector(next:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }

}

- (void)next:(UIButton *)sender
{
    UICollectionViewFlowLayout * fl = [[UICollectionViewFlowLayout alloc] init];
    SearchResultController * result = [[SearchResultController alloc] initWithCollectionViewLayout:fl];
    result.str = [NSString stringWithFormat:@"%ld",sender.tag-100];
    [self.navigationController pushViewController:result animated:YES];
}

#pragma mark --- UISearchBar的代理方法

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    return YES;
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    return YES;
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSLog(@"%@",searchText);
    // 创建谓词(cd表示不区分大小写)
    // 判断是否包含输入的字符串
    // 通过判断初始化一个谓词
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"self contains[cd] %@",searchText];
    // 判断是否以输入的字符开始
    //    NSPredicate * predicate1 = [NSPredicate predicateWithFormat:@"self beginswith[cd] %@",searchText];
    BOOL result = [predicate evaluateWithObject:@"手表"];   // 判断的对象
    NSLog(@"result = %@",result?@"yes":@"no");

    if (result) {
        SearchResultController * searchR = [[SearchResultController alloc] init];
        searchR.str = @"手表";
    }
    
}
- (BOOL)searchBar:(UISearchBar *)SearchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
//    NSString *str = [[SearchBar.text stringByReplacingCharactersInRange:range withString:text] stringByReplacingOccurrencesOfString:@"\xE2\x80\x86" withString:@""];
    
    return YES;
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
