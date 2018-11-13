//
//  ScreenView.m
//  SmallCEO
//
//  Created by 任成龙 on 2017/6/6.
//  Copyright © 2017年 lemuji. All rights reserved.
//

#import "ScreenView.h"

@interface ScreenView() {
    UIButton *_button;
}
@end
@implementation ScreenView
- (instancetype)initWithY:(CGFloat)y titleArray:(NSArray *)array block:(void (^) (NSString *string))block {
    self = [super initWithFrame:CGRectMake(0, y, UI_SCREEN_WIDTH, 44)];
    if (self) {
        self.finishBlock = block;
        self.backgroundColor = [UIColor whiteColor];
        [self creationView:array];
    }
    return self;
}

- (void)creationView:(NSArray *)titleAry {
    CGFloat x = 0;
    CGFloat width = UI_SCREEN_WIDTH / titleAry.count;
    for (int i = 0; i < titleAry.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(x, 0, width, self.height);
        
        [button setTitle:[NSString stringWithFormat:@"%@ ", titleAry[i]] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button setTitleColor:[UIColor colorFromHexCode:@"#202023"] forState:UIControlStateNormal];
        if ([titleAry[i] isEqualToString:@"价格排序"]) {
            [button setImage:[UIImage imageNamed:@"全灰色@2x"] forState:UIControlStateNormal];
            [button setTitleEdgeInsets:UIEdgeInsetsMake(0, -button.imageView.bounds.size.width, 0, button.imageView.bounds.size.width)];
            [button setImageEdgeInsets:UIEdgeInsetsMake(0, button.titleLabel.bounds.size.width, 0, -button.titleLabel.bounds.size.width)];
        }
        
        [self addSubview:button];
        [button addTarget:self action:@selector(handleButton:) forControlEvents:UIControlEventTouchUpInside];


        x = button.maxX;
    }
    
    [self addLineWithY:self.height - 0.5];
}

- (void)handleButton:(UIButton *)sender {
    
    [_button setTitleColor:[UIColor colorFromHexCode:@"#202023"] forState:UIControlStateNormal];
    _button.titleLabel.font = [UIFont systemFontOfSize:15];
    
    [sender setTitleColor:App_Main_Color forState:UIControlStateNormal];
    sender.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    
    if ([[sender currentTitle] containsString:@"销量优先"] && [[_button currentTitle] containsString:@"价格排序"]) {
        if (_button.selected) {
          [_button setImage:[UIImage imageNamed:@"全灰色"] forState:UIControlStateSelected];
        }else {
          [_button setImage:[UIImage imageNamed:@"全灰色"] forState:UIControlStateNormal];
        }
        
    }
    
    _button = sender;
    
    if ([[sender currentTitle] containsString:@"价格排序"]) {
        sender.selected = !sender.selected;
        NSString *title;
        if (sender.selected) {
            title = @"价格最低";
            [_button setImage:[UIImage imageNamed:@"上灰色"] forState:UIControlStateSelected];
        }else {
            title = @"价格最高";
            [_button setImage:[UIImage imageNamed:@"下回色"] forState:UIControlStateNormal];
            
        }
        if (self.finishBlock) {
            self.finishBlock(title);
        }
    }else {
        if (self.finishBlock) {
            self.finishBlock([sender currentTitle]);
        }
    }
    
    
}
@end
