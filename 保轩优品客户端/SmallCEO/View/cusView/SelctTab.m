//
//  SelctTab.m
//  chufake
//
//  Created by wuxiaohui on 13-12-31.
//  Copyright (c) 2013年 quanmai. All rights reserved.
//

#import "SelctTab.h"

@implementation SelctTab

-(void)dealloc{
    [_labelArray removeAllObjects];
    
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _labelArray = [[NSMutableArray alloc] init];
        // Initialization code
    }
    return self;
}
-(void)setTopTapSelectBlock:(topTapBlock)block{
    _block = block;
}

-(void)btnSelectIndexInSelctTab:(NSInteger)index{
    _oldbtn.selected = NO;
    NSLog(@"index;%d",index);
    UIButton *btn = (UIButton *)[_labelArray objectAtIndex:index];
    btn.selected = YES;
    _oldbtn = btn;

}
-(void)btnDown:(UIButton*)btn{
    if (_oldbtn == btn) {
        return;
    }
    btn.selected = YES;
    _oldbtn.selected = NO;
    NSInteger tag = btn.tag;
    if (_block) {
        _oldbtn = btn;
        _block(tag,[_titleArray objectAtIndex:tag]);
    }
}
-(void)setTitleArray:(NSArray *)titleArray{
    _titleArray = [titleArray copy];
    float width = self.frame.size.width/_titleArray.count;
    
    for (int i=0; i<[_titleArray count];i++) {
        
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(i*width, 0,self.frame.size.width/_titleArray.count,self.frame.size.height)];
        [btn setTitleColor:[UIColor colorFromHexCode:@"#7C7C7C"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorFromHexCode:@"#000000"] forState:UIControlStateSelected];      //FC6854
        [btn setTitle:[_titleArray objectAtIndex:i] forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor clearColor];
        btn.userInteractionEnabled = YES;
        btn.tag = i;
        [btn addTarget:self action:@selector(btnDown:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        [_labelArray addObject:btn];
        if (i==0) {
            btn.selected = YES;
            _oldbtn = btn;
        }
    }
  
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(context, kCGLineCapSquare);
    CGContextSetLineWidth(context, 1.0);
    CGContextSetStrokeColorWithColor(context, [UIColor silverColor].CGColor);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context,0, self.frame.size.height);
    CGContextAddLineToPoint(context, self.frame.size.width, self.frame.size.height);
    CGContextStrokePath(context);
    
    float width = self.frame.size.width/_titleArray.count;
    for (int i=0; i<[_titleArray count]-1; i++) {
        CGContextBeginPath(context);
        CGContextMoveToPoint(context, width*(i+1), 0);
        CGContextAddLineToPoint(context, width*(i+1), self.frame.size.height);
        CGContextStrokePath(context);
    }
 
}


@end
