//
//  ClassifyModel.h
//  DJJ礼物说
//
//  Created by lanou3g on 15/11/18.
//  Copyright © 2015年 小杜. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClassifyModel : NSObject
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * items_count;
@property (nonatomic, strong) NSString * icon_url;
@property (nonatomic, assign) int ID;

- (instancetype) initWithDictionary:(NSDictionary *)dic;

@end
