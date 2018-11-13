//
//  PaymentResultViewController.h
//  SmallCEO
//
//  Created by 任成龙 on 2017/7/15.
//  Copyright © 2017年 lemuji. All rights reserved.
//

#import "BaseViewController.h"
@interface PaymentResultViewController : BaseViewController
@property (nonatomic, copy) NSString *resultStr;
@property (nonatomic, copy) NSString *infoStr;
@property (nonatomic, copy) NSDictionary *payMoney;

@property (nonatomic, assign) NSInteger is_point_type;

@property (nonatomic, copy) NSString *money;
@end
