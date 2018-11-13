//
//  RecordCell.m
//  SmallCEO
//
//  Created by 俊严 on 15/8/23.
//  Copyright (c) 2015年 lemuji. All rights reserved.
//

#import "RecordCell.h"

@implementation RecordCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.phoneNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 150, 20)];
        _phoneNumLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:_phoneNumLabel];
        
        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH - 15 - 150, 10, 150, 20)];
        _timeLabel.textAlignment = NSTextAlignmentRight;
        _timeLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:_timeLabel];
        
        UIView * line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 40, UI_SCREEN_WIDTH, 1)];
        line1.backgroundColor = [UIColor grayColor];
        [self addSubview:line1];
        
    }
    return self;
}

- (void)updateDic:(NSDictionary *)dic
{
    self.phoneNumLabel.text = [NSString stringWithFormat:@"%@", [dic objectForKey:@"ip"]];
    
    self.timeLabel.text = [NSString stringWithFormat:@"%@", [dic objectForKey:@"posttime"]];

}
- (void)updateDicInGoods:(NSDictionary *)dic
{
    self.phoneNumLabel.text = [NSString stringWithFormat:@"%@", [dic objectForKey:@"customer_name"]];
    
    self.timeLabel.text = [NSString stringWithFormat:@"%@", [dic objectForKey:@"posttime"]];
    
}
@end
