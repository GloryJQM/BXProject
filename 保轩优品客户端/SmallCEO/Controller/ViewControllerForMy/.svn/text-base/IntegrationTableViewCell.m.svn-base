//
//  IntegrationTableViewCell.m
//  SmallCEO
//
//  Created by 俊严 on 15/10/19.
//  Copyright (c) 2015年 lemuji. All rights reserved.
//

#import "IntegrationTableViewCell.h"

@implementation IntegrationTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
      
        
        self.goodsImageView = [[UIImageView alloc] initWithFrame:CGRectMake(13, 18, 78, 72)];
        [self.contentView addSubview:_goodsImageView];
        
        self.goodsTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.goodsImageView.frame)+9, 20, self.frame.size.width - (CGRectGetMaxX(self.goodsImageView.frame)+9)-100, 30)];
        _goodsTitleLabel.text = @"和国际化空间看见就看见看见";
        _goodsTitleLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_goodsTitleLabel];
        
        
        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width -100-10, 20, 100, 30)];
        _timeLabel.text = @"前天20:26";
        _timeLabel.font = [UIFont systemFontOfSize:12];
        _timeLabel.textAlignment = NSTextAlignmentRight;
        _timeLabel.textColor = [UIColor colorFromHexCode:@"4e5253"];
        [self.contentView addSubview:_timeLabel];

        self.typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.goodsImageView.frame)+9, 20+30, 100, 30)];
        _typeLabel.text = @"购物积分";
        _typeLabel.font = [UIFont systemFontOfSize:13];
//        _typeLabel.textAlignment = NSTextAlignmentCenter;
        _typeLabel.textColor = [UIColor colorFromHexCode:@"fc554c"];
        [self.contentView addSubview:_typeLabel];

        self.integrationLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width -100-10, 20+30, 100, 30)];
        _integrationLabel.text = @"+100";
        _integrationLabel.font = [UIFont systemFontOfSize:13];
                _integrationLabel.textAlignment = NSTextAlignmentRight;
        _integrationLabel.textColor = [UIColor colorFromHexCode:@"fc2a33"];
        [self.contentView addSubview:_integrationLabel];
        
        UIView * line = [[UIView alloc] initWithFrame:CGRectMake(0, 97, UI_SCREEN_WIDTH, 1)];
        line.backgroundColor = LINE_SHALLOW_COLOR;
        [self.contentView addSubview:line];
        
    }
    return self;
}
- (void)updateCellDate:(NSDictionary *)dic
{
    self.goodsTitleLabel.text = [NSString stringWithFormat:@"%@", [dic objectForKey:@"goods_name"]];
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@", [dic objectForKey:@"img"]]];
    [_goodsImageView af_setImageWithURL:url];
    _typeLabel.text = [NSString stringWithFormat:@"%@", [dic objectForKey:@"point_type_txt"]];
//    NSString * dateStr = [self convertDateFromString:[dic objectForKey:@"point_type_txt"]];
    _timeLabel.text = [NSString stringWithFormat:@"%@", [dic objectForKey:@"time_txt"]];
    _integrationLabel.text =[NSString stringWithFormat:@"%@", [dic objectForKey:@"point"]];
}

- (NSString *)convertDateFromString:(NSString*)dateStr
{
    NSTimeInterval time = [dateStr doubleValue];
    NSDate *detailDate = [NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:MM"];
    NSString *currentDateStr = [formatter stringFromDate: detailDate];
    return currentDateStr;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
