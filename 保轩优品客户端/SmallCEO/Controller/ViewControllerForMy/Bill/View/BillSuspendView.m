//
//  BillSuspendView.m
//  Jiang
//
//  Created by peterwang on 17/3/2.
//  Copyright © 2017年 quanmai. All rights reserved.
//

#import "BillSuspendView.h"
#import "BillSuspendButton.h"

const CGFloat BillSuspendedViewHeight = 40.0;

@interface BillSuspendView ()

@property (nonatomic, strong) UIScrollView *contentScrollView;
@property (nonatomic, strong) UIView *bottomSelectedLineView;

@property (nonatomic, strong) NSMutableArray *itemButtons;
@property (nonatomic, strong) NSMutableArray *verticalLineViews;
@property (nonatomic, strong) UIFont *defaultFont;
@property (nonatomic, assign) BillSuspendedViewStyle suspendedViewStyle;

@end

@implementation BillSuspendView

- (instancetype)initWithSuspendedViewStyle:(BillSuspendedViewStyle)style
{
    if (self = [super init])
    {
        self.defaultFont = [UIFont systemFontOfSize:12.0];
        self.suspendedViewStyle = style;
    }
    
    return self;
}

#pragma mark - Setup Method
- (void)setupMainView
{
    self.itemButtons = [NSMutableArray new];
    self.verticalLineViews = [NSMutableArray new];
    UIScrollView *contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    contentScrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:contentScrollView];
    self.contentScrollView = contentScrollView;
    CGFloat lastestButtonMaxX = 0;
    for (NSInteger i = 0; i < self.items.count; i++) {
        
        
        if (i == 0)
        {
            BillSuspendButton *button = [BillSuspendButton defaultStyleButtonWithTitle:self.items[i]];
            [button addTarget:self action:@selector(clickItemButton:) forControlEvents:UIControlEventTouchUpInside];
            button.tag = i;
            button.frame = CGRectMake(lastestButtonMaxX, 0, button.width + 30, self.height);
            lastestButtonMaxX = button.maxX;
            [contentScrollView addSubview:button];
            [self.itemButtons addObject:button];
            button.selected = i == 0;
            
            [self initBottomLineViewWithButton:button];
            [contentScrollView addSubview:self.bottomSelectedLineView];
        }
        else
        {
            
            UIImage *image;
            if (i == 1) {
                image = [UIImage imageNamed:@"pho-shouru1"];
            }else {
                image = [UIImage imageNamed:@"pho-zhichu1@2x"];
            }
            BillSuspendButton *button = [BillSuspendButton layoutButtonWithimage:image Andtitle:self.items[i]];
            [button addTarget:self action:@selector(clickItemButton:) forControlEvents:UIControlEventTouchUpInside];
            button.tag = i;
            button.frame = CGRectMake(lastestButtonMaxX, 0, button.width + 30, self.height);
            lastestButtonMaxX = button.maxX;
            [contentScrollView addSubview:button];
            [self.itemButtons addObject:button];
            button.selected = i == 0;
            
            UIView *verticalLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 14, 1, 15)];
            verticalLineView.backgroundColor = [UIColor colorFromHexCode:@"#e6e6e6"];
            [contentScrollView addSubview:verticalLineView];
            [self.verticalLineViews addObject:verticalLineView];
        }
    }
    contentScrollView.contentSize = CGSizeMake(lastestButtonMaxX, self.height);
    if (lastestButtonMaxX < self.width)
    {
        [self useNewLayout];
    }
    self.bottomSelectedLineView.hidden = self.suspendedViewStyle == SuspendedViewStyleDefault;
}

#pragma mark -
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    for (NSInteger i = 0; i < self.verticalLineViews.count; i++) {
        UIView *verticalLineView = self.verticalLineViews[i];
        BillSuspendButton *button = self.itemButtons[i];
        verticalLineView.x = button.maxX;
        verticalLineView.hidden = !(self.suspendedViewStyle == SuspendedViewStyleDefault || self.suspendedViewStyle == SuspendedViewStyleVaule3);
    }
}

