//
//  BankCardManagerTableViewCell.m
//  SmallCEO
//
//  Created by huang on 15/8/27.
//  Copyright (c) 2015年 lemuji. All rights reserved.
//

#import "BankCardManagerTableViewCell.h"

@implementation BankCardManagerTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.bankImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, bankCardManagerCellHeight - 20, bankCardManagerCellHeight - 20)];
        [self.contentView addSubview:self.bankImageView];
        
        UIImageView *arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH - 23, (bankCardManagerCellHeight - 12) / 2, 8, 12)];
        arrowImageView.image = [UIImage imageNamed:@"gj_jt_right.png"];
        [self.contentView addSubview:arrowImageView];
        
        self.bankNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15 + CGRectGetMaxX(self.bankImageView.frame), 10, UI_SCREEN_WIDTH - 60 - CGRectGetWidth(self.bankImageView.frame), bankCardManagerCellHeight / 2 - 10)];
        [self.contentView addSubview:self.bankNameLabel];
        
        self.bankCardInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(15 + CGRectGetMaxX(self.bankImageView.frame), CGRectGetMaxY(self.bankNameLabel.frame), UI_SCREEN_WIDTH - 60 - CGRectGetWidth(self.bankImageView.frame), bankCardManagerCellHeight / 2 - 10)];
        self.bankCardInfoLabel.textColor = [UIColor colorFromHexCode:@"a4a4a8"];
        self.bankCardInfoLabel.font = [UIFont systemFontOfSize:15.0];
        [self.contentView addSubview:self.bankCardInfoLabel];
        
        UILabel *seperateLine = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.bankNameLabel.frame), bankCardManagerCellHeight - 0.5, UI_SCREEN_WIDTH - CGRectGetMinX(self.bankNameLabel.frame), 0.5)];
        seperateLine.backgroundColor = [UIColor colorFromHexCode:@"e5e5e5"];
        [self.contentView addSubview:seperateLine];
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
