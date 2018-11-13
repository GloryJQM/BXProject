//
//  GoodsCollectionViewCell.m
//  SmallCEO
//
//  Created by nixingfu on 16/1/8.
//  Copyright © 2016年 lemuji. All rights reserved.
//

#import "GoodsCollectionViewCell.h"

@implementation GoodsCollectionViewCell
{
    UILabel * priceLabel;
    UIImageView * iconImageView;
    UILabel * buyNumLabel;
    UILabel * titleLabel;
    UILabel * detailLabel;
    
    UIImageView *integrationIcon;
//    UILabel * MarketPriceLabel;
//    UILabel *vipPrice;
    UIView  * itemBackView;
}
- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        CGFloat width = (UI_SCREEN_WIDTH -  3*10) / 2;
        CGFloat off_X = 15 / 2;
        CGFloat off_Y = 5;
        CGFloat font = 0;
        CGFloat vipH = 0;
        if (IS_IPHONE4 || IS_IPHONE5) {
            font = 12;
            vipH = 16;
        }else {
            font = 14;
            vipH = 18;
        }
        
//        itemBackView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, (UI_SCREEN_WIDTH-3*10)/2.0, width + 80)];
//        itemBackView.backgroundColor = Red_Color;
//        [self.contentView addSubview:itemBackView];
        
//        UIView*backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, width+100)];
//        backView.backgroundColor = WHITE_COLOR;
//        backView.layer.borderWidth = 0.5;
//        backView.layer.borderColor = [UIColor colorFromHexCode:@"#e5e5e5"].CGColor;
//        [self.contentView addSubview:backView];
        self.backgroundColor =[UIColor whiteColor];
        self.frame = CGRectMake(0, 0, UI_SCREEN_WIDTH / 2, width + 80);
        iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(off_X, off_X, width-2*off_X, width-2*off_X)];
        iconImageView.backgroundColor=[UIColor whiteColor];
        iconImageView.contentMode=UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:iconImageView];
        
        //产品名
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(off_X, off_Y+width, width-2*off_X, 20)];
        titleLabel.font = LMJ_XT font+1];
        titleLabel.numberOfLines = 1;
        titleLabel.textColor = [UIColor colorFromHexCode:@"000000"];
        [self.contentView addSubview:titleLabel];
        
        //产品说明
        detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(off_X, off_Y+width+20, width-2*off_X, 20)];
        detailLabel.font = LMJ_XT font-1];
        detailLabel.numberOfLines = 1;
        detailLabel.textColor = [UIColor colorFromHexCode:@"8d8d8d"];
        //detailLabel.text = @"名优品牌,推荐产品,国家ISO90001认证";

        [self.contentView addSubview:detailLabel];
        
//        buyNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(width/2, CGRectGetMaxY(titleLabel.frame)+off_Y, (width-2*off_X)/2-off_X, 15)];
//        buyNumLabel.textAlignment = NSTextAlignmentRight;
//        buyNumLabel.font = LMJ_XT font-1];
//        buyNumLabel.textColor = [UIColor colorFromHexCode:@"8d8d8d"];
//        [backView addSubview:buyNumLabel];
        

        
//        MarketPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(off_X+2, CGRectGetMaxY(titleLabel.frame)+off_Y, (width-2*off_X)/2, 15)];
//        MarketPriceLabel.font = LMJ_XT font-2];
//        MarketPriceLabel.textAlignment = NSTextAlignmentLeft;
//        MarketPriceLabel.textColor = [UIColor colorFromHexCode:@"8d8d8d"];
//        [backView addSubview:MarketPriceLabel];
        
//        vipPrice = [[UILabel alloc] initWithFrame:CGRectMake(off_X, width+100-30+(20-vipH)/2, 60, vipH)];
//        vipPrice.textColor = Red_Color;
//        vipPrice.backgroundColor = [UIColor colorFromHexCode:@"#ffeeca"];
//        vipPrice.layer.borderColor = [[UIColor colorFromHexCode:@"#d78751"] CGColor];
//        vipPrice.layer.borderWidth = 0.5;
//        vipPrice.font = LMJ_XT font-1];
//        vipPrice.textAlignment = NSTextAlignmentCenter;
////        [backView addSubview:vipPrice];
//        vipPrice.text = [[PreferenceManager sharedManager] preferenceForKey:@"isvip"] ? @"会员价" : @"商城价";
//        CGSize vipsize = [vipPrice sizeThatFits:CGSizeMake(FLT_MAX, 20)];
//        vipPrice.frame = CGRectMake(vipPrice.frame.origin.x, vipPrice.frame.origin.y, ceilf(vipsize.width)+2, vipPrice.frame.size.height);
 
//        CGSize size = [vipPrice sizeThatFits:CGSizeMake(FLT_MAX, 20)];
//        vipPrice.frame = CGRectMake(off_X, width+100-30+(20-vipH)/2, ceilf(size.width)+2, vipH);
        
