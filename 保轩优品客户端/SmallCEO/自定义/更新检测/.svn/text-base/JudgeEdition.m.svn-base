//
//  JudgeEdition.m
//  SmallCEO
//
//  Created by 任成龙 on 2017/6/28.
//  Copyright © 2017年 lemuji. All rights reserved.
//

#import "JudgeEdition.h"
@interface JudgeEdition() {
    
}
@property (nonatomic, strong) NSDictionary *versionDic;
@end
@implementation JudgeEdition
+ (void)JudgeEditionWithSuccess:(void(^)(void))sucess {
    NSString *body = [NSString stringWithFormat:@""];
    NSString *str = SERVER_URL(@"appVersion.php");
    [RequestManager startRequestWithUrl:str
                                   body:body
                           successBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
                               DLog(@"responseObject:%@",responseObject);
                               [self judgeVersionAndUpdate:responseObject Success:sucess];
                           }
                           failureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
                               DLog(@"请求发生的错误是:%@",error);
                               DLog(@"返回的数据:%@",operation.responseString);
                               [SVProgressHUD dismissWithError:@"网络错误"];
                           }
     ];
}

+ (void)judgeVersionAndUpdate:(NSDictionary *)versionDic Success:(void(^)(void))success {
    if ([[versionDic objectForKey:@"is_have_new_version"] integerValue] == 1) {
        NSDictionary *dic = [versionDic objectForKey:@"version_info"];
        NSString *newVersion = [dic objectForKey:@"version_num"];
        [[PreferenceManager sharedManager] setPreference:newVersion forKey:@"newVersion"];
        [[PreferenceManager sharedManager] setPreference:[NSString stringWithFormat:@"%@", [dic objectForKey:@"file_path"]] forKey:@"newVersionUrl"];
        if ([newVersion compare:IosAppVersion options:NSNumericSearch] != NSOrderedDescending) {
            return;
        }
        if ([[NSString stringWithFormat:@"%@", [dic objectForKey:@"is_forced_update"]] isEqualToString:@"1"]) {
            if (success) {
                success();
            }
            LGAlertView *av = [[LGAlertView alloc] initWithTitle:App_Alert_Notice_Title message:@"有新版本，将强制更新"  buttonTitles:@[@"确定"] cancelButtonTitle:nil actionHandler:^(LGAlertView *alertView, NSString *title, NSUInteger index) {
                NSDictionary *dic = [versionDic objectForKey:@"version_info"];
                NSString *urlStr = [NSString stringWithFormat:@"%@", [dic objectForKey:@"file_path"]];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
            }];
            av.cancelOnTouch = NO;
            [av showAnimated:YES completionHandler:nil];
            
        } else if ([[NSString stringWithFormat:@"%@", [dic objectForKey:@"is_forced_update"]] isEqualToString:@"0"]) {
            LGAlertView *av = [[LGAlertView alloc] initWithTitle:@"提示更新" message:[[dic objectForKey:@"data"] objectForKey:@"updateText"]  buttonTitles:@[@"确定"] cancelButtonTitle:@"取消" actionHandler:^(LGAlertView *alertView, NSString *title, NSUInteger index) {
                NSDictionary *dic = [versionDic objectForKey:@"version_info"];
                NSString *urlStr = [NSString stringWithFormat:@"%@", [dic objectForKey:@"file_path"]];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
            }];
            [av showAnimated:YES completionHandler:nil];
        }
    }
}


@end
