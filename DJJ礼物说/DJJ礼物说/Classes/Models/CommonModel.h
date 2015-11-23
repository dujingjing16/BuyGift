//
//  CommonModel.h
//  DJJ礼物说
//
//  Created by lanou3g on 15/11/17.
//  Copyright © 2015年 小杜. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonModel : NSObject
@property (nonatomic, strong) NSString * content_url;
//图片网址
@property (nonatomic, strong) NSString * cover_image_url;
@property (nonatomic, strong) NSString * created_at;
@property (nonatomic, strong) NSString * editor_id;
@property (nonatomic, strong) NSString * ID;
@property (nonatomic, strong) NSString * liked;
//喜欢的人数
@property (nonatomic, strong) NSString * likes_count;
@property (nonatomic, strong) NSString * published_at;
@property (nonatomic, strong) NSString * share_msg;
@property (nonatomic, strong) NSString * short_title;
//标题名字
@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSString * type;
@property (nonatomic, strong) NSString * updated_at;
@property (nonatomic, strong) NSString * url;

- (instancetype) initWithDictionary:(NSDictionary *)dic;

@end
