//
//  PurchaseReminderCell.h
//  SmallCEO
//
//  Created by 俊严 on 15/10/19.
//  Copyright (c) 2015年 lemuji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PurchaseReminderCell : UITableViewCell

@property (nonatomic, strong) UILabel *likeCountLabel, *reservationOrSoldLabel, *priceOrNeedeservationLabel;

- (void)updateCellData:(NSDictionary *)dic;

- (void)stopTimer;
@end
