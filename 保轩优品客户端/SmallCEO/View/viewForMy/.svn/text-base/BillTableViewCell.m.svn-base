//
//  BillTableViewCell.m
//  SmallCEO
//
//  Created by huang on 15/8/24.
//  Copyright (c) 2015年 lemuji. All rights reserved.
//

#import "BillTableViewCell.h"

@interface BillTableViewCell ()

@property (nonatomic, strong) UILabel *billTypeLabel;
@property (nonatomic, strong) UIImageView *billImageView;

@property (nonatomic, copy)   NSArray *typeNameArray;

@end

@implementation BillTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        _typeNameArray = [NSArray arrayWithObjects:@"入账", @"转出", nil];
        
        CGFloat gapFromEdge = 15.0;
        CGFloat labelHeight = 20.0;
        
        self.billImageView = [[UIImageView alloc] initWithFrame:CGRectMake(gapFromEdge, 9.5, 30, 30)];
        [self.contentView addSubview:self.billImageView];

        self.billTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.billImageView.frame) + gapFromEdge, 2, 0, labelHeight)];
        self.billTypeLabel.font = [UIFont systemFontOfSize:12.0];
        [self.contentView addSubview:self.billTypeLabel];

        self.billCharacterLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.billImageView.frame) + gapFromEdge, CGRectGetMaxY(self.billTypeLabel.frame), 0, labelHeight)];
        self.billCharacterLabel.font = [UIFont systemFontOfSize:12.0];
        [self.contentView addSubview:self.billCharacterLabel];

        self.moneyLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.moneyLabel.font = [UIFont systemFontOfSize:13.0];
        [self.contentView addSubview:self.moneyLabel];

        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.timeLabel.font = [UIFont systemFontOfSize:11.0];
        [self.contentView addSubview:self.timeLabel];

        UILabel *topDividingLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 1)];
        topDividingLine.backgroundColor = BACK_COLOR;
        [self addSubview:topDividingLine];
        UILabel *bottomDividingLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 48, UI_SCREEN_WIDTH, 1)];
        bottomDividingLine.backgroundColor = BACK_COLOR;
        [self addSubview:bottomDividingLine];
        
        [self addObserver:self forKeyPath:@"type" options:NSKeyValueObservingOptionNew context:nil];
        [self addObserver:self forKeyPath:@"billCharacterLabel.text" options:NSKeyValueObservingOptionNew context:nil];
        [self addObserver:self forKeyPath:@"moneyLabel.text" options:NSKeyValueObservingOptionNew context:nil];
        [self addObserver:self forKeyPath:@"timeLabel.text" options:NSKeyValueObservingOptionNew context:nil];
    }
    
    return self;
}

#pragma mark - KVO
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"billCharacterLabel.text"])
    {
        CGSize sizeForBillCharacterLabel = [self.billCharacterLabel sizeThatFits:CGSizeMake(UI_SCREEN_WIDTH, 20)];
        CGRect frameForBillCharacterLabel = self.billCharacterLabel.frame;
        frameForBillCharacterLabel.size.width = sizeForBillCharacterLabel.width;
        self.billCharacterLabel.frame = frameForBillCharacterLabel;
    }
    else if ([keyPath isEqualToString:@"moneyLabel.text"])
    {
        CGSize sizeForMoneyLabel = [self.moneyLabel sizeThatFits:CGSizeMake(UI_SCREEN_WIDTH, 20)];
        self.moneyLabel.frame = CGRectMake(UI_SCREEN_WIDTH - 15 - sizeForMoneyLabel.width, CGRectGetMinY(self.billTypeLabel.frame), sizeForMoneyLabel.width, 20);
    }
    else if ([keyPath isEqualToString:@"timeLabel.text"])
    {
        CGSize sizeForTimeLabel = [self.timeLabel sizeThatFits:CGSizeMake(UI_SCREEN_WIDTH, 20)];
        self.timeLabel.frame = CGRectMake(UI_SCREEN_WIDTH - 15 - sizeForTimeLabel.width, CGRectGetMinY(self.billCharacterLabel.frame), sizeForTimeLabel.width, 20);
    }
    else if ([keyPath isEqualToString:@"type"])
    {
        self.billTypeLabel.text = [_typeNameArray objectAtIndex:self.type];
        CGSize sizeForBillTypeLabel = [self.timeLabel sizeThatFits:CGSizeMake(UI_SCREEN_WIDTH, 20)];
        CGRect frameForBillTypeLabel = self.billTypeLabel.frame;
        frameForBillTypeLabel.size.width = sizeForBillTypeLabel.width;
        self.billTypeLabel.frame = frameForBillTypeLabel;
        
        switch (self.type) {
            case BillTypeImport:
            {
                self.billImageView.image = [UIImage imageNamed:@"bill_import.png"];
                break;
            }
            case BillTypeExport:
            {
                self.billImageView.image = [UIImage imageNamed:@"bill_export.png"];
                break;
            }
            default:
                break;
        }
        
    }
}

#pragma mark -
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"type"];
    [self removeObserver:self forKeyPath:@"billCharacterLabel.text"];
    [self removeObserver:self forKeyPath:@"moneyLabel.text"];
    [self removeObserver:self forKeyPath:@"timeLabel.text"];
}

@end
