//
//  MyGoodsViewController.h
//  SmallCEO
//
//  Created by 俊严 on 15/8/23.
//  Copyright (c) 2015年 lemuji. All rights reserved.
//

#import "HeadView.h"
@interface MyGoodsViewController : UIViewController
{
    NSInteger curSelectEditIndex;
    NSInteger xiaJiaSelectEditIndex;
    NSInteger cancleSelectEditIndex;
    NSIndexPath * xiaJiaPath;
    
    NSString * price;
    NSString * low;
    NSString * high;
}

@property (nonatomic, strong)UIView * areaView;

@property (nonatomic, strong)UIView * backView;
@property (nonatomic, strong)MJRefreshFooterView * footView;
@property (nonatomic, strong)MJRefreshHeaderView * headView;

@property (nonatomic, strong)UILabel * nowLabel;

@property (nonatomic, strong) UILabel * orginLabel;

@property (nonatomic, strong) UILabel * vi;

//是否第一次点击键盘上的按钮
@property (nonatomic, assign) BOOL isClickKey;

@property (nonatomic, assign) int curPage;

@property (nonatomic, strong) HeadView * headerView;

@property (nonatomic, assign) BOOL shouldPushToSetPayPasswordPage;

@end
