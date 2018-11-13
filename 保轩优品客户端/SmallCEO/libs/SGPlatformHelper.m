//
//  SGPlatformHelper.m
//  DeKang
//
//  Created by quanmai on 16/4/18.
//  Copyright © 2016年 quanmai. All rights reserved.
//

#import "SGPlatformHelper.h"
//#import "sdkCall.h"
#import "WXApi.h"
#import "WeiboSDK.h"
//#import "SGShareHelper.h"
//#import "UMessage.h"
#import <BaiduMapAPI_Base/BMKMapManager.h>
//#import "JPUSHService.h"

static SGPlatformHelper *shareHelper = nil;

@interface SGPlatformHelper ()<BMKGeneralDelegate>

@end


@implementation SGPlatformHelper


+(instancetype)shareHelper{
    if(shareHelper == nil){
        shareHelper = [[[self class] alloc] init];
    }
    return shareHelper;
}


+(void)registerAppkeyWithLaunchOptions:(NSDictionary *)launchOptions{
    [[[self class] shareHelper] registerAppkeyWithLaunchOptions:[NSDictionary dictionaryWithDictionary:launchOptions]];
}


-(void)registerAppkeyWithLaunchOptions:(NSDictionary *)launchOptions{
    
    //NSString *bundleIdentifier = [[NSBundle mainBundle].infoDictionary valueForKey:@"CFBundleIdentifier"];
    
    /**百度地图*/
    NSString *baiduMapKey = @"Tf35VTFsOvQtNGXBAbIzE5SFmRGZtljz";
//    if([bundleIdentifier isEqualToString:AppEnterpriseBundleID]){
//        baiduMapKey = BaiduMapDebugAppKey;
//    }
    
    BMKMapManager *mapManager = [[BMKMapManager alloc]init];
    BOOL ret = [mapManager start:baiduMapKey generalDelegate:[[self class] shareHelper]];
    if (!ret) {
        DLog(@"百度地图 start failed!");
    }else{
        DLog(@"百度地图 注册appid成功");
    }
    
    /**qq分享 Appid 在sdkCall里面定义kQQAppid  修
     改appid需要修改相应的url info 值为tencent + appid*/
//    [sdkCall getinstance];
    
    /**微信分享和支付用同一个key  
     修改appid需要修改相应的url info 值就是appid*/
//    [WXApi registerApp:kWeixinAppid];
    
    /**微博分享的kAppKey是在SGShareHelper里面定义的
     修改appid需要修改相应的url info 值为wb + appid*/
//    [WeiboSDK registerApp:kAppKey];
    
    /**友盟统计*/
    /**测试环境和正式环境的key 没有区分两个值一样就可以了*/
//    NSString *debugKey = UMCountDebugKey;
//    NSString *releaseKey = UMCountReleaseKey;
//    [[self class] umengTrackWithDebugID:debugKey releaseKey:releaseKey];
//    
//    //JPush com.quanmai.youjiang
//    [self initJPushWithLaunchOption:launchOptions];
}
#pragma mark - um统计  如果不需要测试环境  两个值传一样就可以了
+(void)umengTrackWithDebugID:(NSString *)debugKey  releaseKey:(NSString *)releaseKey{
    //    [MobClick setCrashReportEnabled:NO]; // 如果不需要捕捉异常，注释掉此行
//    [MobClick setLogEnabled:YES];  // 打开友盟sdk调试，注意Release发布时需要注释掉此行,减少io消耗
//    [MobClick setAppVersion:XcodeAppVersion]; //参数为NSString * 类型,自定义app版本信息，如果不设置，默认从CFBundleVersion里取
//    [MobClick startWithAppkey:debugKey];
//#else
//    [MobClick startWithAppkey:releaseKey];
    //   reportPolicy为枚举类型,可以为 REALTIME, BATCH,SENDDAILY,SENDWIFIONLY几种
    //   channelId 为NSString * 类型，channelId 为nil或@""时,默认会被被当作@"App Store"渠道
}

#pragma mark - JPush
//- (void)initJPushWithLaunchOption:(NSDictionary *)launchOptions
//{
//    //可以添加自定义categories
//    [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
//                                                      UIUserNotificationTypeSound |
//                                                      UIUserNotificationTypeAlert)
//                                          categories:nil];
//    NSString *bundleIdentifier = [[NSBundle mainBundle].infoDictionary valueForKey:@"CFBundleIdentifier"];
//    NSString *jpushMapKey = JpushReleaseAppKey;
//    if([bundleIdentifier isEqualToString:AppEnterpriseBundleID]){
//        jpushMapKey = JpushDebugAppKey;
//    }
//    
//    [JPUSHService setupWithOption:launchOptions appKey:jpushMapKey
//                          channel:@"iOS App"
//                 apsForProduction:YES
//            advertisingIdentifier:nil];
//}

#pragma mark - 百度地图回调代理 设置generalDelegate= self会调用
- (void)onGetNetworkState:(int)iError
{
    if (0 == iError) {
        DLog(@"联网成功");
    }
    else{
        DLog(@"onGetNetworkState %d",iError);
    }
    
}

- (void)onGetPermissionState:(int)iError
{
    if (0 == iError) {
        DLog(@"授权成功");
    }
    else {
        DLog(@"onGetPermissionState %d",iError);
    }
}

@end
