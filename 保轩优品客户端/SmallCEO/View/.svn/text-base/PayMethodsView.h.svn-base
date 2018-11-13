//
//  PayMethodsView.h
//  SmallCEO
//
//  Created by huang on 2017/3/2.
//  Copyright © 2017年 lemuji. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, PayMethod)
{
    PayMethodCash = 0,
    PayMethodCoins,
    PayMethodCoupon
};

@interface PayMethodsView : UIView

@property (nonatomic, copy) void (^selectBlock)(PayMethod);

@property (nonatomic, copy)   NSArray *payMethods;

+ (PayMethodsView *)sharedView;

+ (void)show;

+ (void)dismiss;

@end
