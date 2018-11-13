//
//  BillsTableViewCell.m
//  Jiang
//
//  Created by peterwang on 17/2/28.
//  Copyright © 2017年 quanmai. All rights reserved.
//

#import "BillsTableViewCell.h"

@implementation BillsTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _tipImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 60-20, 60-20)];
        
        _moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(_tipImage.maxX+10, 10, UI_SCREEN_WIDTH-60, 20)];
        _moneyLabel.text = @"＋20";
        _moneyLabel.font = [UIFont systemFontOfSize:18];
        
        _detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(_tipImage.maxX+10, 30, UI_SCREEN_WIDTH-_tipImage.maxX-70, 20)];
        _detailLabel.text = @"现金收入";
        _detailLabel.textColor = [UIColor colorFromHexCode:@"#666666"];
        _detailLabel.font = [UIFont systemFontOfSize:13];
        
        _dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(UI_SCREEN_WIDTH-95, _tipImage.centerY-10, 90, 20)];
        _dateLabel.text = @"2017.02.01";
        
        _dateLabel.textColor = [UIColor colorFromHexCode:@"#666666"];
        _dateLabel.textAlignment = NSTextAlignmentRight;
        _detailLabel.font = [UIFont systemFontOfSize:12];
        
        [self.contentView addSubview:_tipImage];
        [self.contentView addSubview:_detailLabel];
        [self.contentView addSubview:_moneyLabel];
        [self.contentView addSubview:_dateLabel];
    
    }
    return self;
}
    
@end
