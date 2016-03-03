//
//  LoginView.m
//  WuliWebo
//
//  Created by 古秀湖 on 16/2/29.
//  Copyright © 2016年 nantian. All rights reserved.
//

#import "LoginView.h"
#import "HomeVCtrl].h"

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

/**
 *  获取主页
 *
 *  @return 主页
 */
+(UIViewController*)getMainViewController{
    
    //主页
    HomeVCtrl_ *homevc = [[HomeVCtrl_ alloc]init];
    UINavigationController *homeNav = [[UINavigationController alloc]initWithRootViewController:homevc];
    
    UITabBarController *phone_tab_vc = [[UITabBarController alloc]init];
    [phone_tab_vc setViewControllers:[NSArray arrayWithObjects:homeNav , nil]];
    
    //主页
    UITabBarItem *homeItem = [[[phone_tab_vc tabBar] items]objectAtIndex:0];
    [homeItem setImage:[UIImage imageNamed:@"tab_home"]];
    [homeItem setSelectedImage:[UIImage imageNamed:@"tab_home_selected"]];
    [homeItem setTitle:@"主页"];
    
    return phone_tab_vc;

}

@end
