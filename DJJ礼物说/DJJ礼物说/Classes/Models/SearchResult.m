//
//  SearchResult.m
//  DJJ礼物说
//
//  Created by lanou3g on 15/11/21.
//  Copyright © 2015年 小杜. All rights reserved.
//

#import "SearchResult.h"

@implementation SearchResult

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
    if ([key isEqualToString:@"description"]) {
        self.descrip = value;
    }
}

@end
