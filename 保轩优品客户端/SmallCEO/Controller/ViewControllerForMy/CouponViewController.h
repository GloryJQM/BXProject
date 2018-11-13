//
//  CouponViewController.h
//  SmallCEO
//
//  Created by 俊严 on 15/10/20.
//  Copyright (c) 2015年 lemuji. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CouponTableViewCell;
@protocol CouponViewDelegate <NSObject>

@optional
- (void)shuzi:(int)one withMoney:(CGFloat)two;
- (void)changeView:(CouponTableViewCell*)useCell  quanID:(NSString *)quanID;
- (int)getQuanNum;
- (void)chooseCouponAtIndex:(NSInteger)index;   // index is -1 if unselect coupon

@end

@interface CouponViewController : UIViewController


@property (nonatomic, strong) NSString * quanID;
@property (nonatomic, strong) NSDictionary * dic;
@property (nonatomic, strong) UIView * mainView;
@property (nonatomic, strong) UITableView* tab;
@property (nonatomic, strong) UITextField * youHuiTF;
@property (nonatomic, strong) NSArray * couponArray;
@property (nonatomic, strong) NSMutableArray * couponDataArray;
@property (nonatomic, assign) int flag;

@property (nonatomic, weak)id<CouponViewDelegate> delegate;
@property (nonatomic, strong)CouponTableViewCell * cell;

@property (nonatomic, assign,getter=isSelect) BOOL select;
@property (nonatomic, assign)int inde;
@property (nonatomic, assign)CGFloat money;
@property (nonatomic, strong)UIView * nilView;
@property (nonatomic, assign)double price;
@property (nonatomic, assign)NSInteger selectedCouponIndex;

/*选择可用规格需要传商品id  goods_id 用逗号隔开*/
@property (nonatomic,strong) NSString *aids;

@property (nonatomic, strong)MJRefreshFooterView * footerView;
@property (nonatomic, strong)MJRefreshHeaderView * headerView;

@property (nonatomic, assign)BOOL isFromWallet;

@end
