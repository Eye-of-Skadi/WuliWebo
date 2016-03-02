//
//  AppDelegate.h
//  MobileMoniter
//
//  Created by yongkun on 15/5/19.
//  Copyright (c) 2015年 nantian. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LoginDelegate <NSObject>

-(void)loginSuccess;
-(void)loginFailed;

@end

@interface AppDelegate : UIResponder <UIApplicationDelegate,WeiboSDKDelegate>
{
    NSString *wbtoken;
    NSString *userID;
    id<LoginDelegate> loginDelegate;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, retain) NSString* wbtoken;
@property (strong, retain) NSString* userID;

@property (strong, nonatomic) id<LoginDelegate> loginDelegate;

@end

