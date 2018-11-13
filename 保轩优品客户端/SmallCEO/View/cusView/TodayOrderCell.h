//
//  TodayOrderCell.h
//  SmallCEO
//
//  Created by 俊严 on 15/8/23.
//  Copyright (c) 2015年 lemuji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TodayOrderCell : UITableViewCell

//@property (nonatomic, strong)UILabel * timeLabel;
//@property (nonatomic, strong)UILabel * typeLabel;
//@property (nonatomic, strong) UIImageView * goodImageView;
//@property (nonatomic, strong)UILabel * titleLabel;
//@property (nonatomic, strong)UILabel * detailLabel;
//
//@property (nonatomic, strong)UILabel * moneyLabel;
//@property (nonatomic, strong) UILabel * allMoneyLabel;
//@property (nonatomic, strong)UILabel * numLabel;
//@property (nonatomic, strong)UILabel * totalLabel;
//
//
//@property (nonatomic, strong)UIButton * quxiaoButton;
//@property (nonatomic, strong)UILabel * customLabel;

@property (nonatomic, strong)UIImageView * titleImageView;

//商品标题
@property (nonatomic, strong)UILabel * titleLabel;
@property (nonatomic, strong)UILabel * GoodTotalNum;
//总钱数
@property (nonatomic, strong)UILabel * totalLabel;
@property (nonatomic, strong)UILabel * moneyLabel;

//类型
@property (nonatomic, strong)UILabel * typeLabel;


//时间
@property (nonatomic, strong)UILabel * dateLabel;

@property (nonatomic, strong)UIImageView * nextImageView;

@property (nonatomic, assign)int judge;

@property (nonatomic, strong)UILabel * customLabel;

- (void)updateDic:(NSDictionary *)dic;
@end
