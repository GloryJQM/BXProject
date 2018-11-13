//
//  RCLAFNetworking.h
//  SmallCEO
//
//  Created by 任成龙 on 2017/6/29.
//  Copyright © 2017年 lemuji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RCLAFNetworking : NSObject
/**
 根据请求的url来请求 默认POST请求
 */
+ (void)postWithUrl:(NSString *)url BodyString:(NSString *)bodyStr isPOST:(BOOL)isPost success:(void (^)(id responseObject))success fail:(void (^)(NSError *error))failure;


/**
 根据请求的url来请求 默认POST请求 不显示加载指示器
 */
+ (void)noSVPPostWithUrl:(NSString *)url BodyString:(NSString *)bodyStr success:(void (^)(id responseObject))success fail:(void (^)(NSError *error))failure;
@end
