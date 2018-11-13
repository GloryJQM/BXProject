//
//  BillsTableViewCell.h
//  Jiang
//
//  Created by peterwang on 17/2/28.
//  Copyright © 2017年 quanmai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BillsTableViewCell : UITableViewCell

//图片
@property(nonatomic ,strong)UIImageView *tipImage;
//钱
@property(nonatomic ,strong)UILabel *moneyLabel;
//详情
@property(nonatomic ,strong)UILabel * detailLabel;
//时间
@property(nonatomic ,strong)UILabel * dateLabel;

@end
