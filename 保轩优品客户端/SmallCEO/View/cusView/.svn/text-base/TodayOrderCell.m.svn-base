//
//  TodayOrderCell.m
//  SmallCEO
//
//  Created by 俊严 on 15/8/23.
//  Copyright (c) 2015年 lemuji. All rights reserved.
//

#import "TodayOrderCell.h"

@implementation TodayOrderCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = WHITE_COLOR;

        
        self.titleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 37.5, 37.5)];
        [self addSubview:_titleImageView];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.titleImageView.frame) + 18, 10, UI_SCREEN_WIDTH-(CGRectGetMaxX(self.titleImageView.frame) + 18)-20, 25)];
        _titleLabel.text = @"Welloop小黑智能手表";
        _titleLabel.textColor = [UIColor colorFromHexCode:@"#4E5F6F"];
        _titleLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:_titleLabel];
        

        
        
        self.totalLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.titleImageView.frame) + 18, CGRectGetMaxY(self.titleLabel.frame), 90, 15)];
        _totalLabel.text = @"总额:14568";
        _totalLabel.font = [UIFont systemFontOfSize:13];
        _totalLabel.textColor = [UIColor colorFromHexCode:@"#4E5F6F"];
        [self addSubview:_totalLabel];
        
        
        self.typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.totalLabel.frame),  CGRectGetMaxY(self.titleLabel.frame), 90, 15)];
        _typeLabel.text = @"待发货";
        _typeLabel.textColor = [UIColor colorFromHexCode:@"#4E5F6F"];
        _typeLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:_typeLabel];
        
        self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.typeLabel.frame),CGRectGetMaxY(self.titleLabel.frame), 100, 15)];
        _dateLabel.text = @"2015-07-12";
        _dateLabel.textColor = [UIColor colorFromHexCode:@"#4E5F6F"];
        _dateLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:_dateLabel];
        
        self.nextImageView = [[UIImageView alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH - 5 - 15, 29, 5, 8)];
        _nextImageView.image = [UIImage imageNamed:@"gj_jt_right.png"];
        [self addSubview:_nextImageView];

        self.customLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.titleImageView.frame) + 18, 50, UI_SCREEN_WIDTH-(CGRectGetMaxX(self.titleImageView.frame) + 18)-20, 30)];
        _customLabel.font = [UIFont systemFontOfSize:13];
        _customLabel.textColor = SUB_TITLE;
        _customLabel.text = @"顾客 12345678901";
        [self addSubview:_customLabel];
        
        UIView * line = [[UIView alloc] initWithFrame:CGRectMake(0, 80, UI_SCREEN_WIDTH, 1)];
        line.backgroundColor = LINE_SHALLOW_COLOR;
        [self addSubview:line];
        
    }
    return self;
}
- (void)updateDic:(NSDictionary *)dic
{
    
    NSDictionary * goodsinfoDic = [[dic objectForKey:@"goodsinfo"] objectAtIndex:0];
    NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[goodsinfoDic objectForKey:@"picurl"]]];
    [self.titleImageView af_setImageWithURL:url];
    
    self.totalLabel.text = [NSString stringWithFormat:@"总额:%@",[dic objectForKey:@"actual_pay_money"]];
    
    
    
    _customLabel.text = [NSString stringWithFormat:@"顾客 %@", [dic objectForKey:@"contact_name"]];
    self.judge = [[dic objectForKey:@"goods_totalnum"] intValue];
    if (_judge == 1) {
        self.GoodTotalNum.hidden = YES;
    }
    self.GoodTotalNum.text = [NSString stringWithFormat:@"等%@件",[dic objectForKey:@"goods_totalnum"]];
    
    self.titleLabel.text = [NSString stringWithFormat:@"%@",[goodsinfoDic objectForKey:@"subject"]];
    
    self.typeLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"is_pay_change"]];
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:_typeLabel.text attributes:nil];
    [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, _typeLabel.text.length)];
    
    if ([_typeLabel.text isEqualToString:@"待付款"])
    {
        [str addAttribute:NSForegroundColorAttributeName value:Red_Color range:NSMakeRange(0, _typeLabel.text.length)];
        _typeLabel.attributedText = str;
    }
    else if ([_typeLabel.text isEqualToString:@"退货中"])
    {
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorFromHexCode:@"eb3700"] range:NSMakeRange(0, _typeLabel.text.length)];
        _typeLabel.attributedText = str;
    }
    else
    {
        _typeLabel.textColor  = [UIColor colorFromHexCode:@"#4E5F6F"];
    }
    self.dateLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"create_time"]];
    
    CGSize totalSize = [self.totalLabel sizeThatFits:CGSizeMake(FLT_MAX, 15)];
    self.totalLabel.frame = CGRectMake(self.totalLabel.frame.origin.x, self.totalLabel.frame.origin.y, totalSize.width, 15);
    
    CGSize typeSize = [self.typeLabel sizeThatFits:CGSizeMake(FLT_MAX, 15)];
    self.typeLabel.frame =  CGRectMake(CGRectGetMaxX(self.totalLabel.frame)+5, CGRectGetMaxY(self.titleLabel.frame), typeSize.width, 15);
    
    CGSize dateSize = [self.dateLabel sizeThatFits:CGSizeMake(FLT_MAX, 15)];
    self.dateLabel.frame =  CGRectMake(CGRectGetMaxX(self.typeLabel.frame)+5, CGRectGetMaxY(self.titleLabel.frame), dateSize.width, 15);

}


@end
