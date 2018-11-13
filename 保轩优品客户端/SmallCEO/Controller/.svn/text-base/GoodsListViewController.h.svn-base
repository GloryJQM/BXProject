//
//  GoodsListViewController.h
//  Lemuji
//
//  Created by chensanli on 15/7/16.
//  Copyright (c) 2015年 quanmai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopCartCell.h"
#import "GGView.h"

typedef void(^successBlock)(AFHTTPRequestOperation* , id);

@interface GoodsListViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>


@property (nonatomic, strong)NSArray * goodsListArray;
/*flag 为1时从购物车  0是从订单*/
@property (nonatomic, assign)int flag;

/*规格模块*/
@property(nonatomic,strong) NSMutableArray  *goodsSelectedSpecificationIndexArray;
@property(nonatomic,strong) NSMutableArray  *selectedGoodsSpecificationArray;
@property(nonatomic,strong) UIWindow  *myGGView;
@property(nonatomic,strong) UIView  *bodyView;
@property(nonatomic,strong) ShopCartCell  *shopCell;
@property(nonatomic,strong) NSMutableArray  *dataSourceArr;

@property(nonatomic,strong) UILabel *  sumMoneyLabelInGGView;

@property(nonatomic,strong) NSArray   *cartIdArr;

@property(nonatomic,strong) NSArray  *guigeArr;
@property (nonatomic, copy) NSString *is_point_type;
@property(nonatomic,assign) BOOL isJifen;


@end
