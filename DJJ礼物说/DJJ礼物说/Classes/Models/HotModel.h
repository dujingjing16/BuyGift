//
//  HotModel.h
//  DJJ礼物说
//
//  Created by lanou3g on 15/11/18.
//  Copyright © 2015年 小杜. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotModel : NSObject
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * price;
@property (nonatomic, strong) NSString * favorites_count;
@property (nonatomic, strong) NSString * cover_image_url;
@property (nonatomic, strong) NSString * despt;
@property (nonatomic, strong) NSString * url;
@property (nonatomic, strong) NSArray * image_urls;

- (instancetype) initWithDictionary:(NSDictionary *)dic;

@end
