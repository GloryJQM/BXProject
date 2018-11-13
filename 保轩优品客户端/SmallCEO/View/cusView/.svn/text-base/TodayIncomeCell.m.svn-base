//
//  TodayIncomeCell.m
//  SmallCEO
//
//  Created by 俊严 on 15/8/23.
//  Copyright (c) 2015年 lemuji. All rights reserved.
//

#import "TodayIncomeCell.h"

@implementation TodayIncomeCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = WHITE_COLOR;
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, (UI_SCREEN_WIDTH - 20) / 3, 20)];
        _titleLabel.text = @"华为 b2手环";
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
        
        self.incomeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10 + (UI_SCREEN_WIDTH - 20) / 3 , 10, (UI_SCREEN_WIDTH - 20) / 3, 20)];
        _incomeLabel.text = @"+356";
        _incomeLabel.font = [UIFont systemFontOfSize:14];
        _incomeLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_incomeLabel];
        
        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10+ (UI_SCREEN_WIDTH - 20) / 3 * 2, 10, (UI_SCREEN_WIDTH - 20) / 3, 20)];
        _timeLabel.text = @"18:24";
        _timeLabel.font = [UIFont systemFontOfSize:14];
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_timeLabel];
        
        UIView * line = [[UIView alloc] initWithFrame:CGRectMake(0, 40, UI_SCREEN_WIDTH, 1)];
        line.backgroundColor = [UIColor grayColor];
        [self addSubview:line];
        
    }
    return self;
}

- (void)updateDic:(NSDictionary *)dic
{
    self.timeLabel.text = [NSString stringWithFormat:@"%@", [dic objectForKey:@"posttime"]];
    
    self.titleLabel.text = [NSString stringWithFormat:@"%@", [dic objectForKey:@"subject"]];
    
    self.incomeLabel.text = [NSString stringWithFormat:@"%@", [dic objectForKey:@"lirun"]];
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
