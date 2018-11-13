//
//  MyCollectionTableViewCell.h
//  SmallCEO
//
//  Created by 俊严 on 15/10/19.
//  Copyright (c) 2015年 lemuji. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyCollectionTableViewCellDelegate <NSObject>

- (void)cancelCollectionGoods:(UIButton *)sender;

@end

@interface MyCollectionTableViewCell : UITableViewCell

@property (nonatomic, strong)UIImageView * goodsImageView;
@property (nonatomic, strong)UILabel * goodsTitleLabel;
@property (nonatomic, strong)UILabel * priceLabel;
@property (nonatomic, strong)UIButton * cancelButton;
@property (nonatomic, assign)id<MyCollectionTableViewCellDelegate> delegate;

- (void)updateCellData:(NSDictionary *)dic;
@end
