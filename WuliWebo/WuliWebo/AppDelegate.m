//
//  AppDelegate.m
//  MobileMoniter
//
//  Created by yongkun on 15/5/19.
//  Copyright (c) 2015年 nantian. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginVCtrl.h"


@interface WBBaseRequest ()
- (void)debugPrint;
@end

@interface WBBaseResponse ()
- (void)debugPrint;
@end

@implementation AppDelegate
@synthesize wbtoken,loginDelegate,userID;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [WeiboSDK registerApp:kAppKey];
    [WeiboSDK enableDebugMode:YES];

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

- (void)didReceiveWeiboRequest:(WBBaseRequest *)request
{
    if ([request isKindOfClass:WBProvideMessageForWeiboRequest.class])
    {
        //        ProvideMessageForWeiboViewController *controller = [[[ProvideMessageForWeiboViewController alloc] init] autorelease];
        //        [self.viewController presentModalViewController:controller animated:YES];
    }
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    
    if ([response isKindOfClass:WBAuthorizeResponse.class])
    {
        if (response.statusCode == WeiboSDKResponseStatusCodeSuccess) {
            //成功
            
            NSLog(@"登录成功");
            
            self.wbtoken = [(WBAuthorizeResponse *)response accessToken];
            if ([self.loginDelegate respondsToSelector:@selector(loginSuccess)]) {
                [self.loginDelegate loginSuccess];
                
                self.userID = [(WBAuthorizeResponse *)response userID];
                
                NSDate *expirationDate = [(WBAuthorizeResponse *)response expirationDate];
                
                [[NSUserDefaults standardUserDefaults]setObject:self.wbtoken forKey:@"Token"];
                [[NSUserDefaults standardUserDefaults]setObject:self.userID forKey:@"UserID"];
                [[NSUserDefaults standardUserDefaults]setObject:expirationDate forKey:@"expirationDate"];
                
                [[NSUserDefaults standardUserDefaults]synchronize];
            }
        } else {
            //失败
            if ([self.loginDelegate respondsToSelector:@selector(loginFailed)]) {
                [self.loginDelegate loginFailed];
            }
        }
        
    }
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [WeiboSDK handleOpenURL:url delegate:self];
}

@end
