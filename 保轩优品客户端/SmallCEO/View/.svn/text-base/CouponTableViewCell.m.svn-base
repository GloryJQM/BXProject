//
//  CouponTableViewCell.m
//  SmallCEO
//
//  Created by 俊严 on 15/10/20.
//  Copyright (c) 2015年 lemuji. All rights reserved.
//

#import "CouponTableViewCell.h"

@implementation CouponTableViewCell

- (instancetype)initWithSelecteButtonAndReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor colorFromHexCode:@"f5f5f5"];
        
        UIImageView * backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(55, 12,  617/2* adapterFactor - 55, 127/2)];
        backImageView.image = [UIImage imageNamed:@"cellBack.png"];
        [self.contentView addSubview:backImageView];
        self.backImageView = backImageView;
        
        CGFloat font = 15;
        if (IS_IPHONE4 || IS_IPHONE5) {
            font = 14;
        }
        
        self.typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 15, 410/2* adapterFactor-55, 20)];
        _typeLabel.text = @"全场通用";
        _typeLabel.font = [UIFont boldSystemFontOfSize:font];
        _typeLabel.textColor = [UIColor colorFromHexCode:@"46494a"];
        [backImageView addSubview:_typeLabel];
        
        self.useDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, CGRectGetMaxY(_typeLabel.frame), 200, 20)];
        _useDateLabel.text = @"使用期限: 2014-01-20至2015-12-16";
        
        _useDateLabel.font = [UIFont boldSystemFontOfSize:12];
        _useDateLabel.textColor = [UIColor colorFromHexCode:@"949497"];
        [backImageView addSubview:_useDateLabel];
        
        self.couponMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(backImageView.frame.size.width - 80-8, 10, 80, 20)];
        _couponMoneyLabel.text = @"￥20";
        
        _couponMoneyLabel.textAlignment = NSTextAlignmentRight;
        _couponMoneyLabel.textColor = WHITE_COLOR;
        [backImageView addSubview:_couponMoneyLabel];

        self.fullMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(backImageView.frame.size.width - 80-8, CGRectGetMaxY(_couponMoneyLabel.frame), 80, 20)];
        _fullMoneyLabel.text = @"满1000元使用";
        _fullMoneyLabel.textAlignment = NSTextAlignmentRight;
        
        _fullMoneyLabel.font = [UIFont boldSystemFontOfSize:12];
        _fullMoneyLabel.textColor = WHITE_COLOR;
        [backImageView addSubview:_fullMoneyLabel];
        
        
        UIButton *selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [selectButton setImage:[UIImage imageNamed:@"gj_pay_uns.png"] forState:UIControlStateNormal];
        [selectButton setImage:[UIImage imageNamed:@"gj_pay_is.png"] forState:UIControlStateSelected];
        selectButton.frame = CGRectMake(5, 12 + (127/2 - 45) / 2, 45, 45);
        [self.contentView addSubview:selectButton];
        selectButton.userInteractionEnabled = NO;
        self.selectButton = selectButton;
    }
    
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor colorFromHexCode:@"f5f5f5"];
        
        UIImageView * backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 12,  617/2* adapterFactor, 127/2)];
        backImageView.image = [UIImage imageNamed:@"cellBack.png"];
        [self.contentView addSubview:backImageView];
        self.backImageView = backImageView;
        
        self.useStatusLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 0, 55, 15)];
        self.useStatusLabel.text = @"";
        self.useStatusLabel.font = [UIFont systemFontOfSize:13.0];
        self.useStatusLabel.textColor = [UIColor whiteColor];
        self.useStatusLabel.textAlignment = NSTextAlignmentCenter;
        self.useStatusLabel.backgroundColor = Red_Color;
        self.useStatusLabel.hidden = YES;
        [backImageView addSubview:self.useStatusLabel];
        
        CGFloat font = 15;
        if (IS_IPHONE4 || IS_IPHONE5) {
            font = 14;
        }
        
        self.typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 15, 410/2* adapterFactor, 20)];
        _typeLabel.text = @"全场通用";
        _typeLabel.font = [UIFont boldSystemFontOfSize:font];
        _typeLabel.textColor = [UIColor colorFromHexCode:@"46494a"];
        [backImageView addSubview:_typeLabel];
        
        self.useDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, CGRectGetMaxY(_typeLabel.frame), 200, 20)];
        _useDateLabel.text = @"使用期限: 2014-01-20至2015-12-16";

        _useDateLabel.font = [UIFont boldSystemFontOfSize:12];
        _useDateLabel.textColor = [UIColor colorFromHexCode:@"949497"];
        [backImageView addSubview:_useDateLabel];

        self.couponMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(backImageView.frame.size.width - 80-8, 10, 80, 20)];
        _couponMoneyLabel.text = @"￥20";

        _couponMoneyLabel.textAlignment = NSTextAlignmentRight;
        _couponMoneyLabel.textColor = WHITE_COLOR;
        [backImageView addSubview:_couponMoneyLabel];
        
        
        
        self.fullMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(backImageView.frame.size.width - 80-8, CGRectGetMaxY(_couponMoneyLabel.frame), 80, 20)];
        _fullMoneyLabel.text = @"满1000元使用";
        _fullMoneyLabel.textAlignment = NSTextAlignmentRight;

        _fullMoneyLabel.font = [UIFont boldSystemFontOfSize:12];
        _fullMoneyLabel.textColor = WHITE_COLOR;
        [backImageView addSubview:_fullMoneyLabel];
    }
    return self;
}
- (void)updateCellData:(NSDictionary *)dic
{
    self.cellDic=[NSDictionary dictionaryWithDictionary:dic];
    self.CouponID =  [[dic objectForKey:@"id"] intValue];
    self.totalMoney = [[dic objectForKey:@"value"] doubleValue];

    _typeLabel.text= [NSString stringWithFormat:@"%@", [dic objectForKey:@"goods_name"]];
    _useDateLabel.text= [NSString stringWithFormat:@"%@", [dic objectForKey:@"time_status"]];
    _couponMoneyLabel.text= [NSString stringWithFormat:@"￥%@", [dic objectForKey:@"value"]];
    
    NSString* thStr = _couponMoneyLabel.text;
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:thStr attributes:nil];
    
    [str addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:14.0] range:NSMakeRange(0,1)];
    [str addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:19.0] range:NSMakeRange(1,thStr.length-1)];
    
    _couponMoneyLabel.attributedText = str;

    _fullMoneyLabel.text= [NSString stringWithFormat:@"满%@元使用", [dic objectForKey:@"chufajine"]];

    BOOL isUesed = [[dic objectForKey:@"pay_status"] isEqualToString:@"已使用"] || [[dic objectForKey:@"pay_status"] isEqualToString:@"已过期"];
    self.backImageView.image = isUesed ? [UIImage imageNamed:@"cellBack_used.png"] : [UIImage imageNamed:@"cellBack.png"];
    self.useStatusLabel.hidden = !isUesed;
    self.useStatusLabel.text = [dic objectForKey:@"pay_status"];
    DLog(@"self -- |%@",self.useStatusLabel.text);
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