//        priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(off_X, width+100-30, width/2, 20)];
//        priceLabel.font = LMJ_XT font];
//        priceLabel.textColor = Red_Color;
////        priceLabel.textColor = App_Main_Color;
//        priceLabel.text = @"￥88888.88";
//        [backView addSubview:priceLabel];

        //价格
        priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(off_X*2, titleLabel.maxY + 5, width/2, 20)];
        priceLabel.font = LMJ_XT font+2];
        priceLabel.textColor = App_Main_Color;
        priceLabel.text = @"￥88888.88";
        [self.contentView addSubview:priceLabel];
        
        integrationIcon = [[UIImageView alloc]init];
        integrationIcon.frame = CGRectMake(-5, 0, 20, 20);
        integrationIcon.image = [UIImage imageNamed:@"Button-jifenyue"];
        integrationIcon.contentMode=UIViewContentModeScaleAspectFit;
        [priceLabel addSubview:integrationIcon];
        
        //销量
        buyNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(off_X*2, CGRectGetMaxY(priceLabel.frame), width/2, 20)];
        buyNumLabel.textAlignment = NSTextAlignmentLeft;
        buyNumLabel.font = LMJ_XT font];
        buyNumLabel.textColor = [UIColor colorFromHexCode:@"8d8d8d"];
        [self.contentView addSubview:buyNumLabel];
   
        //购物车logo
        CGSize imgSize = CGSizeMake(30, 30);
        UIButton *buyBtnI=[[UIButton alloc] initWithFrame:CGRectMake(width-30-20, priceLabel.y, 30, 30)];
        buyBtnI.backgroundColor = [UIColor whiteColor];
        [buyBtnI addTarget:self action:@selector(buyClick:) forControlEvents:UIControlEventTouchUpInside];
        [buyBtnI setImage:[[UIImage imageNamed:@"button-gouwuche@2x.png"] imageWithMinimumSize:imgSize] forState:UIControlStateNormal];
        [self.contentView addSubview:buyBtnI];
        
        
        UIView *line = [[UIView alloc]init];
        line.frame = CGRectMake(width-50-10, priceLabel.y, 1, 30);
        line.backgroundColor = [UIColor colorFromHexCode:@"#e5e5e5"];
        [self.contentView addSubview:line];
        
    }
    return self;
}
-(void)buyClick:(UIButton *)btn{
    if ([self.delegate respondsToSelector:@selector(buyAtRow:)]) {
        [self.delegate buyAtRow:self.tag];
    }
}
- (void)updateDic:(NSDictionary *)dic
{
    if (self.itemIndexPath.item%2 == 0) {
        itemBackView.frame = CGRectMake(10, 0, (UI_SCREEN_WIDTH-3*10)/2.0, (UI_SCREEN_WIDTH-3*10)/2.0+100);
    }else {
        itemBackView.frame = CGRectMake(5, 0, (UI_SCREEN_WIDTH-3*10)/2.0, (UI_SCREEN_WIDTH-3*10)/2.0+100);

    }
    
    NSString *urlStr = [NSString stringWithFormat:@"%@",[dic objectForKey:@"picurl"]];
    NSURL*url = [[NSURL alloc]initWithString:urlStr];
    [iconImageView sd_setImageWithURL:url];

    titleLabel.text = [NSString stringWithFormat:@"%@", [dic objectForKey:@"subject"]];
    if (self.style == GoodsCollectionStyleMoney) {
        priceLabel.text=[NSString stringWithFormat:@"￥%.2f",[[dic valueForKey:@"gonghuo_price"] floatValue]];
        integrationIcon.hidden = YES;
    }else{
        priceLabel.text=[NSString stringWithFormat:@"  %.2f",[[dic valueForKey:@"gonghuo_price"] floatValue]];
        integrationIcon.hidden = NO;
    }
    buyNumLabel.text =[NSString stringWithFormat:@"%@人购买",[dic valueForKey:@"sell_num"]];
//    priceLabel.text=[NSString stringWithFormat:@"￥%.2f",[[dic valueForKey:@"gonghuo_price"] floatValue]];
//    buyNumLabel.text =[NSString stringWithFormat:@"销量%@",[dic valueForKey:@"buyNum"]];
//    MarketPriceLabel.text = [NSString stringWithFormat:@"￥%.2f",[[dic valueForKey:@"shichang_price"] floatValue]];
//    
//    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle]};
//    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:MarketPriceLabel.text attributes:attribtDic];
//    MarketPriceLabel.attributedText = attribtStr;
    

        CGSize priceSize = [priceLabel sizeThatFits:CGSizeMake(FLT_MAX, 20)];
    priceLabel.frame = CGRectMake(priceLabel.frame.origin.x, priceLabel.frame.origin.y, ceilf(priceSize.width), 20);

}
- (void)updateSearchDic:(NSDictionary *)dic {
    
    if (self.itemIndexPath.item%2 == 0) {
        itemBackView.frame = CGRectMake(10, 0, (UI_SCREEN_WIDTH-3*10)/2.0, (UI_SCREEN_WIDTH-3*10)/2.0+100);
    }else {
        itemBackView.frame = CGRectMake(5, 0, (UI_SCREEN_WIDTH-3*10)/2.0, (UI_SCREEN_WIDTH-3*10)/2.0+100);
        
    }
    NSString *urlStr = [[[NSString stringWithFormat:@"%@",[dic objectForKey:@"picurl"]] componentsSeparatedByString:@","] firstObject];
    NSURL*url = [NSURL URLWithString:urlStr];
    [iconImageView sd_setImageWithURL:url];

    titleLabel.text = [NSString stringWithFormat:@"%@", [dic objectForKey:@"subject"]];
    if (self.style == GoodsCollectionStyleMoney) {
        priceLabel.text=[NSString stringWithFormat:@"￥%.2f",[[dic valueForKey:@"gonghuo_price"] floatValue]];
        integrationIcon.hidden = YES;
    }else{
        priceLabel.text=[NSString stringWithFormat:@"    %.2f",[[dic valueForKey:@"gonghuo_price"] floatValue]];
        integrationIcon.hidden = NO;
    }
    
    buyNumLabel.text =[NSString stringWithFormat:@"%@人购买",[dic valueForKey:@"sell_num"]];
    
    
    CGSize priceSize = [priceLabel sizeThatFits:CGSizeMake(FLT_MAX, 20)];
    priceLabel.frame = CGRectMake(priceLabel.frame.origin.x, priceLabel.frame.origin.y, ceilf(priceSize.width), 20);

}

@end