#pragma mark - Private methods
- (void)initBottomLineViewWithButton:(BillSuspendButton *)button
{
//    CGFloat lineViewWidth = self.suspendedViewStyle == SuspendedViewStyleVaule1 ? button.width : [self buttonTitleWidth:button];
    CGFloat lineViewWidth = 25;
    CGFloat lineViewOrignalX = self.suspendedViewStyle == SuspendedViewStyleVaule1 ? 0 : (button.width - lineViewWidth) / 2.0;
    self.bottomSelectedLineView.frame = CGRectMake(lineViewOrignalX, self.height - 1, lineViewWidth, 1);
}

- (void)moveBottomLineWithButton:(BillSuspendButton *)button
{
//    CGFloat lineViewWidth = self.suspendedViewStyle == SuspendedViewStyleVaule1 ? button.width : [self buttonTitleWidth:button];
    CGFloat lineViewWidth = 25;
    CGFloat lineViewOrignalX = self.suspendedViewStyle == SuspendedViewStyleVaule1 ? button.x : button.x + (button.width - lineViewWidth) / 2.0;
    self.bottomSelectedLineView.frame = CGRectMake(lineViewOrignalX, self.height - 1, lineViewWidth, 1);
}
- (void)useNewLayout
{
    BillSuspendButton *button = self.itemButtons.lastObject;
    CGFloat restWidth = self.width - button.maxX;
    CGFloat expandedWidth = restWidth / self.itemButtons.count;
    CGFloat lastestButtonMaxX = 0;
    for (NSInteger i = 0; i < self.itemButtons.count; i++) {
        BillSuspendButton *button = self.itemButtons[i];
        button.frame = CGRectMake(lastestButtonMaxX, 0, button.width + expandedWidth, button.height);
        lastestButtonMaxX = button.maxX;
        if (i == 0)
        {
            [self initBottomLineViewWithButton:button];
        }
    }
}

- (CGFloat)buttonTitleWidth:(BillSuspendButton *)button
{
    NSDictionary *attributes = @{NSFontAttributeName:button.defaultStyleFont};
    CGRect rect = [button.titleLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, button.height) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributes context:nil];
    return rect.size.width + 6
    ;
}

#pragma mark - UIButton action method
- (void)clickItemButton:(BillSuspendButton *)button
{
    if (button.tag == self.currentItemIndex) return;
    [UIView animateWithDuration:0.1 animations:^{
        [self moveBottomLineWithButton:button];
    }];
    self.currentItemIndex = button.tag;
    [self.contentScrollView scrollRectToVisible:button.frame animated:YES];
    if ([self.delegate respondsToSelector:@selector(didClickView:atItemIndex:)])
    {
        [self.delegate didClickView:self atItemIndex:button.tag];
    }
}

#pragma mark - Getter
- (UIView *)bottomSelectedLineView
{
    if (!_bottomSelectedLineView)
    {
        _bottomSelectedLineView = [UIView new];
        _bottomSelectedLineView.backgroundColor = BLACK_COLOR;
    }
    return _bottomSelectedLineView;
}

#pragma mark - Setter
- (void)setItems:(NSArray *)items
{
    _items = items;
    [self setupMainView];
}

- (void)setCurrentItemIndex:(NSInteger)currentItemIndex
{
    if (currentItemIndex >= self.items.count)
    {
        currentItemIndex = -1;
    }
    BillSuspendButton *button = self.itemButtons[currentItemIndex];
    [self.contentScrollView scrollRectToVisible:button.frame animated:YES];
    _currentItemIndex = currentItemIndex;
    for (BillSuspendButton *suspendedButton in self.itemButtons) {
        suspendedButton.selected = currentItemIndex == suspendedButton.tag;
        if (suspendedButton.selected)
        {
            [self moveBottomLineWithButton:suspendedButton];
        }
    }
}


@end
