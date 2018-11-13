//
//  CustomNSMutableURLRequest.m
//  MobileOffice
//
//  Created by wuxiaohui on 13-10-29.
//  Copyright (c) 2013年 wuxiaohui. All rights reserved.
//

#import "TokenURLRequest.h"
#import "NSString+URL.h"
#import <UIKit/UIKit.h>

#define kUUID_Token_Url [[UIDevice currentDevice].identifierForVendor.UUIDString stringByReplacingOccurrencesOfString:@"-" withString:@""]
#define IosAppVersion_Token_Url [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]//版本号获取
#define Request_Head_Version_Token_Url ([[UIDevice currentDevice] systemVersion])

#define Request_Head_Screen_Width_Token_Url [NSString stringWithFormat:@"%.1f",[[UIScreen mainScreen] bounds].size.width*[UIScreen mainScreen].scale]
#define Request_Head_Screen_Height_Token_Url [NSString stringWithFormat:@"%.1f",[[UIScreen mainScreen] bounds].size.height*[UIScreen mainScreen].scale]

@implementation TokenURLRequest

//注意，放在header中的key不要放置_，因为在window环境下，带_的key无法使用，读取不了，

-(id)initWithURL:(NSURL *)URL{
   self = [super initWithURL:URL];
    if (self) {
        DLog(@"%@",[[PreferenceManager sharedManager]preferenceForKey:@"token"]);
        NSDictionary *dic = [[PreferenceManager sharedManager] allData];
        for (NSString *key in [dic allKeys]) {
            NSString *value = [[PreferenceManager sharedManager] preferenceForKey:key];
            if ([key isEqualToString:@"gps"]) {
                [self setValue:value forHTTPHeaderField:key];
            }
        }
        [self setCommonHeader];
        if ([[PreferenceManager sharedManager]preferenceForKey:@"token"] != [NSNull null] && ![[[PreferenceManager sharedManager]preferenceForKey:@"token"] isEqualToString:@""]) {
            [self setValue:[[PreferenceManager sharedManager]preferenceForKey:@"token"] forHTTPHeaderField:@"token"];
        }
        DLog(@"urlstring:%@",URL.absoluteString);
    }
    return self;
}


- (id)initWithLoginURL:(NSURL *)URL {
    self = [super initWithURL:URL];
    if (self) {
        NSLog(@"kUUID:%@",kUUID_Token_Url);
    }
    return self;
}

- (void)setCommonHeader {
    [self setValue:kUUID_Token_Url forHTTPHeaderField:@"imei"];
    [self setValue:IosAppVersion_Token_Url forHTTPHeaderField:@"version"];
    [self setValue:@"ios" forHTTPHeaderField:@"platform"];
    [self setValue:Request_Head_Version_Token_Url  forHTTPHeaderField:@"iosversion"];
    [self setValue:Request_Head_Screen_Width_Token_Url forHTTPHeaderField:@"phonesizewidth"];
    [self setValue:Request_Head_Screen_Height_Token_Url forHTTPHeaderField:@"phonesizeheight"];
    [self setValue:@"1" forHTTPHeaderField:@"APP_TYPE"];
    [self setValue:@"1" forHTTPHeaderField:@"APPTYPE"];
}

@end
