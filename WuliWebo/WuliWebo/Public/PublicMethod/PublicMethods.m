//
//  PublicMethods.m
//  yoword
//
//  Created by 古秀湖 on 15/8/25.
//  Copyright © 2015年 qiye. All rights reserved.
//

#import "PublicMethods.h"
#import "AFNetworking.h"

@implementation PublicMethods

#pragma mark - 通讯组件
/**
 *  连接webservice
 *
 *  @param urlStr       网址
 *  @param dic          参数
 *  @param successBlock 成功回调
 *  @param faildBlock   失败回调
 */
+(void)connectWebserviceWithUrlstr:(NSString*)urlStr andParameter:(id)parameters andSuccessBlock:(void (^)(id responsObject))successBlock andFaildBlock:(void (^)(NSString *errorDes))faildBlock{

    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            
            faildBlock(error.description);
        } else {
            successBlock(responseObject);
        }
    }];
    [dataTask resume];
}

#pragma mark - NSUserDefaults
/**
 *  从NSUserDefaults中获取值
 *
 *  @param key 键
 *
 *  @return 对象
 */
+(id)getObjFromUserdefaultsWithKey:(NSString*)key{
    
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

/**
 *  保存值到NSUserDefaults中
 *
 *  @param key 键
 *  @param obj 值
 */
+(void)saveToUserdefaultsWithKey:(NSString*)key andObj:(id)obj{
    
    [[NSUserDefaults standardUserDefaults]setObject:obj forKey:key];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

/**
 *  从NSUserDefaults中获取bool值
 *
 *  @param key 键
 *
 *  @return 对象
 */
+(BOOL)getBoolFromUserdefaultsWithKey:(NSString*)key{
    
    return [[NSUserDefaults standardUserDefaults] boolForKey:key];
}

/**
 *  保存bool值到NSUserDefaults中
 *
 *  @param key 键
 *  @param boolValue bool值
 */
+(void)saveToUserdefaultsWithKey:(NSString*)key andBool:(BOOL)boolValue{
    
    [[NSUserDefaults standardUserDefaults]setBool:boolValue forKey:key];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

/**
 *  从NSUserDefaults中去除值
 *
 *  @param key 键
 */
+(void)removeValueFromUserdefaultsWithKey:(NSString*)key{
    
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:key];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

#pragma mark - 计算指定字符串在指定宽度的前提下的高度
/**
 *  计算指定字符串在指定宽度的前提下的高度
 *
 *  @param string 字符串
 *  @param width  指定宽度
 *  @param font   字号
 *
 *  @return 高度
 */
+ (CGFloat)heightWithString:(NSString *)string andWidth:(CGFloat)width andTextFont:(UIFont*)font{
    
    CGRect rect = [string boundingRectWithSize:CGSizeMake(width,MAXFLOAT)//限制最大的宽度和高度
                                       options:NSStringDrawingUsesFontLeading  |NSStringDrawingUsesLineFragmentOrigin//采用换行模式
                                    attributes:@{NSFontAttributeName:font}//传人的字体字典
                                       context:nil];
    
    return rect.size.height;
}
@end
