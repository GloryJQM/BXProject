//
//  GeneralInfoTableViewCell.m
//  SmallCEO
//
//  Created by huang on 15/8/21.
//  Copyright (c) 2015年 lemuji. All rights reserved.
//

#import "GeneralInfoTableViewCell.h"

const NSInteger distanceFromEdge = 15;

@interface GeneralInfoTableViewCell ()

@property (nonatomic, assign) GeneralInfoViewType viewType;

@end

@implementation GeneralInfoTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self createSubViewWithFrame:frame];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame type:(GeneralInfoViewType)type
{
    if (self = [super initWithFrame:frame])
    {
        self.viewType = type;
        [self createSubViewWithFrame:frame];
    }
    
    return self;
}

- (void)createSubViewWithFrame:(CGRect)frame
{
    self.leftTextLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.leftTextLabel.font = [UIFont systemFontOfSize:15.0];
    self.leftTextLabel.textColor = [UIColor colorFromHexCode:@"505059"];
    self.leftTextLabel.hidden = YES;
    [self addSubview:self.leftTextLabel];
    
    self.detailTextLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    if (self.viewType == GeneralInfoViewTypeDefalut)
    {
        self.detailTextLabel.font = [UIFont systemFontOfSize:14.0];
    }
    else
    {
        self.detailTextLabel.font = [UIFont systemFontOfSize:10.0];
    }
    self.detailTextLabel.hidden = YES;
    [self addSubview:self.detailTextLabel];
    
    self.rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.height, frame.size.height)];
    self.rightImageView.hidden = YES;
    [self addSubview:self.rightImageView];

    [self addObserver:self forKeyPath:@"leftTextLabel.text" options:NSKeyValueObservingOptionNew context:nil];
    [self addObserver:self forKeyPath:@"detailTextLabel.text" options:NSKeyValueObservingOptionNew context:nil];
    [self addObserver:self forKeyPath:@"rightImageView.image" options:NSKeyValueObservingOptionNew context:nil];
    
    UILabel *bottomSeparatedLine = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height - 1, UI_SCREEN_WIDTH, 1)];
    bottomSeparatedLine.backgroundColor = [UIColor colorFromHexCode:@"e5e5e5"];
    [self addSubview:bottomSeparatedLine];
    
    UILabel *topSeparatedLine = [[UILabel alloc] initWithFrame:CGRectMake(0, -1, UI_SCREEN_WIDTH, 1)];
    topSeparatedLine.backgroundColor = [UIColor colorFromHexCode:@"e5e5e5"];
    [self addSubview:topSeparatedLine];
    self.backgroundColor = [UIColor whiteColor];
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"leftTextLabel.text"] &&
        self.viewType == GeneralInfoViewTypeDefalut)
    {
        CGSize sizeForTextLabel = [self.leftTextLabel sizeThatFits:CGSizeMake(UI_SCREEN_WIDTH, self.frame.size.height)];
        self.leftTextLabel.frame = CGRectMake(distanceFromEdge, (self.frame.size.height - sizeForTextLabel.height) / 2, sizeForTextLabel.width, sizeForTextLabel.height);
        self.leftTextLabel.hidden = NO;
    }
    else if ([keyPath isEqualToString:@"leftTextLabel.text"] &&
             self.viewType == GeneralInfoViewTypeWithDetailLabel)
    {
        CGSize sizeForTextLabel = [self.leftTextLabel sizeThatFits:CGSizeMake(UI_SCREEN_WIDTH, self.frame.size.height)];
        CGFloat frameOfTop = self.detailTextLabel.text.length != 0 ? (self.frame.size.height - sizeForTextLabel.height) / 2 - 7 : (self.frame.size.height - sizeForTextLabel.height) / 2;
        self.leftTextLabel.frame = CGRectMake(distanceFromEdge, frameOfTop, sizeForTextLabel.width, sizeForTextLabel.height);
        self.leftTextLabel.hidden = NO;
    }
    else if ([keyPath isEqualToString:@"detailTextLabel.text"] &&
             self.viewType == GeneralInfoViewTypeDefalut)
    {
        CGSize sizeForTextLabel = [self.detailTextLabel sizeThatFits:CGSizeMake(UI_SCREEN_WIDTH, self.frame.size.height)];
        if (self.rightImageView.image == nil)
        {
            self.detailTextLabel.frame = CGRectMake(self.frame.size.width - sizeForTextLabel.width - distanceFromEdge, (self.frame.size.height - sizeForTextLabel.height) / 2, sizeForTextLabel.width, sizeForTextLabel.height);
        }
        else
        {
            self.detailTextLabel.frame = CGRectMake(CGRectGetMinX(self.rightImageView.frame) - sizeForTextLabel.width - 5, (self.frame.size.height - sizeForTextLabel.height) / 2, sizeForTextLabel.width, sizeForTextLabel.height);
        }
        self.detailTextLabel.hidden = NO;
    }
    else if ([keyPath isEqualToString:@"detailTextLabel.text"] &&
             self.viewType == GeneralInfoViewTypeWithDetailLabel)
    {
        CGSize sizeForTextLabel = [self.detailTextLabel sizeThatFits:CGSizeMake(UI_SCREEN_WIDTH, 15)];
        self.detailTextLabel.frame = CGRectMake(distanceFromEdge, self.frame.size.height - sizeForTextLabel.height - 7, sizeForTextLabel.width, sizeForTextLabel.height);
        self.detailTextLabel.hidden = NO;
        
        CGFloat frameOfTop = (self.frame.size.height - self.leftTextLabel.frame.size.height) / 2;
        if (self.leftTextLabel.frame.origin.y == frameOfTop)
        {
            CGRect frame = self.leftTextLabel.frame;
            frame.origin.y -= 7;
            self.leftTextLabel.frame = frame;
        }
        
    }
    else if ([keyPath isEqualToString:@"rightImageView.image"] &&
             self.rightImageView.image != nil)
    {
        CGRect frameForImageView = self.rightImageView.frame;
        frameForImageView.size = CGSizeMake(self.rightImageView.image.size.width, self.rightImageView.image.size.height);
        frameForImageView.origin = CGPointMake(self.frame.size.width - self.rightImageView.image.size.width - 10, (self.frame.size.height - self.rightImageView.image.size.height) / 2);
        self.rightImageView.frame = frameForImageView;
        self.rightImageView.hidden = NO;
        
        if (self.viewType == GeneralInfoViewTypeDefalut)
        {
            self.detailTextLabel.text = self.detailTextLabel.text;
        }
    }
    else if ([keyPath isEqualToString:@"rightImageView.image"] &&
             self.rightImageView.image == nil)
    {
        self.rightImageView.hidden = YES;
    }
}

#pragma mark -
- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"leftTextLabel.text"];
    [self removeObserver:self forKeyPath:@"rightImageView.image"];
    [self removeObserver:self forKeyPath:@"detailTextLabel.text"];
}

@end
