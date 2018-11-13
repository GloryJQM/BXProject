//
//  HomeCategoryCell.m
//  Lemuji
//
//  Created by quanmai on 15/7/15.
//  Copyright (c) 2015年 quanmai. All rights reserved.
//

#import "HomeCategoryCell.h"

@implementation HomeCategoryCell{
    UILabel *yongJinLab;
    UILabel *canKaoJiaLab;
    UILabel *sellNum;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIView * backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 135)];
        backView.backgroundColor = WHITE_COLOR;
        [self.contentView addSubview:backView];

        commodityImageV=[[UIImageView alloc] initWithFrame:CGRectMake(7, 11, 77, 77)];
        commodityImageV.backgroundColor=[UIColor clearColor];
        commodityImageV.layer.cornerRadius = 5;
        commodityImageV.clipsToBounds = YES;
        [backView addSubview:commodityImageV];
        
        CALayer *layer = [commodityImageV layer];
        [layer setMasksToBounds:YES];
        [layer setCornerRadius:5];
        [layer setBorderWidth:0.8];
        [layer setBorderColor:[[UIColor colorFromHexCode:@"e5e5e5"] CGColor]];
        
        
        commodityNameLabel=[[UILabel alloc] initWithFrame:CGRectMake(84+15, 15, UI_SCREEN_WIDTH-84-15*2, 15)];
        commodityNameLabel.textColor=[UIColor colorFromHexCode:@"4c555e"];
        commodityNameLabel.font=[UIFont boldSystemFontOfSize:15];
        commodityNameLabel.text=@"";
        commodityNameLabel.backgroundColor=[UIColor clearColor];
        [backView addSubview:commodityNameLabel];
        self.nameLab = commodityNameLabel;
        
        UILabel * liRunLabel = [[UILabel alloc] initWithFrame:CGRectMake(84+15, 43, 35, 15)];
        liRunLabel.text = @"奖金";
        liRunLabel.font=[UIFont systemFontOfSize:13];
        liRunLabel.textAlignment = NSTextAlignmentCenter;
        liRunLabel.textColor = [UIColor colorFromHexCode:@"fc554c"];
        liRunLabel.backgroundColor = [UIColor colorFromHexCode:@"ffeeca"];
        [backView addSubview:liRunLabel];
        yongJinLab = liRunLabel;
        
        CALayer *liRunlayer = [liRunLabel layer];
        [liRunlayer setMasksToBounds:YES];
        [liRunlayer setCornerRadius:0];
        [liRunlayer setBorderWidth:0.5];
        [liRunlayer setBorderColor:[[UIColor colorFromHexCode:@"d78751"] CGColor]];
        
        
        UILabel * canKaoLabel = [[UILabel alloc] initWithFrame:CGRectMake(84+15, 66, 35, 15)];
        canKaoLabel.text = @"参考价";
        canKaoLabel.textAlignment = NSTextAlignmentLeft;
        canKaoLabel.textColor = [UIColor colorFromHexCode:@"8d8d8d"];
        canKaoLabel.font=[UIFont systemFontOfSize:14];
        [backView addSubview:canKaoLabel];
        CGSize size=[canKaoLabel sizeThatFits:CGSizeMake(FLT_MAX ,15 )];
        canKaoLabel.frame=CGRectMake(canKaoLabel.frame.origin.x, canKaoLabel.frame.origin.y, size.width, 15);
        canKaoJiaLab = canKaoLabel;
        
        self.buyNum=[[UILabel alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH-100, 66, 85, 20)];
        self.buyNum.textColor=[UIColor colorFromHexCode:@"8d8d8d"];
        self.buyNum.font=[UIFont systemFontOfSize:14];
        self.buyNum.text=@"销量333";
        self.buyNum.textAlignment = NSTextAlignmentRight;
        [backView addSubview:self.buyNum];
        
        sellNum=[[UILabel alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH-100, 43, 85, 20)];
        sellNum.textColor=[UIColor colorFromHexCode:@"5c5c5c"];
        sellNum.font=[UIFont systemFontOfSize:14];
        sellNum.text=@"5555在卖";
        sellNum.textAlignment = NSTextAlignmentRight;
