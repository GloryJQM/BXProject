//
//  Custom_TextField.m
//  SmallCEO
//
//  Created by ni on 17/2/25.
//  Copyright © 2017年 lemuji. All rights reserved.
//

#import "Custom_TextField.h"

@implementation Custom_TextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGFloat w = self.frame.size.width;
        CGFloat h = self.frame.size.height;
        
        self.layer.cornerRadius = self.frame.size.height/2;
        [self.layer setBorderColor:LAYER_COLOR.CGColor];
        [self.layer setBorderWidth:1];
        
        
        _textfield = [[UITextField alloc]initWithFrame:CGRectMake(2+h/4, 1, w-h,  h-2)];
        _textfield.backgroundColor = [UIColor clearColor];
        [self addSubview:_textfield];
        
//        _button = [[UIButton alloc]initWithFrame:CGRectMake(w-2-h/2,1,80, h-2)];
//        _button.backgroundColor = [UIColor clearColor];
//        [_button setTitleColor:App_Main_Color forState:UIControlStateNormal];
//        [_button setTitleColor:GRAY_TITLE forState:UIControlStateSelected];
//        _button.contentMode = UIViewContentModeCenter;
//        [self addSubview:_button];
//
//        _label = [[UILabel alloc]initWithFrame:CGRectMake(w-2-h/2,1,80, h-2)];
//        _label.backgroundColor = [UIColor clearColor];
//        _label.contentMode = UIViewContentModeCenter;
//        [self addSubview:_label];
        
        
        
        // Initialization code
    }
    
    
    return self;
}

@end
