//
//  CommonModel.m
//  DJJ礼物说
//
//  Created by lanou3g on 15/11/17.
//  Copyright © 2015年 小杜. All rights reserved.
//

#import "CommonModel.h"

@implementation CommonModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        
        self.ID = value;
    }
}

- (instancetype) initWithDictionary:(NSDictionary *)dic{
    
    self = [[CommonModel alloc] init];
    
    [self setValuesForKeysWithDictionary:dic];
    
    return self;
}


@end
