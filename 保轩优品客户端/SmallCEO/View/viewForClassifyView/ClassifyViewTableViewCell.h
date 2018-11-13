//
//  ClassifyViewTableViewCell.h
//  SmallCEO
//
//  Created by ni on 17/2/27.
//  Copyright © 2017年 lemuji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClassifyViewTableViewCell : UITableViewCell

@property (nonatomic, strong) UIView *leftLine;
@property (nonatomic, strong) UILabel *contentLabel;


+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
