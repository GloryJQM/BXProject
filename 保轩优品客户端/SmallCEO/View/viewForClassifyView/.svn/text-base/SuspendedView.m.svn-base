//
//  SuspendedView.m
//  HuaQi
//
//  Created by 黄建芳 on 7/22/16.
//  Copyright © 2016 lemuji. All rights reserved.
//

#import "SuspendedView.h"

const CGFloat SuspendedViewHeight = 40.0;

@interface SuspendedButton : UIButton

+ (instancetype)defaultStyleButtonWithTitle:(NSString *)title;

@property (nonatomic, strong) UIFont *defaultStyleFont;

@end

@implementation SuspendedButton

+ (instancetype)defaultStyleButtonWithTitle:(NSString *)title {
    SuspendedButton *defaultStyleButton = [SuspendedButton buttonWithType:UIButtonTypeCustom];
    [defaultStyleButton setTitleColor:GRAY_COLOR forState:UIControlStateNormal];
    [defaultStyleButton setTitleColor:App_Main_Color forState:UIControlStateSelected];
    [defaultStyleButton setTitle:title forState:UIControlStateNormal];
    [defaultStyleButton setTitle:title forState:UIControlStateSelected];
    defaultStyleButton.defaultStyleFont = [UIFont systemFontOfSize:14.0];
    defaultStyleButton.titleLabel.font = defaultStyleButton.defaultStyleFont;
    
    CGSize size = [defaultStyleButton.titleLabel sizeThatFits:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
    defaultStyleButton.size = size;
    
    return defaultStyleButton;
}

- (void)setHighlighted:(BOOL)highlighted
{
    
}

@end

@interface SuspendedView ()

@property (nonatomic, strong) UIScrollView *contentScrollView;

@property (nonatomic, strong) NSMutableArray *itemButtons;
@property (nonatomic, strong) NSMutableArray *verticalLineViews;
@property (nonatomic, strong) UIFont *defaultFont;
@property (nonatomic, assign) SuspendedViewStyle suspendedViewStyle;

@property (nonatomic, assign) NSInteger showItemsCount;

@end

@implementation SuspendedView

- (instancetype)initWithSuspendedViewStyle:(SuspendedViewStyle)style
{
    if (self = [super init])
    {
        self.showItemsCount = -1;
        self.defaultFont = [UIFont systemFontOfSize:12.0];
        self.suspendedViewStyle = style;
    }
    
    return self;
}

#pragma mark - Setup Method
- (void)setupMainView {
    self.itemButtons = [NSMutableArray new];
    self.verticalLineViews = [NSMutableArray new];
    UIScrollView *contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    contentScrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:contentScrollView];
    self.contentScrollView = contentScrollView;
    CGFloat lastestButtonMaxX = 0;
    for (NSInteger i = 0; i < self.items.count; i++) {
        SuspendedButton *button = [SuspendedButton defaultStyleButtonWithTitle:self.items[i]];
        button.tag = i;
        button.frame = CGRectMake(lastestButtonMaxX, 0, button.width + 30, self.height);
        lastestButtonMaxX = button.maxX;
        [button addTarget:self action:@selector(clickItemButton:) forControlEvents:UIControlEventTouchUpInside];
        [contentScrollView addSubview:button];
        [self.itemButtons addObject:button];
        
        button.selected = i == 0;
        if (i == 0) {
            [self initBottomLineViewWithButton:button];
            [contentScrollView addSubview:self.bottomSelectedLineView];
        }else {
//            UIView *verticalLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 14, 1, 15)];
//            verticalLineView.backgroundColor = [UIColor colorFromHexCode:@"#e6e6e6"];
//            [contentScrollView addSubview:verticalLineView];
//            [self.verticalLineViews addObject:verticalLineView];
        }
        
        if (lastestButtonMaxX > self.width && self.showItemsCount <= 0){
            SuspendedButton *button = (SuspendedButton *)self.itemButtons[0];
            self.showItemsCount = lastestButtonMaxX/(button.width);
        }
    }
    
    contentScrollView.contentSize = CGSizeMake(lastestButtonMaxX, self.height);
    if (lastestButtonMaxX < self.width) {
        [self useNewLayout];
        self.showItemsCount = 0;
    }
    self.bottomSelectedLineView.hidden = self.suspendedViewStyle == SuspendedViewStyleDefault;
}

#pragma mark - 
- (void)layoutSubviews {
    [super layoutSubviews];
    for (NSInteger i = 0; i < self.verticalLineViews.count; i++) {
        UIView *verticalLineView = self.verticalLineViews[i];
        SuspendedButton *button = self.itemButtons[i];
        verticalLineView.x = button.maxX;
        verticalLineView.hidden = !(self.suspendedViewStyle == SuspendedViewStyleDefault || self.suspendedViewStyle == SuspendedViewStyleVaule3);
    }
}

