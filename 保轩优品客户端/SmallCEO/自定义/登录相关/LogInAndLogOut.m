//
//  LogInAndLogOut.m
//  SmallCEO
//
//  Created by 任成龙 on 2017/6/28.
//  Copyright © 2017年 lemuji. All rights reserved.
//

#import "LogInAndLogOut.h"
#import "LoginViewController.h"
#import "APService.h"
@implementation LogInAndLogOut
+ (void)LoginWithAccount:(NSString *)account password:(NSString *)password FinishBlock:(void (^)(void))block {
    [SVProgressHUD show];
    NSString *url=MOBILE_SERVER_URL(@"login.php");
    TokenURLRequest *request = [[TokenURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    NSString *body;
    body = [NSString stringWithFormat:@"phone_num=%@&password=%@",account, [NSString md5:password]];
    DLog(@"body:%@",body);
    [request setHTTPMethod: @"POST"];
    [request setHTTPBody: [body dataUsingEncoding: NSUTF8StringEncoding]];
    
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([[responseObject objectForKey:@"is_success"] intValue] == 1) {
            NSString *token = [NSString stringWithFormat:@"%@", [responseObject objectForKey:@"token"]];
            if (token.length > 0) {
                [MobClick profileSignInWithPUID:account];
                [[PreferenceManager sharedManager] setPreference:account forKey:@"phone_num"];
                [[PreferenceManager sharedManager] setPreference:[responseObject objectForKey:@"token"] forKey:@"token"];
                [[PreferenceManager sharedManager] setPreference:account forKey:@"pushId"];
                [[PreferenceManager sharedManager] setPreference:account forKey:@"userPhone"];
                [APService setAlias:account callbackSelector:nil object:self];
                [self LogInSuccessWithDict:responseObject FinishBlock:block];
            }else {
                [SVProgressHUD showErrorWithStatus:@"登录失败"];
            }
        }else {
            [SVProgressHUD showErrorWithStatus:[responseObject objectForKey:@"info"] duration:1.5f];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"登录失败"];
    }];
    [op start];
}

+ (void)LogInSuccessWithDict:(NSDictionary *)dict FinishBlock:(void (^)(void))block{
    [SVProgressHUD dismissWithSuccess:@"登录成功!"];
    [[PreferenceManager sharedManager] setPreference:[dict objectForKey:@"alias"] forKey:@"alias"];
    [[PreferenceManager sharedManager] setPreference:@(YES) forKey:@"didLogin"];
    if (block) {
        block();
    }
}

+ (void)LogOutFinishBlock:(void (^)(void))block {
    [SVProgressHUD show];
    NSString *url = MOBILE_SERVER_URL(@"logout.php");
    TokenURLRequest *requset = [[TokenURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    [requset setHTTPMethod:@"POST"];
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:requset];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"responseObject:%@",responseObject);
        if ([[responseObject objectForKey:@"status"] intValue] == 1) {
            [MobClick profileSignOff];
            [SVProgressHUD dismissWithSuccess:@"注销成功"];
            NSNumber *rememberKeyWordValue = [[PreferenceManager sharedManager] preferenceForKey:@"rememberKeyWord"];
            if (!rememberKeyWordValue.boolValue) {
                [[PreferenceManager sharedManager]setPreference:@(NO) forKey:@"rememberKeyWord"];
                [[PreferenceManager sharedManager]setPreference:@"" forKey:@"keyword"];
            }
            [[PreferenceManager sharedManager]setPreference:nil forKey:@"didLogin"];
            [[PreferenceManager sharedManager]setPreference:nil forKey:@"token"];
            [[PreferenceManager sharedManager] setPreference:nil forKey:@"isvip"];
            [[PreferenceManager sharedManager]setPreference:@(NO) forKey:@"AutoKeyWord"];
            [[PreferenceManager sharedManager]setPreference:@"" forKey:@"openid"];
            [[PreferenceManager sharedManager]setPreference:@"" forKey:@"avatar"];
            [[PreferenceManager sharedManager]setPreference:@"" forKey:@"alias"];
            [[PreferenceManager sharedManager]setPreference:@"" forKey:@"access_token"];
            [[PreferenceManager sharedManager]setPreference:@"" forKey:@"type"];
            [[PreferenceManager sharedManager] setPreference:nil forKey:@"pushId"];
            [APService setAlias:@"" callbackSelector:nil object:self];
            
            if (block) {
                block();
            }
        }else{
            [SVProgressHUD dismissWithError:@"网络错误"];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SVProgressHUD dismissWithError:@"网络错误"];
        DLog(@"errorStrign:%@  \nerror:%@",operation.responseString,error);
    }];
    [op start];
}

+ (void)logOut:(NSString *)string {
    dispatch_async(dispatch_get_main_queue(), ^{
        [MobClick profileSignOff];
        if ([SVProgressHUD isVisible] && string.length > 0) {
            [SVProgressHUD dismissWithSuccess:string];
        }
        [[PreferenceManager sharedManager]setPreference:nil forKey:@"didLogin"];
        [[PreferenceManager sharedManager]setPreference:nil forKey:@"token"];
        [[PreferenceManager sharedManager] setPreference:nil forKey:@"isvip"];
        [[PreferenceManager sharedManager]setPreference:@"" forKey:@"username"];
        [[PreferenceManager sharedManager]setPreference:@"" forKey:@"keyword"];
        [[PreferenceManager sharedManager]setPreference:@(NO) forKey:@"rememberKeyWord"];
        [[PreferenceManager sharedManager]setPreference:@(NO) forKey:@"AutoKeyWord"];
        [[PreferenceManager sharedManager]setPreference:@"" forKey:@"openid"];
        [[PreferenceManager sharedManager]setPreference:@"" forKey:@"avatar"];
        [[PreferenceManager sharedManager]setPreference:@"" forKey:@"alias"];
        [[PreferenceManager sharedManager]setPreference:@"" forKey:@"access_token"];
        [[PreferenceManager sharedManager]setPreference:@"" forKey:@"type"];
        [[PreferenceManager sharedManager] setPreference:nil forKey:@"pushId"];
        [APService setAlias:@"" callbackSelector:nil object:self];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            AppDelegate *del=(AppDelegate *)[[UIApplication sharedApplication] delegate];
            BOOL isShowTabBar = NO;
            NSArray *viewControllerClass = @[@"HomeViewController",
                                             @"ClassifyViewController",
                                             @"ShopCartViewController",
                                             @"IntroduceViewController",
                                             @"MyInfoViewController"];
            for (NSString *className in viewControllerClass) {
                if ([del.curViewController isKindOfClass:NSClassFromString(className)]) {
                    isShowTabBar = YES;
                }
            }
            [LoginViewController performIfLogin:del.curViewController withShowTab:isShowTabBar loginAlreadyBlock:^{
                
            } loginSuccessBlock:nil isOK:YES];
        });
    });
}


@end
