//
//  BankSelectView.m
//  SmallCEO
//
//  Created by huang on 15/8/26.
//  Copyright (c) 2015年 lemuji. All rights reserved.
//

#import "BankSelectView.h"

@interface BankSelectView ()

@property (nonatomic, strong) UIWindow *overlayWindow;
@property (nonatomic, copy)   NSMutableArray *bankViewsArray;

@end

@implementation BankSelectView

@synthesize overlayWindow;

+ (BankSelectView *)sharedView {
    static dispatch_once_t once;
    static BankSelectView *sharedView;
    dispatch_once(&once, ^ { sharedView = [[BankSelectView alloc] initWithFrame:[[UIScreen mainScreen] bounds]]; });
    return sharedView;
}

- (void)createMainViewWithinfoArray:(NSArray *)infoArray
{
    _bankViewsArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    CGFloat gapDistanceFromEdge = 19.0 * adapterFactor;
    CGFloat heightForSingleBankView = 44.0 * adapterFactor;
    CGFloat widthForSingleBankView = 128.0 * adapterFactor;
    CGFloat heightForLabelOrImageView = 20.0 * adapterFactor;
    CGFloat heightForTopView = 76.0;
    CGFloat horizontalDistanceBetweenTwoBankView = 28.5 * adapterFactor;
    CGFloat verticalDistanceBetweenTwoBankView = 13.0 * adapterFactor;
    
    NSInteger rowsOfBankLabel = infoArray.count / 2 + 1;
    CGFloat heightForMainView = heightForTopView + (verticalDistanceBetweenTwoBankView + heightForSingleBankView) * rowsOfBankLabel + 50;
    UIView *mainView = [[UIView alloc] initWithFrame:CGRectMake(0, UI_SCREEN_HEIGHT - heightForMainView, UI_SCREEN_WIDTH, heightForMainView)];
    mainView.backgroundColor = BACK_COLOR;
    [[BankSelectView sharedView].overlayWindow addSubview:mainView];
    
    UIView *maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT - heightForMainView)];
    [maskView addTarget:self action:@selector(hideBankSelectView) forControlEvents:UIControlEventTouchUpInside];
    [[BankSelectView sharedView].overlayWindow addSubview:maskView];
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 44)];
    [topView addTarget:self action:@selector(hideBankSelectView) forControlEvents:UIControlEventTouchUpInside];
    [mainView addSubview:topView];
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [cancelButton setImage:[UIImage imageNamed:@"gj_cancel_xx.png"] forState:UIControlStateNormal];
    cancelButton.frame = CGRectMake((UI_SCREEN_WIDTH - 22) / 2, 11, 22, 22);
    [topView addSubview:cancelButton];
    cancelButton.userInteractionEnabled = NO;
    
    UIButton *selectButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [selectButton setTitle:@"选择银行" forState:UIControlStateNormal];
    [selectButton setTitleColor:App_Main_Color forState:UIControlStateNormal];
    CGSize sizeForSelectButton = [selectButton.titleLabel sizeThatFits:CGSizeMake(UI_SCREEN_WIDTH, 16)];
    selectButton.frame = CGRectMake(gapDistanceFromEdge, 44, sizeForSelectButton.width, 16);
    selectButton.userInteractionEnabled = NO;
    [mainView addSubview:selectButton];
    
    for (int i = 0; i < infoArray.count; i++) {
        UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(gapDistanceFromEdge + (i % 2) * (widthForSingleBankView + horizontalDistanceBetweenTwoBankView), i / 2 * (verticalDistanceBetweenTwoBankView + heightForSingleBankView) + heightForTopView, widthForSingleBankView, heightForSingleBankView)];
        backgroundView.layer.borderWidth = 1;
        backgroundView.layer.borderColor = [LINE_COLOR CGColor];
        backgroundView.tag = i;
        [backgroundView addTarget:self action:@selector(bankViewClick:) forControlEvents:UIControlEventTouchUpInside];
        [mainView addSubview:backgroundView];
        [_bankViewsArray addObject:backgroundView];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(14.0 * adapterFactor, (heightForSingleBankView - heightForLabelOrImageView) / 2, heightForLabelOrImageView, heightForLabelOrImageView)];
        [imageView af_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", [[infoArray objectAtIndex:i] objectForKey:@"picurl"]]]];
        [backgroundView addSubview:imageView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10.0 + CGRectGetMaxX(imageView.frame), CGRectGetMinY(imageView.frame), 0, heightForLabelOrImageView)];
        label.text = [NSString stringWithFormat:@"%@", [[infoArray objectAtIndex:i] objectForKey:@"name"]];
        CGSize sizeForLabel = [label sizeThatFits:CGSizeMake(UI_SCREEN_WIDTH, CGRectGetHeight(backgroundView.frame) - 10)];
        CGRect frameForLabel = label.frame;
        frameForLabel.size.width = sizeForLabel.width;
        label.frame = frameForLabel;
        [backgroundView addSubview:label];
    }
}

#pragma mark - Getter
- (UIWindow *)overlayWindow {
    if(!overlayWindow) {
        overlayWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        overlayWindow.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        overlayWindow.backgroundColor = [UIColor clearColor];
        overlayWindow.windowLevel = UIWindowLevelNormal + 1;
        overlayWindow.userInteractionEnabled = YES;
    }
    return overlayWindow;
}


#pragma mark - 
+ (void)setBankInfoArray:(NSArray *)infoArray
{
    [[BankSelectView sharedView] createMainViewWithinfoArray:infoArray];
}

#pragma mark - 按钮点击方法
- (void)bankViewClick:(UIView *)clickedView
{
    [self hideSelectView];
    
    if ([self.delegate respondsToSelector:@selector(bankSelectView:didSelectAtIndex:)])
    {
        [self.delegate bankSelectView:self didSelectAtIndex:clickedView.tag];
    }
}

- (void)hideBankSelectView
{
    [self hideSelectView];
}

#pragma mark - 显示或隐藏的方法
+ (void)show
{
    [[BankSelectView sharedView] showSelectView];
}

+ (void)dismiss
{
    [[BankSelectView sharedView] hideSelectView];
}

- (void)showSelectView
{
    self.alpha = 0.7;
    self.backgroundColor = [UIColor grayColor];
    if(!self.superview)
        [self.overlayWindow insertSubview:self atIndex:0];
    
    
    [self.overlayWindow makeKeyAndVisible];
}

- (void)hideSelectView
{
    // Make sure to remove the overlay window from the list of windows
    // before trying to find the key window in that same list
    NSMutableArray *windows = [[NSMutableArray alloc] initWithArray:[UIApplication sharedApplication].windows];
    [windows removeObject:overlayWindow];
    [overlayWindow.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    overlayWindow = nil;
    
    [windows enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(UIWindow *window, NSUInteger idx, BOOL *stop) {
        if([window isKindOfClass:[UIWindow class]] && window.windowLevel == UIWindowLevelNormal) {
            [window makeKeyWindow];
            *stop = YES;
        }
    }];
}

@end
