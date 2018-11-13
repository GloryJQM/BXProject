//
//  PayOrderViewController.h
//  SmallCEO
//
//  Created by 任成龙 on 2017/7/12.
//  Copyright © 2017年 lemuji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PayOrderViewController : UIViewController
@property (nonatomic, strong) NSDictionary *dataDic;
@property (nonatomic, copy) NSString *contacts_id;

@property (nonatomic, assign) NSInteger is_point_type;
@property (nonatomic, strong) NSString *goods_id;
@property (nonatomic, strong) NSString *goods_attr_ids;
@property (nonatomic, assign) NSInteger goods_num;
@property (nonatomic, assign) NSInteger receiving_method;
@property (nonatomic, copy) NSString *user_points;
@property (nonatomic, copy) NSString *use_coupon;

@property (nonatomic, assign) CGFloat freight;

@property (nonatomic, assign) BOOL isVoucher;

@property (nonatomic, assign) BOOL isShopCart;
@end
