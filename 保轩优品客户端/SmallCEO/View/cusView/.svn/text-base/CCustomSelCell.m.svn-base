//
//  CCustomSelCell.m
//  WanHao
//
//  Created by Cai on 15-1-6.
//  Copyright (c) 2015年 wuxiaohui. All rights reserved.
//

#import "CCustomSelCell.h"

@implementation CCustomSelCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 5.0, 470.0/2.0-10.0, 30.0)];
        _titleLab.backgroundColor = [UIColor clearColor];
        _titleLab.textAlignment = NSTextAlignmentLeft;
        _titleLab.font = [UIFont systemFontOfSize:17.0];
        _titleLab.textColor = [UIColor blackColor];
        //        _titleLab.backgroundColor = [UIColor colorFromHexCode:@"#2e80b2"];
        [self addSubview:_titleLab];
        _titleLab.adjustsFontSizeToFitWidth = YES;
        
        _linelab = [[UILabel alloc] initWithFrame:CGRectMake(0, 39.5, 470.0/2.0, 0.5)];
        _linelab.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:_linelab];
    }
    return self;
}

-(void)reloadData:(NSString *)title
{
    _titleLab.text = [NSString stringWithFormat:@"%@",title];
}

-(void)lineIsDisappear:(BOOL)isDisappear
{
    _linelab.hidden = isDisappear;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
