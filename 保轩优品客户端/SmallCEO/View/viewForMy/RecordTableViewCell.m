//
//  RecordTableViewCell.m
//  SmallCEO
//
//  Created by gaojun on 15-8-25.
//  Copyright (c) 2015年 lemuji. All rights reserved.
//

#import "RecordTableViewCell.h"

@implementation RecordTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createRecordTableView];
    }
    return self;
}

- (void)createRecordTableView
{
    _recordImageView = [[UIImageView alloc]init];
    _recordImageView.frame = CGRectMake(15, 9.5, 30, 30);
    _recordImageView.backgroundColor = [UIColor clearColor];
    _recordImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:_recordImageView];
    
    _appplyLable = [[UILabel alloc]init];
    _appplyLable.frame = CGRectMake(55, 0, 120, 49);
    _appplyLable.font = [UIFont systemFontOfSize:15.0];
    _appplyLable.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_appplyLable];
    
    _timeLable = [[UILabel alloc]init];
    _timeLable.frame = CGRectMake(UI_SCREEN_WIDTH - 100-10, 14, 100, 35);
    _timeLable.textAlignment=NSTextAlignmentRight;
    _timeLable.backgroundColor = [UIColor whiteColor];
    _timeLable.font = [UIFont systemFontOfSize:11.0];
    _timeLable.textColor = [UIColor colorFromHexCode:@"a4a4a8"];
    [self.contentView addSubview:_timeLable];
    
    _view = [[UIView alloc]init];
    _view.frame = CGRectMake(0, 48, UI_SCREEN_WIDTH, 1);
    _view.backgroundColor = [UIColor colorFromHexCode:@"e5e5e5"];
    [self.contentView addSubview:_view];
}

-(void)updateUIwithDic:(NSDictionary *)dic {
    NSString *status = [NSString stringWithFormat:@"%@",[dic valueForKey:@"status"]];
    if ([status isEqualToString:@"1"])
    {
        _recordImageView.image = [UIImage imageNamed:@"gj_wait.png"];
    }
    else if ([status isEqualToString:@"2"])
    {
        _recordImageView.image = [UIImage imageNamed:@"gj_ok.png"];
    }
    else if ([status isEqualToString:@"3"])
    {
        _recordImageView.image = [UIImage imageNamed:@"gj_error.png"];
    }
    
    _appplyLable.text = [NSString stringWithFormat:@"%@",[dic valueForKey:@"status_txt"]];
    NSString *dateStr = [NSString stringWithFormat:@"%@",[dic valueForKey:@"apply_time"]];
    NSArray *dateArray = [dateStr componentsSeparatedByString:@"-"];
    NSString *monthStr = [dateArray objectAtIndex:0];
    if ([[monthStr substringToIndex:1] isEqualToString:@"0"])
    {
        monthStr = [monthStr substringFromIndex:1];
    }
    
    NSString *dayStr = [dateArray objectAtIndex:1];
    if ([[dayStr substringToIndex:1] isEqualToString:@"0"])
    {
        dayStr = [dayStr substringFromIndex:1];
    }
    _timeLable.text = [NSString stringWithFormat:@"%@月%@日", monthStr, dayStr];
}

@end
