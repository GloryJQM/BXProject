//
//  CustomTableViewCell.m
//  Test
//
//  Created by 俊严 on 15/10/13.
//  Copyright (c) 2015年 俊严. All rights reserved.
//

#import "CustomTableViewCell.h"
#import "CustomView.h"
@implementation CustomTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
       
        self.backgroundColor = MONEY_COLOR;
        
        
        self.customView = [[CustomView alloc] initWithDataStr:@"2012-10-11" percentageStr:0.7 isHighlighted:YES];
        _customView.frame = CGRectMake(20, 10, [UIScreen mainScreen].bounds.size.width- 40, 50);
        _customView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_customView];
    }
    return self;

}
- (void)updata:(NSDictionary *)dic max:(double)max min:(double)min
{
    _customView.isInt = self.isInt;
    if (self.isInt) {
        [self updata:[dic objectForKey:@"date"] allMoney:[[dic objectForKey:@"record"] doubleValue] max:max min:min];
    }else {
        [self updata:[dic objectForKey:@"date"] allMoney:[[dic objectForKey:@"income"] doubleValue] max:max min:min];
    }
}
- (void)updataTime:(NSDictionary *)dic max:(double)max min:(double)min
{
    NSString *hour = [NSString stringWithFormat:@"  %@:00",[dic objectForKey:@"hour"]];
    _customView.isInt = self.isInt;
    if (self.isInt) {
        [self updata:hour allMoney:[[dic objectForKey:@"record"] doubleValue] max:max min:min];
    }else {
        [self updata:hour allMoney:[[dic objectForKey:@"income"] doubleValue] max:max min:min];
    }
}

- (void)updata:(NSString *)date allMoney:(double)allCoin max:(double)max min:(double)min
{
    
    [self.customView updateCellData:date percentage:allCoin max:max min:min];

}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
