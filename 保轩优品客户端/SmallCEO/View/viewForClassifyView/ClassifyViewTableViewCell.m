//
//  ClassifyViewTableViewCell.m
//  SmallCEO
//
//  Created by ni on 17/2/27.
//  Copyright © 2017年 lemuji. All rights reserved.
//

#import "ClassifyViewTableViewCell.h"

@implementation ClassifyViewTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"ClassifyViewTableViewCell";
    ClassifyViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ClassifyViewTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.height = 50;
        
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.frame = CGRectMake(2, 0, self.width-2, self.height);
        _contentLabel.backgroundColor = [UIColor clearColor];
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        _contentLabel.font = [UIFont systemFontOfSize:13.0];
        [self.contentView addSubview:_contentLabel];
        
        UIView *moveLine =  [[UIView alloc] init];
        moveLine.frame = CGRectMake(0, 0, 2, self.height);
        moveLine.backgroundColor = App_Main_Color;
        [self.contentView addSubview:moveLine];
        moveLine.hidden = YES;
        self.leftLine = moveLine;
        
    }
    return self;
}

- (void)layoutSubviews
{
    self.contentLabel.frame = CGRectMake(2, 0, self.width-2, self.height);
    self.leftLine.frame = CGRectMake(0, 0, 2, self.height);
}

@end
