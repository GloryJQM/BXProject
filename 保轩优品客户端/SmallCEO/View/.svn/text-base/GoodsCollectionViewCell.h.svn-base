//
//  GoodsCollectionViewCell.h
//  SmallCEO
//
//  Created by nixingfu on 16/1/8.
//  Copyright © 2016年 lemuji. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, GoodsCollectionViewCellStyle)
{
    GoodsCollectionStyleMoney = 0,  // Goods pay by money
    GoodsCollectionStyleIntegration,       // Goods pay by integration
    
};

@protocol GoodsCollectionViewCellDelegate <NSObject>

-(void)buyAtRow:(NSInteger)row;

@end

@interface GoodsCollectionViewCell : UICollectionViewCell

@property(nonatomic,weak) id<GoodsCollectionViewCellDelegate>  delegate;

@property (nonatomic, assign) GoodsCollectionViewCellStyle style;

@property(nonatomic,strong) NSIndexPath *itemIndexPath;
- (void)updateDic:(NSDictionary *)dic;
- (void)updateSearchDic:(NSDictionary *)dic;

@end
