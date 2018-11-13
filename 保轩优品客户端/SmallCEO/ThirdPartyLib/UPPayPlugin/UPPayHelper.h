//
//  UPPayHelper.h
//  WanHao
//
//  Created by quanmai on 15/6/15.
//  Copyright (c) 2015年 wuxiaohui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UPPayPluginPro.h"

@interface UPPayHelper : NSObject

+(void)startWithTn:(NSString *)tn tmode:(NSString *)mode viewController:(UIViewController*)viewController delegate:(id<UPPayPluginDelegate>)delegate;

@end
