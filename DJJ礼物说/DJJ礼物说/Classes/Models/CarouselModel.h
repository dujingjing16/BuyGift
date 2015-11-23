//
//  CarouselModel.h
//  DJJ礼物说
//
//  Created by lanou3g on 15/11/18.
//  Copyright © 2015年 小杜. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarouselModel : NSObject
@property(strong,nonatomic) NSString * channel;
@property(strong,nonatomic) NSString * idStr;
@property(strong,nonatomic) NSString * image_url;
@property(strong,nonatomic) NSString * order;
@property(strong,nonatomic) NSString * status;
@property(strong,nonatomic) NSDictionary * target;
@property(strong,nonatomic) NSString * target_id;
@property(strong,nonatomic) NSString * target_url;
@property(strong,nonatomic) NSString * type;

- (instancetype) initWithDictionary:(NSDictionary *)dic;

@end
