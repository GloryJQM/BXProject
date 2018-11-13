//
//  PointFillOutOrderViewController.h
//  SmallCEO
//
//  Created by 任成龙 on 2017/7/26.
//  Copyright © 2017年 lemuji. All rights reserved.
//

#import "BaseViewController.h"

@interface PointFillOutOrderViewController : BaseViewController
@property (nonatomic, strong) NSDictionary *goodsInfoDic;
@property (nonatomic, strong) NSString *goods_id;
@property (nonatomic, strong) NSString *goods_attr_ids;
@property (nonatomic, assign) NSInteger goods_num;

@property (nonatomic, assign) BOOL isShopCart;
@end
