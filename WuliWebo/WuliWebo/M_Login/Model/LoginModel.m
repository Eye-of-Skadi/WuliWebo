//
//  LoginModel.m
//  WuliWebo
//
//  Created by 古秀湖 on 16/2/29.
//  Copyright © 2016年 nantian. All rights reserved.
//

#import "LoginModel.h"

@implementation LoginModel

/**
 *  检查登录状态
 *
 *  @return 结果
 */
+(BOOL)checkToken{
    
    NSDate *expirationDate = [[NSUserDefaults standardUserDefaults]objectForKey:@"expirationDate"];
    NSLog(@"expirationDate : %@",expirationDate);
    //    NSDate *nowDate =
    return YES;
}

/**
 *  登录
 */
+(void)login{
    
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = kRedirectURI;
    request.scope = @"all";
    request.userInfo = @{@"SSO_From": @"SendMessageToWeiboViewController",
                         @"Other_Info_1": [NSNumber numberWithInt:123],
                         @"Other_Info_2": @[@"obj1", @"obj2"],
                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    [WeiboSDK sendRequest:request];
}

@end
