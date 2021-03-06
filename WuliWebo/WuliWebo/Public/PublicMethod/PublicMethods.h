//
//  PublicMethods.h
//  yoword
//
//  Created by 古秀湖 on 15/8/25.
//  Copyright © 2015年 qiye. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PublicMethods : NSObject

/**
 *  连接webservice
 *
 *  @param urlStr       网址
 *  @param dic          参数
 *  @param successBlock 成功回调
 *  @param faildBlock   失败回调
 */
+(void)connectWebserviceWithUrlstr:(NSString*)urlStr andParameter:(NSDictionary*)dic andSuccessBlock:(void (^)(id responsObject))successBlock andFaildBlock:(void (^)(NSString *errorDes))faildBlock;

#pragma mark - NSUserDefaults
/**
 *  从NSUserDefaults中根据
 *
 *  @param key 键
 *
 *  @return 对象
 */
+(id)getObjFromUserdefaultsWithKey:(NSString*)key;

/**
 *  保存值到NSUserDefaults中
 *
 *  @param key 键
 *  @param obj 值
 */
+(void)saveToUserdefaultsWithKey:(NSString*)key andObj:(id)obj;

/**
 *  从NSUserDefaults中获取bool值
 *
 *  @param key 键
 *
 *  @return 对象
 */
+(BOOL)getBoolFromUserdefaultsWithKey:(NSString*)key;

/**
 *  保存bool值到NSUserDefaults中
 *
 *  @param key 键
 *  @param boolValue bool值
 */
+(void)saveToUserdefaultsWithKey:(NSString*)key andBool:(BOOL)boolValue;

/**
 *  从NSUserDefaults中去除值
 *
 *  @param key 键
 */
+(void)removeValueFromUserdefaultsWithKey:(NSString*)key;

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
+ (CGFloat)heightWithString:(NSString *)string andWidth:(CGFloat)width andTextFont:(UIFont*)font;

/**
 *  将图片处理成指定大小
 *
 *  @param image 要处理的图片
 *  @param size  指定大小
 *
 *  @return 之后的图片
 */
+(UIImage*)resizeImageWithImage:(UIImage*)sourceImage andTargetSize:(CGSize)size;

@end
