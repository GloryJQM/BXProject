//
//  LogisticsDetailCell.h
//  Lemuji
//
//  Created by Cai on 15-8-3.
//  Copyright (c) 2015年 quanmai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LogisticsDetailCell : UITableViewCell

@property (nonatomic, strong) UILabel *mainInfoLabel;
@property (nonatomic, strong) UILabel *timeInfoLabel;
@property (nonatomic, strong) UIButton *statusButton;
@property (nonatomic, assign) BOOL isLastStatus;

@end
