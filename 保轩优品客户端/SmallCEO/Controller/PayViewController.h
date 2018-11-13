//
//  PayViewController.h
//  Lemuji
//
//  Created by gaojun on 15-7-16.
//  Copyright (c) 2015年 quanmai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALView.h"

typedef NS_ENUM (NSUInteger, PayStatusType){
    PayStatusTypeFail = 0,
    PayStatusTypeSuccess,
    PayStatusTypeCancel
};

typedef NS_ENUM (NSUInteger, PayType){
    PayDeafult = 0,
    PayShop,
    PayOther
};
@interface PayViewController : UIViewController
@property (nonatomic, copy) NSString *countdown;
@property (nonatomic, copy) NSString *is_use_coupon;
@property (nonatomic, strong)UILabel * twoLabel;
@property (nonatomic, strong)UIView * buttomView;
@property(nonatomic,strong) NSString   *shareOrderId;
@property(nonatomic,strong) NSMutableDictionary  *shareDic;
@property(nonatomic,strong) ALView  *alview;
@property(nonatomic,assign) PayStatusType payStatusType;
@property(nonatomic,assign) BOOL isChangeVip;
@property(nonatomic,assign) PayType payType;
@property (nonatomic, copy) NSString *is_luckydraw;
@property (nonatomic, assign) BOOL isVoucher;
@end
