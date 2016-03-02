//
//  LoginModel.h
//  WuliWebo
//
//  Created by 古秀湖 on 16/2/29.
//  Copyright © 2016年 nantian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginModel : NSObject

/**
 *  检查登录状态
 *
 *  @return 结果
 */
+(BOOL)checkToken;

/**
 *  登录
 */
+(void)login;

@end
