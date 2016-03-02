//
//  LoginView.m
//  WuliWebo
//
//  Created by 古秀湖 on 16/2/29.
//  Copyright © 2016年 nantian. All rights reserved.
//

#import "LoginView.h"

@implementation LoginView

/**
 *  创建登录按钮
 *
 *  @return 登录按钮
 */
+(UIButton*)createLoginBtn{
 
    UIImage *loginImage = [UIImage imageNamed:@"sina_logo"];
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginBtn setImage:loginImage forState:UIControlStateNormal];
    return loginBtn;
}

/**
 *  背景图片
 *
 *  @return 背景图片
 */
+(UIImageView*)createBGImageView{
    
    UIImage *bgImage = [UIImage imageNamed:@"login_background"];
    UIImageView *bgImageView = [[UIImageView alloc]initWithImage:bgImage];

    return bgImageView;
}
@end
