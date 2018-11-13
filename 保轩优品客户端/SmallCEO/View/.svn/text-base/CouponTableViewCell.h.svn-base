//
//  CouponTableViewCell.h
//  SmallCEO
//
//  Created by 俊严 on 15/10/20.
//  Copyright (c) 2015年 lemuji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CouponTableViewCell : UITableViewCell

@property (nonatomic, strong)UILabel * typeLabel;
@property (nonatomic, strong)UILabel * useDateLabel;
@property (nonatomic, strong)UILabel * couponMoneyLabel;
@property (nonatomic, strong)UILabel * fullMoneyLabel;
@property (nonatomic, strong)UILabel * useStatusLabel;
@property (nonatomic, strong)NSDictionary  *cellDic;
@property (nonatomic, assign)int CouponID;
@property (nonatomic, assign)CGFloat totalMoney;
@property (nonatomic, strong) UIButton *selectButton;
@property (nonatomic, strong) UIImageView *backImageView;

- (instancetype)initWithSelecteButtonAndReuseIdentifier:(NSString *)reuseIdentifier;

- (void)updateCellData:(NSDictionary *)dic;
@end
