//
//  SectionHeadView.h
//  SmallCEO
//
//  Created by 任成龙 on 2017/7/28.
//  Copyright © 2017年 lemuji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderModel.h"
@interface SectionHeadView : UITableViewHeaderFooterView
@property (nonatomic, strong) UILabel *supplierLabel;
@property (nonatomic, strong) UIButton *checkButton;
- (void)setHeaderModel:(HeaderModel *)headerModel;
@end
