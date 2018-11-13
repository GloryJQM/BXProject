//
//  LogInAndLogOut.h
//  SmallCEO
//
//  Created by 任成龙 on 2017/6/28.
//  Copyright © 2017年 lemuji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LogInAndLogOut : NSObject
@property (nonatomic, assign) void (^finishBlock)(void);
//使用账号密码登录
+ (void)LoginWithAccount:(NSString *)account password:(NSString *)password FinishBlock:(void (^)(void))block;

//登录成功后 对返回的数据做处理
+ (void)LogInSuccessWithDict:(NSDictionary *)dict FinishBlock:(void (^)(void))block;

//退出登录
+ (void)LogOutFinishBlock:(void (^)(void))block;

//强制退出
+ (void)logOut:(NSString *)string;
@end
