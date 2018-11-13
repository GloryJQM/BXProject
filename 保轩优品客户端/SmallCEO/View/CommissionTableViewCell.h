//
//  CommissionTableViewCell.h
//  SmallCEO
//
//  Created by huang on 2017/3/9.
//  Copyright © 2017年 lemuji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommissionTableViewCell : UITableViewCell

@property (nonatomic,strong)UIImageView *headImage;
@property (nonatomic,strong)UILabel     *moneyLabel;
@property (nonatomic,strong)UILabel     *detail;
@property (nonatomic,strong)UILabel     *time;
@property (nonatomic,strong)UILabel     *dateLabel;
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
