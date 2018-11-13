//
//  HomeCategoryCell.h
//  Lemuji
//
//  Created by quanmai on 15/7/15.
//  Copyright (c) 2015年 quanmai. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HomeCategoryCellDelegate <NSObject>

-(void)buyAtRow:(NSInteger)row;
-(void)saleAtRow:(NSInteger)row;

@end

@interface HomeCategoryCell : UITableViewCell{
    UIImageView *commodityImageV;
    UILabel *commodityNameLabel;
    UILabel *priceLabel;
    UIImageView *buyImageV;
    UILabel *buyNumLable;
    UILabel *marketPriceLabel;
    UILabel *benifitLabel;
    
    
}

@property(nonatomic,weak) id<HomeCategoryCellDelegate>  delegate;

@property (nonatomic,strong)UIImageView* picImg;
@property (nonatomic,strong)UILabel* nameLab;
@property (nonatomic,strong)UILabel* priceLab;
@property (nonatomic,strong)UILabel* buyNum;


-(void)updateWithDic:(NSDictionary *)dic;

-(void)myUpDataWith:(NSDictionary *)dic;
@end
