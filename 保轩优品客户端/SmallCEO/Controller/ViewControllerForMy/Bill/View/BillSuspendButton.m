//
//  BillSuspendButton.m
//  Jiang
//
//  Created by peterwang on 17/3/2.
//  Copyright © 2017年 quanmai. All rights reserved.
//

#import "BillSuspendButton.h"

@interface BillSuspendButton ()

@property (nonatomic, strong) UIFont *defaultStyleFont;
@property (nonatomic, strong) UIImageView *tipimage;

@end

@implementation BillSuspendButton


+ (instancetype)defaultStyleButtonWithTitle:(NSString *)title
{
    BillSuspendButton *defaultStyleButton = [BillSuspendButton buttonWithType:UIButtonTypeCustom];
    [defaultStyleButton setTitleColor:GRAY_COLOR forState:UIControlStateNormal];
    [defaultStyleButton setTitleColor:BLACK_COLOR
                             forState:UIControlStateSelected];
    [defaultStyleButton setTitle:title forState:UIControlStateNormal];
    [defaultStyleButton setTitle:title forState:UIControlStateSelected];
    defaultStyleButton.defaultStyleFont = [UIFont systemFontOfSize:16.0];
    defaultStyleButton.titleLabel.font = defaultStyleButton.defaultStyleFont;
    
    //    CGSize size = [defaultStyleButton.titleLabel sizeThatFits:CGSizeMake(50, 50)];
    //    defaultStyleButton.size = size;
    
        return defaultStyleButton;
}
+ (instancetype)layoutButtonWithimage:(UIImage *)image Andtitle:(NSString *)title{
    
    BillSuspendButton *defaultStyleButton = [BillSuspendButton buttonWithType:UIButtonTypeCustom];
    [defaultStyleButton setTitleColor:GRAY_COLOR forState:UIControlStateNormal];
    [defaultStyleButton setTitleColor:BLACK_COLOR
                             forState:UIControlStateSelected];
    [defaultStyleButton setTitle:title forState:UIControlStateNormal];
    [defaultStyleButton setTitle:title forState:UIControlStateSelected];
    defaultStyleButton.defaultStyleFont = [UIFont systemFontOfSize:16.0];
    defaultStyleButton.titleLabel.font = defaultStyleButton.defaultStyleFont;
    
    UIImageView *imageviews = [[UIImageView alloc]init];
    imageviews.image = image;
    defaultStyleButton.tipimage = imageviews;
    
    
    
    
    
    return defaultStyleButton;

}
- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.tag != 0) {
        CGFloat imageWith = 18;
        CGFloat imageHeight = 18;
        CGFloat labelWidth = 0.0;
        CGFloat labelHeight = 0.0;
        if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
            // 由于iOS8中titleLabel的size为0，用下面的这种设置
            labelWidth = self.titleLabel.intrinsicContentSize.width;
            labelHeight = self.titleLabel.intrinsicContentSize.height;
        } else {
            labelWidth = self.titleLabel.frame.size.width;
            labelHeight = self.titleLabel.frame.size.height;
        }
        
        UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
        UIEdgeInsets labelEdgeInsets = UIEdgeInsetsZero;
        CGFloat space = 10.0;
        imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth+space/2.0, 0, -labelWidth-space/2.0);
        labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith-space/2.0+30, 0, imageWith+space/2.0);
        NSLog(@"%f  %f   %f   %f",imageEdgeInsets.bottom,imageEdgeInsets.top,imageEdgeInsets.left,imageEdgeInsets.right);
        NSLog(@"%f  %f   %f   %f",labelEdgeInsets.bottom,labelEdgeInsets.top,labelEdgeInsets.left,labelEdgeInsets.right);
        self.titleEdgeInsets = labelEdgeInsets;
        self.imageEdgeInsets = imageEdgeInsets;
        _tipimage.frame = CGRectMake(labelWidth+labelEdgeInsets.right+10, self.centerY-9, imageWith, imageHeight);
        [self addSubview:_tipimage];
    }
    
}

@end
