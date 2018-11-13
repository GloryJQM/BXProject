//
//  MyDealerTableViewCell.m
//  SmallCEO
//
//  Created by huang on 15/8/21.
//  Copyright (c) 2015年 lemuji. All rights reserved.
//

#import "MyDealerTableViewCell.h"

@implementation MyDealerTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        NSInteger HeightForTopView = 44;
        
        self.backgroundColor = MONEY_COLOR;
        
        
        UIImageView *imageV=[[UIImageView alloc] initWithFrame:CGRectMake(5, 10, 24, 24)];
        imageV.backgroundColor=[UIColor clearColor];
        imageV.layer.cornerRadius=0;
        imageV.image=[UIImage imageNamed:@"iconfont-icon.png"];
        [self.contentView addSubview:imageV];

        self.dealerNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(33, 0, UI_SCREEN_WIDTH / 4-13, HeightForTopView)];
        self.dealerNameLabel.text = @"分销商名称";
        self.dealerNameLabel.font = [UIFont systemFontOfSize:12.0];
        self.dealerNameLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.dealerNameLabel];
        
        self.phoneButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH/4.0, 44)];
        self.phoneButton.backgroundColor=[UIColor clearColor];
        [self.contentView addSubview:self.phoneButton];
        
        
        self.dealerJoinTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH/4.0+20, 0, UI_SCREEN_WIDTH / 4, HeightForTopView)];
        self.dealerJoinTimeLabel.text = @"分销商加入日期";
        self.dealerJoinTimeLabel.font = [UIFont systemFontOfSize:12.0];
        self.dealerJoinTimeLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.dealerJoinTimeLabel];
        
        self.myRebatesLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.dealerJoinTimeLabel.frame), 0, UI_SCREEN_WIDTH / 4-5, HeightForTopView)];
        self.myRebatesLabel.text = @"我获得的返利";
        self.myRebatesLabel.font = [UIFont systemFontOfSize:12.0];
        self.myRebatesLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.myRebatesLabel];
        
        self.cheakSubLabel = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.myRebatesLabel.frame), 0, UI_SCREEN_WIDTH / 4-15, HeightForTopView)];
        [self.cheakSubLabel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.cheakSubLabel setTitle:@"查看" forState:UIControlStateNormal];
        self.cheakSubLabel.titleLabel.font = [UIFont systemFontOfSize:14.0];
        self.cheakSubLabel.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.cheakSubLabel.backgroundColor = App_Main_Color;
        [self.contentView addSubview:self.cheakSubLabel];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 43.5, UI_SCREEN_WIDTH, 0.5)];
        line.backgroundColor = LINE_SHALLOW_COLOR;
        [self.contentView addSubview:line];
    }
    
    return self;
}

- (void)updateContentWithInfoDic:(NSDictionary *)infoDic
{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
