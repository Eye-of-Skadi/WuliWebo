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
        _retweetedText = dictionary[@"retweetedText"];
        _content = dictionary[@"content"];
        
        _pic_urls = dictionary[@"pic_urls"];
        
        _time = dictionary[@"time"];
    }
    return self;
}

- (NSString *)uniqueIdentifier{
    
    static NSInteger counter = 0;
    return [NSString stringWithFormat:@"unique-id-%@", @(counter++)];
}

@end
