//
//  ShopGoodsCell.m
//  WanHao
//
//  Created by wuxiaohui on 14-2-12.
//  Copyright (c) 2014年 wuxiaohui. All rights reserved.
//

#import "ShopGoodsCell.h"

@implementation ShopGoodsCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
         float allW=UI_SCREEN_WIDTH-28;
        self.contentView.backgroundColor = WHITE_COLOR;
        
        _imageV = [[UIImageView alloc] initWithFrame:CGRectMake(5, 2, 56, 56)];
        _imageV.backgroundColor = [UIColor clearColor];
        _imageV.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_imageV];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, 3, allW-60-10, 35)];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.numberOfLines = 2;
//        _titleLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
        _titleLabel.textColor = [UIColor colorWithWhite:0.3 alpha:1.0];
        _titleLabel.font = [UIFont systemFontOfSize:14.0];
        [self.contentView addSubview:_titleLabel];
        
        _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, CGRectGetMaxY(_titleLabel.frame)+3, 80, 15)];
        _priceLabel.backgroundColor = [UIColor clearColor];
        _priceLabel.textColor = App_Main_Color;
        _priceLabel.font = [UIFont systemFontOfSize:16.0];
        [self.contentView addSubview:_priceLabel];
        _priceLabel.adjustsFontSizeToFitWidth = YES;
        
        _oldPriceLabel = [[StrikeThroughLabel alloc] initWithFrame:CGRectMake(65+80, CGRectGetMaxY(_titleLabel.frame)+3, 80, 20.0)];
        _oldPriceLabel.backgroundColor = [UIColor clearColor];
        _oldPriceLabel.strikeThroughEnabled = YES;
        _oldPriceLabel.textColor = [UIColor colorWithWhite:0.4 alpha:1.0];
        _oldPriceLabel.font = [UIFont systemFontOfSize:12.0];
        [self.contentView addSubview:_oldPriceLabel];
        _oldPriceLabel.adjustsFontSizeToFitWidth = YES;
        
    }
    return self;
}

@end