#pragma mark - Private methods
- (void)initBottomLineViewWithButton:(SuspendedButton *)button {
    [self moveBottomLineWithButton:button];
}

- (void)moveBottomLineWithButton:(SuspendedButton *)button {
    CGFloat lineViewWidth = 0;
    NSInteger index = [button currentTitle].length;
    if (index == 4) {
        lineViewWidth = 53;
    }else {
        lineViewWidth = 25;
    }
    
    CGFloat lineViewOrignalX = self.suspendedViewStyle == SuspendedViewStyleVaule1 ? button.x : button.x + (button.width - lineViewWidth) / 2.0;
    self.bottomSelectedLineView.frame = CGRectMake(lineViewOrignalX, self.height - 2, lineViewWidth, 2);
}

- (void)useNewLayout {
    SuspendedButton *button = self.itemButtons.lastObject;
    CGFloat restWidth = self.width - button.maxX;
    CGFloat expandedWidth = restWidth / self.itemButtons.count;
    CGFloat lastestButtonMaxX = 0;
    for (NSInteger i = 0; i < self.itemButtons.count; i++) {
        SuspendedButton *button = self.itemButtons[i];
        button.frame = CGRectMake(lastestButtonMaxX, 0, button.width + expandedWidth, button.height);
        lastestButtonMaxX = button.maxX;
        if (i == 0)
        {
            [self initBottomLineViewWithButton:button];
        }
    }
}

- (CGFloat)buttonTitleWidth:(SuspendedButton *)button {
    NSDictionary *attributes = @{NSFontAttributeName:button.defaultStyleFont};
    CGRect rect = [button.titleLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, button.height) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributes context:nil];
    
    return rect.size.width + 6;
}

#pragma mark - UIButton action method
- (void)clickItemButton:(SuspendedButton *)button {
    if (button.tag == self.currentItemIndex) return;
    
    
    [UIView animateWithDuration:0.1 animations:^{
        [self moveBottomLineWithButton:button];
    }];
    
    self.currentItemIndex = button.tag;
    
    [self contentScrollViewSetContentOffset:button];

    [self.contentScrollView scrollRectToVisible:button.frame animated:YES];
    
    if ([self.delegate respondsToSelector:@selector(didClickView:atItemIndex:)])
    {
        [self.delegate didClickView:self atItemIndex:button.tag];
    }
}
// 子视图contentScrollView偏移设置
- (void)contentScrollViewSetContentOffset:(SuspendedButton*)button {
    if (self.showItemsCount > 0) {
        SuspendedButton *btn = (SuspendedButton *)self.itemButtons[0];
        CGFloat moveWidth = btn.width;
        CGFloat topTabOffsetX = 0;
        NSInteger boundaryCount = self.showItemsCount/2;
        CGFloat maxOffsetX = self.contentScrollView.contentSize.width-self.width;
        if (button.tag >= boundaryCount) {
            if (button.tag < self.itemButtons.count - boundaryCount) {
                if (self.showItemsCount%2==0) {
                    topTabOffsetX = ((button.tag+1 - boundaryCount) * moveWidth)>maxOffsetX ? maxOffsetX : ((button.tag+1 - boundaryCount) * moveWidth) ;
                }else
                {
                    topTabOffsetX = ((button.tag - boundaryCount) * moveWidth)>maxOffsetX ? maxOffsetX : ((button.tag - boundaryCount) * moveWidth);
                }
            }else {
                topTabOffsetX = self.contentScrollView.contentSize.width-self.width;
            }
        }else {
            topTabOffsetX = 0 * moveWidth;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.contentScrollView setContentOffset:CGPointMake(topTabOffsetX, 0) animated:YES];
        });
    }
}
#pragma mark - Getter
- (UIView *)bottomSelectedLineView {
    if (!_bottomSelectedLineView) {
        _bottomSelectedLineView = [UIView new];
        _bottomSelectedLineView.backgroundColor = App_Main_Color;
    }
    return _bottomSelectedLineView;
}

#pragma mark - Setter
- (void)setItems:(NSArray *)items {
    for (UIView *view in [self.contentScrollView subviews]) {
        [view removeFromSuperview];
    }
    _items = items;
    [self setupMainView];
}

- (void)setCurrentItemIndex:(NSInteger)currentItemIndex {
    if (currentItemIndex >= self.items.count) {
        currentItemIndex = -1;
    }
    
    SuspendedButton *button = self.itemButtons[currentItemIndex];
    _currentItemIndex = currentItemIndex;
    
    [self contentScrollViewSetContentOffset:button];
    
    [self.contentScrollView scrollRectToVisible:button.frame animated:YES];
    for (SuspendedButton *suspendedButton in self.itemButtons) {
        suspendedButton.selected = currentItemIndex == suspendedButton.tag;
        if (suspendedButton.selected)
        {
            [self moveBottomLineWithButton:suspendedButton];
        }
    }
}

@end
