//
//  TipsSelectorView.m
//  HuaQi
//
//  Created by 黄建芳 on 8/4/16.
//  Copyright © 2016 lemuji. All rights reserved.
//

#import "TipsSelectorView.h"

#import "TipButton.h"

@interface TipsSelectorView ()

@property (nonatomic, strong) NSMutableArray *currentLineTips;
@property (nonatomic, strong) NSMutableSet *selectedTipButtons;



@end

@implementation TipsSelectorView

//- (instancetype)initWithTips:(NSArray <NSString *> *)tips
//{
//    if (self = [super init])
//    {
//        self.enableMultipleChoice = YES;
//        self.tips = tips;
//        self.frame = CGRectMake(0, 0, UI_SCREEN_WIDTH, 0);
//        [self setupMainView];
//    }
//    
//    return self;
//}

- (instancetype)initWithFrame:(CGRect)frame
{
    frame.size.height = 0;
    if (self = [super initWithFrame:frame])
    {
        self.enableMultipleChoice = YES;
        [self setupMainView];
    }
    
    return self;
}

- (void)setupMainView
{
    UIScrollView *mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.width, 0)];
    [self addSubview:mainScrollView];
    self.mainScrollView = mainScrollView;
    
    self.topTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, UI_SCREEN_WIDTH - 30, 40)];
//    _topTitleLabel.backgroundColor = [UIColor yellowColor];
    self.topTitleLabel.font = [UIFont systemFontOfSize:13.0];
    self.topTitleLabel.text = @"热门推荐";
    self.topTitleLabel.textColor = App_Main_Color;
    [mainScrollView addSubview:self.topTitleLabel];
    
    self.clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat sizeoff = 2.0f;
    UIImage *img = [UIImage imageNamed:@"icon_delete_history"];
    CGSize  imgSize = CGSizeMake(img.size.width/sizeoff, img.size.height/sizeoff);
    [_clearButton setImage:[img imageWithMinimumSize:imgSize] forState:UIControlStateNormal];
    _clearButton.frame = CGRectMake(self.width - 60, self.topTitleLabel.y, 60, 40);
    _clearButton.backgroundColor = [UIColor clearColor];
    [self.clearButton addTarget:self action:@selector(clearTips:) forControlEvents:UIControlEventTouchUpInside];
    [mainScrollView addSubview:self.clearButton];

    self.height = self.topTitleLabel.maxY;
    self.mainScrollView.frame = self.bounds;
}

#pragma mark - UIButton action method
- (void)clearTips:(UIButton *)button
{
    //[self.totalTipButtons makeObjectsPerformSelector:@selector(removeFromSuperview)];
    //[self.totalTipButtons removeAllObjects];
    //self.height = self.topTitleLabel.maxY;
    //self.mainScrollView.height = self.height;
    if ([self.delegate respondsToSelector:@selector(didClickClearButton:)])
    {
        [self.delegate didClickClearButton:button];
    }
}

- (void)selectTip:(TipButton *)button
{
    if (button.selected) return;

    if (!self.enableMultipleChoice)
    {
        for (TipButton *button in self.selectedTipButtons) {
            button.selected = NO;
        }
    }
    
    [self.selectedTipButtons addObject:button];
    
    if (!button.selected && [self.delegate respondsToSelector:@selector(selectTipsAtIndex:AndTag:)])
    {
        [self.delegate selectTipsAtIndex:button.tag AndTag:self.tag];
    }
    button.selected = !button.selected;
}

#pragma mark - Public methods
- (void)unselectTipButtonWithTitle:(NSString *)title
{
    for (TipButton *tipButton in self.selectedTipButtons)
    {
        if ([tipButton.titleLabel.text isEqualToString:title])
        {
            tipButton.selected = NO;
        }
    }
}

- (void)selectTipButtonWithTips:(NSArray *)tips
{
    for (NSString *tip in tips) {
        for (TipButton *tipButton in self.totalTipButtons)
        {
            if ([tipButton.titleLabel.text isEqualToString:tip])
            {
                tipButton.selected = YES;
                [self.selectedTipButtons addObject:tipButton];
            }
        }
    }
}

#pragma mark - Private methods
- (void)setupTipButtons
{
    self.totalTipButtons = [NSMutableArray new];
    self.selectedTipButtons = [NSMutableSet new];
    
    CGFloat leftOrRightOffset = 15.0;
    CGFloat buttonOrignalX = leftOrRightOffset;
    CGFloat buttonOrignalY = self.topTitleLabel.maxY + 10.0;
    CGFloat gapOfButtons = 15.0;
    self.currentLineTips = [NSMutableArray new];
    TipButton *lastTipButton = nil;
    for (NSInteger i = 0; i < self.tips.count; i++) {
        TipButton *tipButton = [TipButton defaultStyleTipButtonWithTitle:self.tips[i]];
        [self.mainScrollView addSubview:tipButton];
        tipButton.tag = i;
        [tipButton addTarget:self action:@selector(selectTip:) forControlEvents:UIControlEventTouchUpInside];
        [self.totalTipButtons addObject:tipButton];
        
        tipButton.frame = CGRectMake(buttonOrignalX, buttonOrignalY, tipButton.width, tipButton.height);
        buttonOrignalX = tipButton.maxX + gapOfButtons;
        
        if (buttonOrignalX > self.width - leftOrRightOffset)
        {
            [self.currentLineTips removeAllObjects];
            buttonOrignalY += (tipButton.height + 10);
            tipButton.frame = CGRectMake(leftOrRightOffset, buttonOrignalY, tipButton.width, tipButton.height);
            buttonOrignalX = tipButton.maxX + gapOfButtons;
            [self.currentLineTips addObject:tipButton];
        }
        else
        {
            [self.currentLineTips addObject:tipButton];
        }
        
        if (i == self.totalTipButtons.count - 1)
        {
            lastTipButton = tipButton;
        }
    }
    
    self.height = lastTipButton.maxY + 20;
    self.mainScrollView.frame = self.bounds;
}

#pragma mark - Setter
//- (void)setFrame:(CGRect)frame
//{
//    [super setFrame:frame];
//    self.mainScrollView.frame = CGRectMake(0, 0, self.width, self.height);
//}

- (void)setTips:(NSArray *)tips
{
    for (UIView *view in [self.mainScrollView subviews]) {
        if ([view isKindOfClass:[TipButton class]]) {
            [view removeFromSuperview];
        }
    }
    if (tips.count == 0) {
        self.height = self.topTitleLabel.maxY;
        self.mainScrollView.frame = self.bounds;
    }else {
        _tips = tips;
        [self setupTipButtons];
    }
    
}
- (void)unselectAll
{
    for (TipButton *button in self.selectedTipButtons) {
        button.selected = NO;
    }
}
@end
