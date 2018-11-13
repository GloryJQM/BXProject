//
//  TodayIncomeCell.h
//  SmallCEO
//
//  Created by 俊严 on 15/8/23.
//  Copyright (c) 2015年 lemuji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TodayIncomeCell : UITableViewCell

@property (nonatomic, strong)UILabel * titleLabel;
@property (nonatomic, strong)UILabel * incomeLabel;
@property (nonatomic, strong)UILabel * timeLabel;

- (void)updateDic:(NSDictionary *)dic;

@end
