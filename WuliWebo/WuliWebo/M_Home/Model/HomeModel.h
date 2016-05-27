//
//  HomeModel.h
//  WuliWebo
//
//  Created by 古秀湖 on 16/3/3.
//  Copyright © 2016年 nantian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeModel : NSObject

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@property (nonatomic, copy, readonly) NSString *identifier;//唯一标志

@property (nonatomic, copy, readonly) NSString *retweetedText;//转发内容
@property (nonatomic, copy, readonly) NSString *content;//微博内容
@property (nonatomic, copy, readonly) NSString *username;//用户名
@property (nonatomic, copy, readonly) NSString *userImageName;//用户头像

@property (nonatomic, copy, readonly) id pic_urls;//图片，无论是转发还是原创
@property (nonatomic, copy, readonly) NSString *time;

@property CGFloat rowHeight;

@end