//        [backView addSubview:sellNum];
        
        benifitLabel=[[UILabel alloc] initWithFrame:CGRectMake(140, 43, 120, 15)];
        benifitLabel.textColor=[UIColor colorFromHexCode:@"fa454e"];
        benifitLabel.font=[UIFont systemFontOfSize:14];
        benifitLabel.text=@"利润:";
        benifitLabel.textAlignment = NSTextAlignmentLeft;
        [backView addSubview:benifitLabel];
        
        marketPriceLabel=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(canKaoLabel.frame)+5, 66, 120, 15)];
        marketPriceLabel.textColor=[UIColor colorFromHexCode:@"5c5c5c"];;
        marketPriceLabel.font=[UIFont systemFontOfSize:14];
        marketPriceLabel.textAlignment = NSTextAlignmentLeft;
        marketPriceLabel.text=@"商城价";
        marketPriceLabel.backgroundColor=[UIColor clearColor];
        [backView addSubview:marketPriceLabel];
        
        
        for (int i = 0; i < 2; i ++) {
            UIView * line = [[UIView alloc] initWithFrame:CGRectMake(0, 93+i*41.5, backView.frame.size.width, 0.5)];
            line.backgroundColor = LINE_COLOR;
            [backView addSubview:line];
        }

        priceLabel=[[UILabel alloc] initWithFrame:CGRectMake(15, 108, UI_SCREEN_WIDTH-45-70, 15)];
        priceLabel.textColor=[UIColor colorFromHexCode:@"292929"];
        priceLabel.font=[UIFont systemFontOfSize:15];
        priceLabel.backgroundColor=[UIColor clearColor];
        [backView addSubview:priceLabel];
        
        if ([[PreferenceManager sharedManager] preferenceForKey:@"isvip"])
        {
            priceLabel.text=@"会员价:";
        }else {
            priceLabel.text=@"商城价:";
        }

        UIButton *buyBtnI=[[UIButton alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH-105-80, 101, 80, 27)];
        buyBtnI.backgroundColor = [UIColor whiteColor];
        [buyBtnI addTarget:self action:@selector(buyClick:) forControlEvents:UIControlEventTouchUpInside];
        [buyBtnI setTitle:@"进货" forState:UIControlStateNormal];
        [buyBtnI setTitleColor:[UIColor colorFromHexCode:@"767676"] forState:UIControlStateNormal];
        buyBtnI.titleLabel.font =LMJ_XT 15];
        [backView addSubview:buyBtnI];
        
        CALayer *buyBtnlayer = [buyBtnI layer];
        [buyBtnlayer setMasksToBounds:YES];
        [buyBtnlayer setCornerRadius:0];
        [buyBtnlayer setBorderWidth:0.5];
        [buyBtnlayer setBorderColor:[[UIColor colorFromHexCode:@"989898"] CGColor]];
        
        UIButton *saleBtnI=[[UIButton alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH-95, 101, 80, 27)];
        saleBtnI.backgroundColor = [UIColor colorFromHexCode:@"ffeeca"];
        [saleBtnI addTarget:self action:@selector(saleClick:) forControlEvents:UIControlEventTouchUpInside];
        [saleBtnI setTitle:@"代理" forState:UIControlStateNormal];
        [saleBtnI setTitleColor:[UIColor colorFromHexCode:@"fc554c"] forState:UIControlStateNormal];
        saleBtnI.titleLabel.font =LMJ_CT 15];
        [backView addSubview:saleBtnI];
        
        CALayer *saleBtnlayer = [saleBtnI layer];
        [saleBtnlayer setMasksToBounds:YES];
        [saleBtnlayer setCornerRadius:0];
        [saleBtnlayer setBorderWidth:0.5];
        [saleBtnlayer setBorderColor:[[UIColor colorFromHexCode:@"d78751"] CGColor]];

    }
    return self;
}
-(void)buyClick:(UIButton *)btn{
    if ([self.delegate respondsToSelector:@selector(buyAtRow:)]) {
        [self.delegate buyAtRow:self.tag];
    }
}

