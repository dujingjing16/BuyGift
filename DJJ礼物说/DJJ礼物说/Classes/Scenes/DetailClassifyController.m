//
//  DetailClassifyController.m
//  DJJ礼物说
//
//  Created by lanou3g on 15/11/20.
//  Copyright © 2015年 小杜. All rights reserved.
//

#import "DetailClassifyController.h"
#import "ListViewCell.h"
#import "DataHandle.h"
#import "NextDetailController.h"

@interface DetailClassifyController ()
@property (nonatomic, strong) NSMutableArray * dataArray;

@end

@implementation DetailClassifyController

static NSString * detailIdent = @"detail";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.tableView registerNib:[UINib nibWithNibName:@"ListViewCell" bundle:nil] forCellReuseIdentifier:detailIdent];
    
    [self requestDataWithURLStr:_urlStr];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:detailIdent forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    CommonModel * common = _dataArray[indexPath.row];
    cell.model = common;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NextDetailController * nextVC = [[NextDetailController alloc] init];
    CommonModel * common = _dataArray[indexPath.row];
    nextVC.url = common.url;
    [self.navigationController pushViewController:nextVC animated:YES];
}


// 数据解析
- (void)requestDataWithURLStr:(NSString *)url
{
    [[DataHandle sharedHandle] sharedDataWithURL:url andBlock:^(id block) {
        
        NSDictionary *dic =[(NSMutableDictionary *)block objectForKey:@"data"];
        NSArray *array = dic[@"items"];
        for (NSDictionary *dic in array) {
            CommonModel * model = [[CommonModel alloc] initWithDictionary:dic];
            [self.dataArray addObject:model];
        }
        [self.tableView reloadData];
        
    }];
}

- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
