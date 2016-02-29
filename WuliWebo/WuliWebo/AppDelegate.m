//
//  AppDelegate.m
//  MobileMoniter
//
//  Created by yongkun on 15/5/19.
//  Copyright (c) 2015年 nantian. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginVCtrl.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    self.window = [[UIWindow alloc] initWithFrame:screenBounds];
    self.window.autoresizesSubviews = YES;
    
    /**
     *  设置主页
     */
    LoginVCtrl *loginVC = [[LoginVCtrl alloc]init];
    self.window.rootViewController = loginVC;

    [self.window makeKeyAndVisible];
    
    return YES;
}

-(UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window{
    
    return UIInterfaceOrientationMaskAll;
}

@end
