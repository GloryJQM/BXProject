//
//  EaseBlankPageView.h
//  LDWalkerMan
//
//  Created by 糖纸疯了 on 16/8/12.
//  Copyright © 2016年 糖纸疯了. All rights reserved.
//  1.普通视图，带有Button和文字
//  2.EaseBlankPageTypeNoButton没有按钮，只有文字
//  3.其余的等待项目扩展

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, EaseBlankPageType)
{
    EaseBlankPageTypeRefresh = 0,
    EaseBlankPageTypeButton,
    EaseBlankPageTypeNoButton,
    EaseBlankPageTypeOrderRefresh,//商家和私人租赁页面
    EaseBlankPageTypeReleaseRefresh,//发布页面刷新
    EaseBlankPageTypeGoodsRefresh,//交易订单页面刷新
    EaseBlankPageTypeCouponRefresh,//优惠券页面刷新
    EaseBlankPageTypePayDetailRefresh,//赔偿价目表刷新
    EaseBlankPageTypeMapRefresh//没有定位权限
};

@interface EaseBlankPageView : UIView
@property (strong, nonatomic) UIImageView *monkeyView;
@property (strong, nonatomic) UILabel *tipLabel;
@property (strong, nonatomic) UIButton *reloadButton;
@property (copy, nonatomic) void(^reloadButtonBlock)(id sender);

- (void)configWithType:(EaseBlankPageType)blankPageType hasData:(BOOL)hasData hasError:(BOOL)hasError reloadButtonBlock:(void(^)(id sender))block;
@end
