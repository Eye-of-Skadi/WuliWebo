//
//  LoginView.h
//  WuliWebo
//
//  Created by 古秀湖 on 16/2/29.
//  Copyright © 2016年 nantian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginView : NSObject

/**
 *  创建登录按钮
 *
 *  @return 登录按钮
 */
+(UIButton*)createLoginBtn;

/**
 *  背景图片
 *
 *  @return 背景图片
 */
+(UIImageView*)createBGImageView;

/**
 *  获取主页
 *
 *  @return 主页
 */
+(UIViewController*)getMainViewController;

@end
