//
//  StoreListCell.h
//  WanHao
//
//  Created by chensanli on 15/3/20.
//  Copyright (c) 2015年 wuxiaohui. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol StoreListCellDelegate <NSObject>

-(void)clickIndex:(int)index;

@end

@interface StoreListCell : UITableViewCell{
    UIImageView *_imageV1;
    UIImageView *_imageV2;
    
    UILabel *_titleLabel1;
    UILabel *_titleLabel2;
    
}
@property(nonatomic,assign) id<StoreListCellDelegate> delegate;
@property(nonatomic,strong) UIView *bgView1;
@property(nonatomic,strong) UIView *bgView2;

@property(nonatomic,strong) UIImageView *_imageV1;
@property(nonatomic,strong) UIImageView *_imageV2;
@property(nonatomic,strong) UILabel *_titleLabel1;
@property(nonatomic,strong) UILabel *_titleLabel2;
@end
