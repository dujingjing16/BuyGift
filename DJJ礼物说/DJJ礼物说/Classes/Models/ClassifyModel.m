//
//  ClassifyModel.m
//  DJJ礼物说
//
//  Created by lanou3g on 15/11/18.
//  Copyright © 2015年 小杜. All rights reserved.
//

#import "ClassifyModel.h"

@implementation ClassifyModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        
        self.ID = [value intValue];
    }
}

- (instancetype) initWithDictionary:(NSDictionary *)dic{
    
    self = [[ClassifyModel alloc] init];
    
    [self setValuesForKeysWithDictionary:dic];
    
    return self;
}

@end
