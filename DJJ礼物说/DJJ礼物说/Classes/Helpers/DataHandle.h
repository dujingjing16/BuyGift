//
//  DataHandle.h
//  礼物购
//
//  Created by lanou3g on 15/11/17.
//  Copyright © 2015年 小杜. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^myBlock)(id block);
@interface DataHandle : NSObject

@property (nonatomic, strong) NSMutableArray * dataArray;
@property (nonatomic, copy) myBlock block;

+ (instancetype)sharedHandle;

- (void)sharedDataWithURL:(NSString *)urlstr andBlock:(myBlock)block;

@end
