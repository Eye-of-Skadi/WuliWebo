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

@end
