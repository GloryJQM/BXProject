//
//  SaleTableViewCell.h
//  SmallCEO
//
//  Created by 俊严 on 15/10/19.
//  Copyright (c) 2015年 lemuji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SaleTableViewCell : UITableViewCell
@property (nonatomic, strong)UIImageView * titleImageView;

//商品标题
@property (nonatomic, strong)UILabel * titleLabel;
@property (nonatomic, strong)UILabel * GoodTotalNum;
//总钱数
@property (nonatomic, strong)UILabel * totalLabel;

//合计
@property (nonatomic, strong)UILabel * moneyLabel;

//类型
@property (nonatomic, strong)UILabel * typeLabel;


//时间
@property (nonatomic, strong)UILabel * dateLabel;

@property (nonatomic, strong)UIImageView * nextImageView;

@property (nonatomic, assign)int judge;

@property (nonatomic, strong)UIView * line2;
@property (nonatomic, strong) UIView * aView;
@property (nonatomic, strong) UIView * line3;

@property (nonatomic, strong)UIButton * quxiaoButton;
@property (nonatomic, strong)UILabel * customLabel;

//规格
@property (nonatomic, strong)UILabel * guiGeLabel;
@property (nonatomic, strong)UILabel * totalNum;

- (void)updateCellData:(NSDictionary *)dic;
@end
