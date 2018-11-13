//
//  OrderPayViewController.h
//  SmallCEO
//
//  Created by 任成龙 on 2017/7/20.
//  Copyright © 2017年 lemuji. All rights reserved.
//

#import "BaseViewController.h"

@interface OrderPayViewController : BaseViewController
@property (nonatomic, assign) NSInteger is_point_type;
@property (nonatomic, copy) NSString *order_id;
@property (nonatomic, strong) NSDictionary *patInfoDic;

@property (nonatomic, strong) NSDictionary *messageDic;
@end
