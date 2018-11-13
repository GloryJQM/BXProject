//
//  UPPayHelper.m
//  WanHao
//
//  Created by quanmai on 15/6/15.
//  Copyright (c) 2015年 wuxiaohui. All rights reserved.
//

#import "UPPayHelper.h"

@implementation UPPayHelper

+(void)startWithTn:(NSString *)tn tmode:(NSString *)mode viewController:(UIViewController*)viewController delegate:(id<UPPayPluginDelegate>)delegate{
   
    
    [UPPayPluginPro startPay:tn mode:mode viewController:viewController delegate:delegate];
}

@end
