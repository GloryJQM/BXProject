//
//  PurchaseReminderCell.m
//  SmallCEO
//
//  Created by 俊严 on 15/10/19.
//  Copyright (c) 2015年 lemuji. All rights reserved.
//

#import "PurchaseReminderCell.h"
#import "ZGGCountDownView.h"
@implementation PurchaseReminderCell
{
    ZGGCountDownView *countDownTimeLabel;
    UIImageView *commodityImageV;
    UILabel *commodityNameLabel;
    UILabel *commodityCountLabel;
    UILabel *applyCountLabel;
    UILabel *marketPriceLabel;
    UILabel *timeLabel;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIView * backView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, UI_SCREEN_WIDTH-20, 135)];
        backView.backgroundColor = WHITE_COLOR;
        [self.contentView addSubview:backView];
        
        CALayer *backlayer = [backView layer];
        [backlayer setMasksToBounds:YES];
        [backlayer setCornerRadius:0];
        [backlayer setBorderWidth:0.5];
        [backlayer setBorderColor:[[UIColor colorFromHexCode:@"e8e8e8"] CGColor]];
        
        commodityImageV=[[UIImageView alloc] initWithFrame:CGRectMake(7, 11, 77, 77)];
        commodityImageV.backgroundColor=[UIColor clearColor];
        commodityImageV.layer.cornerRadius = 5;
        commodityImageV.clipsToBounds = YES;
        [backView addSubview:commodityImageV];
        
        
        
        CGFloat width = backView.frame.size.width;
        
        commodityNameLabel=[[UILabel alloc] initWithFrame:CGRectMake(84+15, 11, width-84-15*2, 40)];
        commodityNameLabel.textColor=[UIColor colorFromHexCode:@"4c555e"];
        commodityNameLabel.font=[UIFont boldSystemFontOfSize:15];
        commodityNameLabel.text=@"饭都快被放大看部分的部分被打开不反抗的办法代客哭坟不可点播";
        commodityNameLabel.numberOfLines = 0;
        commodityNameLabel.backgroundColor=[UIColor clearColor];
        [backView addSubview:commodityNameLabel];
        
        self.reservationOrSoldLabel=[[UILabel alloc] initWithFrame:CGRectMake(84+15, 83, UI_SCREEN_WIDTH-84-15*2, 20)];
        self.reservationOrSoldLabel.textColor=[UIColor colorFromHexCode:@"fc554c"];
        self.reservationOrSoldLabel.font=[UIFont systemFontOfSize:16];
        self.reservationOrSoldLabel.text=@"已有5555预定";
        self.reservationOrSoldLabel.textAlignment = NSTextAlignmentLeft;
        [backView addSubview:self.reservationOrSoldLabel];
        
        self.priceOrNeedeservationLabel=[[UILabel alloc] initWithFrame:CGRectMake(width-15-120, 60, 120, 20)];
        self.priceOrNeedeservationLabel.textColor=[UIColor colorFromHexCode:@"fc554c"];
        self.priceOrNeedeservationLabel.font=[UIFont systemFontOfSize:14];
        self.priceOrNeedeservationLabel.text=@"￥5000.00";
        self.priceOrNeedeservationLabel.textAlignment = NSTextAlignmentRight;
        [backView addSubview:self.priceOrNeedeservationLabel];
        
        marketPriceLabel=[[UILabel alloc] initWithFrame:CGRectMake(84+15, 60, 120, 20)];
        marketPriceLabel.textColor=[UIColor colorFromHexCode:@"828282"];;
        marketPriceLabel.font=[UIFont systemFontOfSize:14];
        marketPriceLabel.textAlignment = NSTextAlignmentLeft;
        marketPriceLabel.text=@"￥9999.00";
        marketPriceLabel.backgroundColor=[UIColor clearColor];
        [backView addSubview:marketPriceLabel];
        
        countDownTimeLabel = [[ZGGCountDownView alloc] initWithOrignalPoint:CGPointMake(15, 108) Width:20];
        countDownTimeLabel.font=[UIFont systemFontOfSize:14];
        countDownTimeLabel.textAlignment = NSTextAlignmentLeft;
        countDownTimeLabel.textColor = App_Main_Color;
                countDownTimeLabel.backgroundColor = [UIColor colorFromHexCode:@"ffeeca"];
                countDownTimeLabel.layer.borderColor = [UIColor colorFromHexCode:@"d78751"].CGColor;
                countDownTimeLabel.layer.borderWidth  = 1;
        [backView addSubview:countDownTimeLabel];
        countDownTimeLabel.hidden = YES;

        timeLabel=[[UILabel alloc] initWithFrame:CGRectMake(15, 108, UI_SCREEN_WIDTH/2.0-35, 20)];
        timeLabel.textColor=[UIColor colorFromHexCode:@"848689"];
        timeLabel.font=[UIFont systemFontOfSize:14];
        timeLabel.textAlignment = NSTextAlignmentCenter;
        timeLabel.textColor = [UIColor colorFromHexCode:@"f4492f"];
        timeLabel.backgroundColor = [UIColor colorFromHexCode:@"ffeeca"];
        timeLabel.layer.borderColor = [UIColor colorFromHexCode:@"d78751"].CGColor;
        timeLabel.layer.borderWidth  = 1;
        [backView addSubview:timeLabel];
        timeLabel.hidden = YES;

    }
    return self;

}
- (void)updateCellData:(NSDictionary *)dic
{

    NSURL *imageUrl=[NSURL URLWithString:[NSString stringWithFormat:@"%@",[dic valueForKey:@"goods_img"]]];
    
    [commodityImageV af_setImageWithURL:imageUrl];
    commodityNameLabel.text=[NSString stringWithFormat:@"%@",[dic valueForKey:@"goods_name"]];
    
    marketPriceLabel.text=[NSString stringWithFormat:@"￥%@",[dic valueForKey:@"old_price"]];
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:marketPriceLabel.text attributes:attribtDic];
    
    marketPriceLabel.attributedText = attribtStr;
    NSInteger status = [[NSString stringWithFormat:@"%@", [dic objectForKey:@"status"]] integerValue];
    switch (status) {
        case 1:
        {
            self.priceOrNeedeservationLabel.text = [NSString stringWithFormat:@"还需%@人申请", [dic objectForKey:@"need_bespeak_people_num"]];
            self.reservationOrSoldLabel.text = [NSString stringWithFormat:@"已有%@人申请", [dic objectForKey:@"curr_bespeak_people_num"]];
            self.reservationOrSoldLabel.textColor = [UIColor colorFromHexCode:@"fc554c"];
            timeLabel.text = @"团购暂未开始";
            
        break;
        }
        case 2:
        {
            self.priceOrNeedeservationLabel.text = [NSString stringWithFormat:@"¥%@", [dic objectForKey:@"price"]];
            self.reservationOrSoldLabel.text = [NSString stringWithFormat:@"已售%@件", [dic objectForKey:@"goods_already_sale_num"]];
            [countDownTimeLabel updateViewWithTimestamp:[NSString stringWithFormat:@"%@", [dic objectForKey:@"remainder_sec"]]];
            [countDownTimeLabel startCountDown];
          
            break;
        }
        case 3:
        {
            self.priceOrNeedeservationLabel.text = [NSString stringWithFormat:@"¥%@", [dic objectForKey:@"price"]];
            self.reservationOrSoldLabel.text = [NSString stringWithFormat:@"已有%@人申请", [dic objectForKey:@"curr_bespeak_people_num"]];
            NSString *dateStr = [self convertDateFromString:[NSString stringWithFormat:@"%@", [dic objectForKey:@"start_time"]]];
            timeLabel.text = [NSString stringWithFormat:@"%@开抢", dateStr];
            break;
        }
        case 4:
        {
            self.priceOrNeedeservationLabel.text = [NSString stringWithFormat:@"¥%@", [dic objectForKey:@"price"]];
            self.reservationOrSoldLabel.text = [NSString stringWithFormat:@"已有%@人申请", [dic objectForKey:@"curr_bespeak_people_num"]];
            timeLabel.text = [NSString stringWithFormat:@"时间已结束"];
            break;
        }

        default:
            break;
    }
    timeLabel.frame = CGRectMake(15, 108, [self getLengthWithStr:timeLabel.text]+5, 20);
    countDownTimeLabel.hidden = status != 2;
    timeLabel.hidden = status == 2;

}
- (void)stopTimer {
    [countDownTimeLabel stopCountDown];
}
//将时间戳转化为时间
- (NSString *)convertDateFromString:(NSString*)dateStr
{
    NSTimeInterval time = [dateStr doubleValue];
    NSDate *detailDate = [NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YY-MM-dd"];
    NSString *currentDateStr = [formatter stringFromDate: detailDate];
    return currentDateStr;
}
- (float)getLengthWithStr:(NSString *)str {
    CGRect rect = [str boundingRectWithSize:CGSizeMake(MAXFLOAT, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
    return ceilf(rect.size.width);
}
@end
