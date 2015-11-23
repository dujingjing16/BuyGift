//
//  HotModel.m
//  DJJ礼物说
//
//  Created by lanou3g on 15/11/18.
//  Copyright © 2015年 小杜. All rights reserved.
//

#import "HotModel.h"

@implementation HotModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"description"]) {
        self.despt = value;
    }
}

- (instancetype) initWithDictionary:(NSDictionary *)dic{
    
    self = [[HotModel alloc] init];
    
    [self setValuesForKeysWithDictionary:dic];
    
    return self;
}

@end
