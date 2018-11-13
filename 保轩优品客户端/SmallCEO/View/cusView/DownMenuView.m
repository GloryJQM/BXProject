//
//  DownMenuView.m
//  chufake
//
//  Created by pan on 13-11-15.
//  Copyright (c) 2013年 quanmai. All rights reserved.
//

#import "DownMenuView.h"

#define kMaxHeight 1000
#define kAnimationTime .25

@implementation DownMenuView

- (void)dealloc
{
    [_buttons removeAllObjects];
    [_downMenus removeAllObjects];
    [_images removeAllObjects];
    [_indexs removeAllObjects];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        _selectIndex = -1;
        self.clipsToBounds = NO;
        
        _buttons = [[NSMutableArray alloc] init];
        _downMenus = [[NSMutableArray alloc] init];
        _images = [[NSMutableArray alloc] init];
        _indexs = [[NSMutableArray alloc]init];
        
        _downContentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, kMaxHeight)];
        _downContentView.clipsToBounds = YES;
        _downContentView.backgroundColor = [UIColor clearColor];
        [self addSubview:_downContentView];
        
        
        
        _downTapControl = [[UIControl alloc] initWithFrame:_downContentView.bounds];
        [_downTapControl addTarget:self action:@selector(blackBGTap:) forControlEvents:UIControlEventTouchUpInside];
        _downTapControl.backgroundColor = [UIColor colorWithWhite:0 alpha:.5];
        [_downContentView addSubview:_downTapControl];
        _downTapControl.alpha = 0;
        
    }
    return self;
}


- (void)pullBack
{
    if (_selectIndex >= 0) {
        [self blackBGTap:nil];
    }
}

- (void)changeTitle:(NSString *)title atIndex:(int)index
{
    UIImageView *imageView=[_images objectAtIndex:index];
    float halfW=[title stringWidth]/2.0+15;
    
    float numTitle=_images.count;
    imageView.frame=CGRectMake(imageView.frame.origin.x, imageView.frame.origin.y, self.frame.size.width/numTitle-(self.frame.size.width/numTitle/2.0)+halfW, imageView.frame.size.height);
    
    UIButton *button = [_buttons objectAtIndex:index];
    [button setTitle:title forState:UIControlStateNormal];
}

- (void)setupWithTitles:(NSArray *)titles
{
    for (UIView *v in _buttons) {
        [v removeFromSuperview];
    }
    [_buttons removeAllObjects];
    
    for (UIView *v in _downMenus) {
        [v removeFromSuperview];
    }
    [_downMenus removeAllObjects];
    
    for (UIView *v in _images) {
        [v removeFromSuperview];
    }
    [_images removeAllObjects];
    
    
    const int count = titles.count;
    for (int i= 0; i< titles.count; i++) {

        UIView *downMenuView = [self.delegate downMenuDetailViewatIndex:i];
        downMenuView.frame = CGRectMake(0, -(downMenuView.frame.size.height -self.frame.size.height), downMenuView.frame.size.width, downMenuView.frame.size.height);
        [_downContentView addSubview:downMenuView];
        [_downMenus addObject:downMenuView];
    }
    
    UIView *whiteView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    whiteView.backgroundColor=[UIColor whiteColor];
    [self addSubview:whiteView];
    
    for (int i=0; i< titles.count; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(i *self.frame.size.width/count, 0, self.frame.size.width/count, self.frame.size.height)];
        btn.backgroundColor = [UIColor clearColor];
        [btn addTarget:self action:@selector(downMenuDetail:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:[titles objectAtIndex:i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor midnightBlueColor] forState:UIControlStateNormal];
        [self addSubview:btn];
        [_buttons addObject:btn];
        
        NSString *CString=[titles objectAtIndex:i];
        float halfW=CString.length/2.0*16.0+15;
        UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(i *self.frame.size.width/count, 0, self.frame.size.width/count-(self.frame.size.width/count/2.0)+halfW,  self.frame.size.height)];
        imageV.backgroundColor = [UIColor clearColor];
        imageV.contentMode = UIViewContentModeRight;
        imageV.image = [UIImage imageNamed:@"btn_xia"];
        [self addSubview:imageV];
        [_images addObject:imageV];
    }
}

-(void)disableMenuButtonAtIndex:(NSInteger)index
{
    NSLog(@"images:%@",((UIImageView *)[_images objectAtIndex:index]).image);
    [((UIImageView *)[_images objectAtIndex:index]) removeFromSuperview];
    [_indexs addObject:[NSString stringWithFormat:@"%d",index]];
   // ((UIButton *)[_buttons objectAtIndex:index]).enabled = NO;

}



- (void)blackBGTap:(id)sender
{
    UIButton *selectedButton = [_buttons objectAtIndex:_selectIndex];
    [self downMenuDetail:selectedButton];
}

- (void)downMenuDetail:(UIButton *)button
{
    for (int i=0; i<[_indexs count]; i++) {
        if ([_buttons objectAtIndex:i] == button) {
            return;
        }
    }
    int buttonIndex = [_buttons indexOfObject:button];
    if (_selectIndex >= 0 ) {
        UIButton *preButton = [_buttons objectAtIndex:_selectIndex];
        int tempIndex = _selectIndex;
        preButton.selected = NO;
        
        UIView *nowDownView = [_downMenus objectAtIndex:_selectIndex];
        [UIView animateWithDuration:kAnimationTime animations:^{
           nowDownView.frame = CGRectMake(0, -(nowDownView.frame.size.height -self.frame.size.height), nowDownView.frame.size.width, nowDownView.frame.size.height);
        }completion:^(BOOL finished) {
            if (_selectIndex == tempIndex) {
                _selectIndex = -1;
            }
        }];
        
        if ([self.delegate respondsToSelector:@selector(downMenuDetailViewwillPullIn:downMenuView:)]) {
            [self.delegate downMenuDetailViewwillPullIn:_selectIndex downMenuView:self];
        }
    }
    
    if (_selectIndex != buttonIndex) {
        
        UIView *downView = [_downMenus objectAtIndex:buttonIndex];
        [_downContentView bringSubviewToFront:downView];
        [UIView animateWithDuration:kAnimationTime animations:^{
            _downTapControl.alpha = 1;
            downView.frame = CGRectMake(0, self.frame.size.height, downView.frame.size.width, downView.frame.size.height);
        }completion:^(BOOL finished) {
            if (finished) {
                _selectIndex = buttonIndex;
            }
        }];
        
        if ([self.delegate respondsToSelector:@selector(downMenuDetailViewwillPullOut:downMenuView:)]) {
            [self.delegate downMenuDetailViewwillPullOut:buttonIndex downMenuView:self];
        }
    }else{
        _selectIndex = -1;
        [UIView animateWithDuration:kAnimationTime animations:^{
            _downTapControl.alpha = 0;
        }completion:^(BOOL finished) {
        }];
    }
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    if (_selectIndex >= 0) {
        if (CGRectContainsPoint(_downContentView.frame, point)) {
            return YES;
        }
    }
    
    return [super pointInside:point withEvent:event];
}

- (UIView *)currentContentView
{
    if (_selectIndex > 0) {
        return [_downMenus objectAtIndex:_selectIndex];
    }
    return nil;
}

@end
