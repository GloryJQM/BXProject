//
//  LogisticsDetailCell.m
//  Lemuji
//
//  Created by Cai on 15-8-3.
//  Copyright (c) 2015年 quanmai. All rights reserved.
//

#import "LogisticsDetailCell.h"

@interface LogisticsDetailCell ()

@property (nonatomic, strong) UILabel *line;
@property (nonatomic, strong) UILabel *seperateLine;

@end

@implementation LogisticsDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.userInteractionEnabled = NO;
        
        self.line = [[UILabel alloc] initWithFrame:CGRectMake(self.statusButton.center.x, 0, 1, 0)];
        self.line.backgroundColor = LINE_DEEP_COLOR;
        [self addSubview:self.line];
        
        self.seperateLine = [[UILabel alloc] initWithFrame:CGRectMake(46 * adapterFactor, 0, UI_SCREEN_WIDTH - 46 * adapterFactor - 10, 0.5)];
        self.seperateLine.backgroundColor = LINE_DEEP_COLOR;
        [self addSubview:self.seperateLine];

        self.statusButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 20, 20)];
        self.statusButton .backgroundColor=[UIColor clearColor];
        self.statusButton.layer.cornerRadius=0;
        [self.statusButton setImage:[UIImage imageNamed:@"shop_cart_noselected"] forState:UIControlStateNormal];
        [self.statusButton setImage:[UIImage imageNamed:@"shop_cart_selected"] forState:UIControlStateSelected];
        [self addSubview:self.statusButton];
        
        self.mainInfoLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.timeInfoLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.mainInfoLabel.textColor = LINE_DEEP_COLOR;
        self.timeInfoLabel.textColor = LINE_DEEP_COLOR;
        self.mainInfoLabel.font = [UIFont systemFontOfSize:15];
        self.mainInfoLabel.numberOfLines = 0;
        self.timeInfoLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:self.mainInfoLabel];
        [self addSubview:self.timeInfoLabel];
        
        [self addObserver:self forKeyPath:@"isLastStatus" options:NSKeyValueObservingOptionNew context:nil];
        [self addObserver:self forKeyPath:@"mainInfoLabel.text" options:NSKeyValueObservingOptionNew context:nil];
        [self addObserver:self forKeyPath:@"timeInfoLabel.text" options:NSKeyValueObservingOptionNew context:nil];
    }
    
    return self;
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"mainInfoLabel.text"])
    {
        CGSize size = [self.mainInfoLabel sizeThatFits:CGSizeMake(UI_SCREEN_WIDTH - 46 * adapterFactor - 10, FLT_MAX)];
        self.mainInfoLabel.frame = CGRectMake(46 * adapterFactor, 10, size.width, size.height);
    }
    else if ([keyPath isEqualToString:@"timeInfoLabel.text"])
    {
        CGSize size = [self.timeInfoLabel sizeThatFits:CGSizeMake(UI_SCREEN_WIDTH - 46 * adapterFactor - 10, FLT_MAX)];
        self.timeInfoLabel.frame = CGRectMake(46 * adapterFactor, self.mainInfoLabel.frame.size.height + 10, size.width, size.height);
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.timeInfoLabel.frame.size.height + self.mainInfoLabel.frame.size.height);
        
        self.line.frame = CGRectMake(self.statusButton.center.x, 0, 1, self.frame.size.height + 20);
    }
    else if ([keyPath isEqualToString:@"isLastStatus"])
    {
        self.statusButton.selected = self.isLastStatus;
        CGFloat centerY = self.isLastStatus ? self.statusButton.center.y : 0;
        CGFloat height = self.isLastStatus ?  self.frame.size.height + 10 : self.frame.size.height + 20;
        self.line.frame = CGRectMake(self.statusButton.center.x, centerY, 1, height);
        self.seperateLine.hidden = self.isLastStatus;
        self.mainInfoLabel.textColor = self.isLastStatus ? App_Main_Color : LINE_DEEP_COLOR;
        self.timeInfoLabel.textColor = self.isLastStatus ? App_Main_Color : LINE_DEEP_COLOR;
    }
}

#pragma mark -
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"mainInfoLabel.text"];
    [self removeObserver:self forKeyPath:@"timeInfoLabel.text"];
    [self removeObserver:self forKeyPath:@"isLastStatus"];
}

@end
