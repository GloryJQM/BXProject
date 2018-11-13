//
//  TextSearchTextField.m
//  Jiang
//
//  Created by huang on 16/12/29.
//  Copyright © 2016年 quanmai. All rights reserved.
//

#import "TextSearchTextField.h"

@interface TextSearchTextField ()

@property (nonatomic, strong) UIView *lineView;

@end

@implementation TextSearchTextField

#pragma mark - Init method
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self p_setupMainView];
    }
    
    return self;
}

#pragma mark - Private
- (void)p_setupMainView
{
    self.font = [UIFont systemFontOfSize:15.0];
    self.placeholder = @"从这里出发";
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor colorFromHexCode:@"ABABAB"] forState:UIControlStateNormal];
    cancelButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
    self.cancelButton = cancelButton;
    self.cancelButton.size = CGSizeMake(60, self.height);
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = [cancelButton titleColorForState:UIControlStateNormal];
    self.lineView = lineView;
    [cancelButton addSubview:lineView];
    self.rightView = cancelButton;
    self.rightViewMode = UITextFieldViewModeAlways;
    
    self.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10.0, self.height)];
    self.leftViewMode = UITextFieldViewModeAlways;
}

#pragma mark -
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.lineView.frame = CGRectMake(0, 8, 1, self.height - 16);
}

@end
