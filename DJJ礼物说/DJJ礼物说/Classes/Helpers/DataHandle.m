//
//  DataHandle.m
//  礼物购
//
//  Created by lanou3g on 15/11/17.
//  Copyright © 2015年 小杜. All rights reserved.
//

#import "DataHandle.h"


static DataHandle *dataHandle =nil;
@implementation DataHandle

+(DataHandle *)sharedHandle {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dataHandle = [DataHandle new];
        
    });
    return dataHandle;
    
}

- (void)sharedDataWithURL:(NSString *)urlstr andBlock:(myBlock)block
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:urlstr parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        block(responseObject);
        
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        block(nil);
        
    }];
}

- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}



@end
