//
//  TipButton.m
//  HuaQi
//
//  Created by 黄建芳 on 8/4/16.
//  Copyright © 2016 lemuji. All rights reserved.
//

#import "TipButton.h"

@interface TipButton ()

@property (nonatomic, strong) UIImageView *cancelImageView;

@end

@implementation TipButton

+ (instancetype)defaultStyleTipButtonWithTitle:(NSString *)title
{
    TipButton *defaultStyleButton = [TipButton buttonWithType:UIButtonTypeCustom];
    [defaultStyleButton setTitleColor:[UIColor colorFromHexCode:@"616161"] forState:UIControlStateNormal];
    [defaultStyleButton setTitle:title forState:UIControlStateNormal];
    defaultStyleButton.backgroundColor = [UIColor colorFromHexCode:@"#ebebeb"];
    
    [defaultStyleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [defaultStyleButton setTitle:title forState:UIControlStateSelected];
    defaultStyleButton.layer.cornerRadius = 3;
    defaultStyleButton.titleLabel.font = [UIFont systemFontOfSize:12.0];
    CGSize size = [defaultStyleButton.titleLabel sizeThatFits:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
    CGSize newSize = CGSizeMake(size.width + 20, size.height + 12);
    defaultStyleButton.size = newSize;
    
    return defaultStyleButton;
}

+ (instancetype)cancelableTipButtonWithTitle:(NSString *)title
{
    TipButton *cancelableTipButton = [TipButton buttonWithType:UIButtonTypeCustom];
    [cancelableTipButton initCancelableStyleWithTitle:title];

    CGFloat imageViewHeightOrWidth = 18.0;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(cancelableTipButton.width - imageViewHeightOrWidth - 5, (cancelableTipButton.height - imageViewHeightOrWidth) / 2.0, imageViewHeightOrWidth, imageViewHeightOrWidth)];
    imageView.image = [UIImage imageNamed:@"gj_error.png"];
    [cancelableTipButton addSubview:imageView];
    cancelableTipButton.cancelImageView = imageView;
    
    return cancelableTipButton;
}

+ (CGFloat)cancelableTipButtonWidthWithTitle:(NSString *)title
{
    TipButton *tipButton = [self cancelableTipButtonWithTitle:title];
    return tipButton.width;
}

#pragma mark -
- (void)setHighlighted:(BOOL)highlighted
{
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    self.backgroundColor = selected ? App_Main_Color : MONEY_COLOR;
}

#pragma mark - Setter

- (void)setCancelableTipText:(NSString *)cancelableTipText
{
    _cancelableTipText = cancelableTipText;
    [self initCancelableStyleWithTitle:cancelableTipText];
    self.cancelImageView.frame = CGRectMake(self.width - self.cancelImageView.width - 5, (self.height - self.cancelImageView.width) / 2.0, self.cancelImageView.width, self.cancelImageView.width);
}

#pragma mark - Private methods
- (void)initCancelableStyleWithTitle:(NSString *)title
{
    [self setTitleColor:[UIColor colorFromHexCode:@"A5A5A5"] forState:UIControlStateNormal];
    [self setTitle:title forState:UIControlStateNormal];
    self.backgroundColor = [UIColor colorFromHexCode:@"F3F3F3"];
    self.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    self.layer.cornerRadius = 8.0;
    self.titleLabel.font = [UIFont systemFontOfSize:16.0];
    CGSize size = [self.titleLabel sizeThatFits:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
    CGSize newSize = CGSizeMake(size.width + 35, size.height + 8);
    self.size = newSize;
}

@end
