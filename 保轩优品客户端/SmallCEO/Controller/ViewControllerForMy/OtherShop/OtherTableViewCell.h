//
//  OtherTableViewCell.h
//  SmallCEO
//
//  Created by ni on 17/3/21.
//  Copyright © 2017年 lemuji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OtherTableViewCell : UITableViewCell

//图片
@property(nonatomic ,strong)UIImageView *tipImage;
//商品名
@property(nonatomic ,strong)UILabel *nameLabel;
//地址
@property (nonatomic, strong) UILabel *addressLabel;
//商店属性，距离
@property (nonatomic, strong) UILabel *proL;
//人均消费
@property (nonatomic, strong) UILabel *averagePrice;
//属性
@property(nonatomic ,strong)UILabel * detailLabel;
//距离
@property(nonatomic ,strong)UILabel * getLabel;
- (void)setDictionary:(NSDictionary *)model isFujin:(BOOL)isFujin;
@end
