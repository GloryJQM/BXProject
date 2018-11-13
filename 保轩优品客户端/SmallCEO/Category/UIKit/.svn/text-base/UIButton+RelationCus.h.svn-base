//
//  UIButton+RelationCus.h
//  WanHao
//
//  Created by quanmai on 15/6/18.
//  Copyright (c) 2015年 wuxiaohui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIButton (RelationCus)
@property(nonatomic,strong) UIButton *relateBtn;

@end

typedef NS_ENUM(NSInteger, TryOutButtonType)
{
    TryOutButtonTypeApply = 0,
    TryOutButtonTypeSetWarning,
    TryOutButtonTypeEnd,
    TryOutButtonTypeCollect
};

@interface UIButton (TryOutButton)

@property(nonatomic, assign) TryOutButtonType tryOutType;

@end

typedef NS_ENUM(NSInteger, GroupBuyButtonType)
{
    GroupBuyButtonTypeReservation = 0,
    GroupBuyButtonTypeBuy,
    GroupBuyButtonTypeSetWarning,
    GroupBuyButtonTypeCollect
};

@interface UIButton (GroupBuyButton)

@property(nonatomic, assign) GroupBuyButtonType groupBuyType;
@property(nonatomic,strong) dispatch_block_t actionBlock;

-(void)addControlblock:(dispatch_block_t)block forControlEvents:(UIControlEvents)controlEvents;

@end


@interface UITextField (RelationCus)
//1不显示
@property(nonatomic,strong) NSString  *hideStatus;


@end