-(void)saleClick:(UIButton *)btn{
    if ([self.delegate respondsToSelector:@selector(saleAtRow:)]) {
        [self.delegate saleAtRow:self.tag];
    }
}



-(void)updateWithDic:(NSDictionary *)dic{
    NSURL *imageUrl=[NSURL URLWithString:[NSString stringWithFormat:@"%@",[dic valueForKey:@"picurl"]]];
    
    [commodityImageV sd_setImageWithURL:imageUrl];
    
    commodityNameLabel.text=[NSString stringWithFormat:@"%@",[dic valueForKey:@"subject"]];
    priceLabel.text=[NSString stringWithFormat:@"会员价:￥%.2f",[[dic valueForKey:@"gonghuo_price"] floatValue]];
    
    marketPriceLabel.text=[NSString stringWithFormat:@"￥%@",[dic valueForKey:@"shichang_price"]];
    
    benifitLabel.text=[NSString stringWithFormat:@"￥%.2f",[[dic valueForKey:@"lirun"] floatValue]];
    
    self.buyNum.text =[NSString stringWithFormat:@"销量%@",[dic valueForKey:@"buyNum"]];
    
    sellNum.text =[NSString stringWithFormat:@"%@人在卖",[dic valueForKey:@"sellNum"]];
    
    
    NSString * str = priceLabel.text;
    NSMutableAttributedString * tempStr = [[NSMutableAttributedString alloc] initWithString:str attributes:nil];
    [tempStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorFromHexCode:@"fa454e"] range:NSMakeRange(4, str.length - 4)];
    priceLabel.attributedText = tempStr;
    
    float benifitLabWidth = [self getLengthWithStr:benifitLabel.text];
    
    benifitLabel.frame=CGRectMake(benifitLabel.frame.origin.x, benifitLabel.frame.origin.y, benifitLabWidth, 15);

    
    float marketPriceLabWidth = [self getLengthWithStr:marketPriceLabel.text];
    
    marketPriceLabel.frame=CGRectMake(marketPriceLabel.frame.origin.x, marketPriceLabel.frame.origin.y, marketPriceLabWidth, 15);
    
    
}
//根据字体长度设置labTitle宽度
- (float)getLengthWithStr:(NSString *)str {
    CGRect rect = [str boundingRectWithSize:CGSizeMake(MAXFLOAT, 15) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
    return ceilf(rect.size.width);
}

-(void)myUpDataWith:(NSDictionary *)dic
{
    NSURL *imageUrl=[NSURL URLWithString:[NSString stringWithFormat:@"%@",[dic valueForKey:@"picurl"]]];
    
    [commodityImageV sd_setImageWithURL:imageUrl];
    
    commodityNameLabel.text=[NSString stringWithFormat:@"%@",[dic valueForKey:@"subject"]];
    self.priceLab.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"price"]];
    
    self.buyNum.text = [NSString stringWithFormat:@"销量%@",[dic objectForKey:@"buyer_num"]];
    
    sellNum.text =[NSString stringWithFormat:@"%@人在卖",[dic valueForKey:@"sell_num"]];
    
    priceLabel.text=[NSString stringWithFormat:@"会员价:￥%.2f",[[dic valueForKey:@"gonghuo_price"] floatValue]];
    NSString * str = priceLabel.text;
    NSMutableAttributedString * tempStr = [[NSMutableAttributedString alloc] initWithString:str attributes:nil];
    [tempStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorFromHexCode:@"fa454e"] range:NSMakeRange(4, str.length - 4)];
    priceLabel.attributedText = tempStr;
    
    marketPriceLabel.text=[NSString stringWithFormat:@"￥%@",[dic valueForKey:@"price"]];
    
    benifitLabel.text=[NSString stringWithFormat:@"￥%.2f",[[dic valueForKey:@"lirun"] floatValue]];
}

@end
