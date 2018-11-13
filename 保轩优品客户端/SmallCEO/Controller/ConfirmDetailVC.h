//
//  ConfirmDetailVC.h
//  Lemuji
//
//  Created by gaojun on 15-7-15.
//  Copyright (c) 2015年 quanmai. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    HaveConfirmUI,
    ApplicationReturnsUI
}ConfirmUIType;

//底部视图显示类型:0不可售后  1删除  2删除和售后
typedef NS_ENUM(NSUInteger, BottomViewStatus)
{
    BottomViewStatusNone = 0,
    BottomViewStatusDelete,
    BottomViewStatusDeleteAndService
};

@interface ConfirmDetailVC : UIViewController<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>


@property (nonatomic, assign)BottomViewStatus status;
@property (nonatomic, strong)UILabel * peopleLabel;
@property (nonatomic, strong)UILabel * phoneLabel;
@property (nonatomic, strong)UILabel * addressLabel;
@property (nonatomic, strong)UILabel * orderNumLabel;
@property (nonatomic, strong)UILabel * TimeLabel;
@property (nonatomic, strong)UILabel * payType;
@property (nonatomic, strong)UILabel * moneyLabel;
@property (nonatomic, strong)UILabel * goodNumLabel;
@property (nonatomic, strong)UIButton * button;
@property (nonatomic, strong)UIView * buttomView;
@property (nonatomic, strong)UILabel * payLabel;
@property (nonatomic, strong)NSString* titleLab;
@property (nonatomic, strong)UIView * middleView;
@property (nonatomic, strong)NSArray * titleArrays;
@property (nonatomic, strong)UIView * logisticsView;
@property (nonatomic, strong)UIScrollView * backView;
@property (nonatomic, strong)NSString * ID;
@property (nonatomic, strong)NSString * order_str;

@property (nonatomic, strong)NSArray * tempArray;

@property(nonatomic,strong) NSString *wuliuStr;



@property(nonatomic,strong) UILabel   *yingBackMoney;



@property(nonatomic,strong) NSString   *returnMoneyString;
//退货状态back_status=1说明商品正在退货中，=2说明商品已退货，=3说明商品已被拒绝退货，=0说明商品可以申请退货
@property(nonatomic,strong) NSString *returnStatus;
//退货文字
@property(nonatomic,strong) NSString *returnStateString;

@property(nonatomic,strong) UILabel  *upTipLabel;
@property(nonatomic,strong) UILabel  *downTipLabel;

@property (nonatomic, strong)  UIScrollView *allScrollView;
@property (nonatomic, strong) UIScrollView *allLOgisticView;
//物流模块view
@property (nonatomic, strong)UIView * topView;
@property (nonatomic, strong)NSArray * titleArr;
@property (nonatomic, strong)UIView * typeView;
@property (nonatomic, strong)UITableView *logisticsTableView;

@property(nonatomic,strong) UIImageView * logisticsLogo;

@property(nonatomic,strong) UILabel  *logisticaNum;
@property(nonatomic,strong) UILabel  *statusLabel;
@property(nonatomic,strong) UILabel  *wuliuCompanyLabel;

@property(nonatomic,strong) NSArray  *logisticsInfoArray;
@property(nonatomic,strong) NSMutableArray  *textHeightArray;

@property (nonatomic, assign) ConfirmUIType userInterfaceType;

@property (nonatomic, strong)UILabel * heyueLabel;
@property (nonatomic, strong) UILabel * faPiaoLabel;

@property (nonatomic, strong) NSDictionary *tryOutDetailDic;
@property (nonatomic, assign)BOOL isCustomerOrder;
@end
