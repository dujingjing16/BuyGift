//
//  CarouselModel.m
//  DJJ礼物说
//
//  Created by lanou3g on 15/11/18.
//  Copyright © 2015年 小杜. All rights reserved.
//

#import "CarouselModel.h"

@implementation CarouselModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.idStr = value;
    }
}

- (instancetype) initWithDictionary:(NSDictionary *)dic{
    
    self = [[CarouselModel alloc] init];
    
    [self setValuesForKeysWithDictionary:dic];
    
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@",_image_url];
}

@end
