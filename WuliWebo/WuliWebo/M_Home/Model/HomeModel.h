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

@property (nonatomic, copy, readonly) NSString *identifier;
@property (nonatomic, copy, readonly) NSString *retweetedText;
@property (nonatomic, copy, readonly) NSString *content;
@property (nonatomic, copy, readonly) NSString *username;
@property (nonatomic, copy, readonly) NSString *time;
@property (nonatomic, copy, readonly) NSString *userImageName;

@end
