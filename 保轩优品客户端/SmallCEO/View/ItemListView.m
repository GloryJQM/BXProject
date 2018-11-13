//
//  ItemListView.m
//  WanHao
//
//  Created by wuxiaohui on 14-2-11.
//  Copyright (c) 2014年 wuxiaohui. All rights reserved.
//

#import "ItemListView.h"

@implementation ItemListView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.delegate = self;
        [self addSubview:_scrollView];
        [self reladListView];
        
        // Initialization code
    }
    return self;
}

-(void)reladListView{
    int count = [self.delegate numberOfRowsInItemListView:self];
    CGFloat width = 5.0;
    for (int i = 0; i<count; i++) {
        UIView *view = [self.delegate ItemListView:self viewOfRows:i];
        view.frame = CGRectMake(width, 0,[self.delegate ItemListView:self widthOfRows:i] , self.frame.size.height);
        width += [self.delegate ItemListView:self widthOfRows:i]+10;
        view.tag = i;
        [_scrollView addSubview:view];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        tap.numberOfTapsRequired = 1;
        [view addGestureRecognizer:tap];
       
    }
    _scrollView.contentSize = CGSizeMake(width, 0);

}


-(void)tap:(UIGestureRecognizer *)tap{
    [self.delegate ItemListView:self didSelectRowAtIndex:tap.view.tag];
}


@end
