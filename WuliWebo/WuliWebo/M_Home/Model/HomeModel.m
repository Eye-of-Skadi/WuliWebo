//
//  HomeModel.m
//  WuliWebo
//
//  Created by 古秀湖 on 16/3/3.
//  Copyright © 2016年 nantian. All rights reserved.
//

#import "HomeModel.h"

@implementation HomeModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary{
    
    self = super.init;
    if (self) {
        
        _identifier = [self uniqueIdentifier];
        _userImageName = dictionary[@"userImageName"];
        _username = dictionary[@"username"];
        
        
        _retweetedText = [dictionary verifiedObjectForKey:@"retweetedText"];
        _content = dictionary[@"content"];
        
        _pic_urls = dictionary[@"pic_urls"];
        
        _time = dictionary[@"time"];
        
        _rowHeight = 0;
        
        //头像
        _rowHeight+=14;
        _rowHeight+=50;
        
        //内容
        _rowHeight+=5;
        _rowHeight+=[PublicMethods heightWithString:dictionary[@"content"] andWidth:[UIScreen mainScreen].bounds.size.width-20 andTextFont:[UIFont systemFontOfSize:15.0f]];

        //线
        _rowHeight+=5;
        _rowHeight+=1;

        //转发内容
        if ([[dictionary verifiedObjectForKey:@"retweetedText"] isEqualToString:@""]) {
            
            _rowHeight-=5;

        }else{
            
            _rowHeight+=[PublicMethods heightWithString:[dictionary verifiedObjectForKey:@"retweetedText"] andWidth:[UIScreen mainScreen].bounds.size.width-20 andTextFont:[UIFont systemFontOfSize:15.0f]];
        }

        //图片
        id picObj = dictionary[@"pic_urls"];
        
        if ([picObj isKindOfClass:[NSArray class]]) {
            
            if ([picObj count] > 0) {
                _rowHeight+=5;
                _rowHeight+=120;
            }
            
            _rowHeight+=14;

        }else{
            _rowHeight+=14;
        }
    }
    return self;
}

- (NSString *)uniqueIdentifier{
    
    static NSInteger counter = 0;
    return [NSString stringWithFormat:@"unique-id-%@", @(counter++)];
}

@end
