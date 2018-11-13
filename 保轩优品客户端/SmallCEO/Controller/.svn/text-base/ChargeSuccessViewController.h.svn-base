//
//  ChargeSuccessViewController.h
//  SmallCEO
//
//  Created by quanmai on 15/9/10.
//  Copyright (c) 2015年 lemuji. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "ALView.h"
#import "BillsViewController.h"

typedef NS_ENUM (NSUInteger, ChargeStatusType){
    ChargeStatusTypeFail = 0,
    ChargeStatusTypeSuccess,
    ChargeStatusTypeCancel
};
@interface ChargeSuccessViewController : UIViewController

@property (nonatomic, strong)UILabel * twoLabel;
@property (nonatomic, strong)UIView * buttomView;
@property(nonatomic,strong) NSString   *shareOrderId;
@property(nonatomic,strong) NSMutableDictionary  *shareDic;
@property(nonatomic,strong) ALView  *alview;
@property(nonatomic,strong) NSString *orderTitle;
@property(nonatomic,assign) ChargeStatusType chargeStatusType;

@end
