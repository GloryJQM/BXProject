//
//  ShopGoodsCell.m
//  WanHao
//
//  Created by wuxiaohui on 14-2-12.
//  Copyright (c) 2014年 wuxiaohui. All rights reserved.
//

#import "ShopGoodsNewCell3.h"

@implementation ShopGoodsNewCell3

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _bgWhiteView=[[UIView alloc] initWithFrame:CGRectMake(5, 0, UI_SCREEN_WIDTH-75-10, 60)];
        _bgWhiteView.backgroundColor=[UIColor whiteColor];
        _bgWhiteView.layer.borderWidth=1;
        _bgWhiteView.layer.borderColor=[UIColor lightGrayColor].CGColor;
        [self.contentView addSubview:_bgWhiteView];
        
        _imageV = [[UIImageView alloc] init];
        _imageV.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_imageV];
        
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
        _titleLabel.textColor = [UIColor colorWithWhite:0.3 alpha:1.0];
        _titleLabel.font = [UIFont systemFontOfSize:16.0];
        [self.contentView addSubview:_titleLabel];
        
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.backgroundColor = [UIColor clearColor];
        _priceLabel.textColor = [UIColor colorFromHexCode:@"#ff6600"];
        _priceLabel.font = [UIFont systemFontOfSize:16.0];
        [self.contentView addSubview:_priceLabel];
        _priceLabel.adjustsFontSizeToFitWidth = YES;
        
        
        _oldPriceLabel = [[StrikeThroughLabel alloc] init];
        _oldPriceLabel.backgroundColor = [UIColor clearColor];
        _oldPriceLabel.strikeThroughEnabled = YES;
        _oldPriceLabel.textColor = [UIColor colorWithWhite:0.4 alpha:1.0];
        _oldPriceLabel.font = [UIFont systemFontOfSize:12.0];
        [self.contentView addSubview:_oldPriceLabel];
        _oldPriceLabel.adjustsFontSizeToFitWidth = YES;
        
        
        
        _imageV.frame = CGRectMake(10, 5, 50, 50);
        _titleLabel.frame = CGRectMake(60+5, 5, UI_SCREEN_WIDTH-75-65-5, 20.0);
        _priceLabel.frame = CGRectMake(60+5, 30, 72.0, 20.0);
        _oldPriceLabel.frame = CGRectMake(60+74.0+5, 30, 52.0, 20.0);
        // Initialization code
    }
    return self;
}
//- (id)initWithFrame:(CGRect)frame
//{
//    
//}

-(void)type3Frame{
    _imageV.frame = CGRectMake(5+70, 5, 50, 50);
    _titleLabel.frame = CGRectMake(60+70, 5, 230, 20.0);
    _priceLabel.frame = CGRectMake(60+70, 30, 72.0, 20.0);
    _oldPriceLabel.frame = CGRectMake(60+74.0+70, 30, 52.0, 20.0);
}

//-(void)layoutSubviews{
//    [super layoutSubviews];
//    _imageV.frame = CGRectMake(5, 5, 50, 50);
//    _titleLabel.frame = CGRectMake(60, 5, 132.0, 20.0);
//    _priceLabel.frame = CGRectMake(60, 30, 72.0, 20.0);
//    _oldPriceLabel.frame = CGRectMake(60+74.0, 30, 52.0, 20.0);
//    
//}

//-(void)drawRect:(CGRect)rect{
//    [super drawRect:rect];
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetLineCap(context, kCGLineCapSquare);
//    CGContextSetLineWidth(context, 1.0);
//    CGContextSetStrokeColorWithColor(context, [UIColor clearColor].CGColor);
//    CGContextSetFillColorWithColor(context, [[UIColor whiteColor]CGColor]);
//    CGContextBeginPath(context);
//    CGContextMoveToPoint(context,80, 0);
//    CGContextAddLineToPoint(context,self.frame.size.width, 0);
//    CGContextAddLineToPoint(context,self.frame.size.width,294.0/2.0);
//    CGContextAddLineToPoint(context,80, 294.0/2.0);
//    CGContextMoveToPoint(context,80, 0);
//    CGContextClosePath(context);
//    CGContextDrawPath(context, kCGPathFillStroke); //根据坐标绘制路径
//
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
