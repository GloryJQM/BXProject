//
//  GoodsListTableViewCell.h
//  Lemuji
//
//  Created by chensanli on 15/7/16.
//  Copyright (c) 2015年 quanmai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodsListTableViewCell : UITableViewCell
@property (nonatomic,strong)UIImageView* goodsImgVi;
@property (nonatomic,strong)UILabel* nameLab;
@property (nonatomic,strong)UILabel* priceLab;
@property (nonatomic,strong)UILabel* ggLab;
@property (nonatomic,strong)UILabel* numLab;

- (void)updateDic:(NSDictionary *)dic is_point_type:(NSString *)is_point_type;

- (void)updateDic1:(NSDictionary *)dic is_point_type:(NSString *)is_point_type;
@end
