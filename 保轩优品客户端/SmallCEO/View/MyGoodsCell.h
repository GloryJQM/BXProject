//
//  MyGoodsCell.h
//  SmallCEO
//
//  Created by 俊严 on 15/8/23.
//  Copyright (c) 2015年 lemuji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyGoodsCell : UITableViewCell


@property (nonatomic, strong)UIImageView * goodImageView;

@property (nonatomic, strong)UILabel * titleLabel;

@property (nonatomic, strong)UILabel * originPriceLabel;

@property (nonatomic, strong)UILabel * nowLabel;

@property (nonatomic, strong)UILabel * markPriceLabel;

@property (nonatomic, strong)UILabel * yiLiLabel;

@property (nonatomic, strong)UILabel * lookLabel;

@property (nonatomic, strong)UILabel * saleLabel;

@property (nonatomic, strong)UILabel * wenanLabel;

@property (nonatomic, strong)UILabel * priceRemoveLabel;

@property (nonatomic, strong)UILabel * shanchuGoodLabel;

@property (nonatomic, strong)UILabel * noLabel;

@property (nonatomic, strong)UIButton * fiel;

@property (nonatomic, strong)UIButton * jiage;


@property (nonatomic, strong)UIButton * xiaJiaBtn;

@property (nonatomic, strong)UIButton * cancelBtn;

@property (nonatomic, strong)NSString * iD;

@property (nonatomic, strong)UIButton *StatisticsBtn;
- (void)updateWith:(NSDictionary *)dic;
@end
