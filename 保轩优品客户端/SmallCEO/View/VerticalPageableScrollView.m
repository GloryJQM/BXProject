//
//  VerticalPageableScrollView.m
//  SmallCEO
//
//  Created by quanmai on 15/11/10.
//  Copyright © 2015年 lemuji. All rights reserved.
//

#import "VerticalPageableScrollView.h"

@interface VerticalPageableScrollView ()<UIScrollViewDelegate>{
    UIImageView *backGroundImageView;
    
}

@end

@implementation VerticalPageableScrollView
@synthesize vScrollView;

-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        
        backGroundImageView=[[UIImageView alloc] initWithFrame:self.bounds];
        [self addSubview:backGroundImageView];
        backGroundImageView.backgroundColor=[UIColor clearColor];
        backGroundImageView.layer.cornerRadius=0;
        
        
        vScrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT-51)];
        [self addSubview:vScrollView];
        vScrollView.backgroundColor = [UIColor clearColor];
        vScrollView.alwaysBounceVertical=YES;
        vScrollView.contentSize=CGSizeMake(UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT-51+2);
        vScrollView.delegate=self;
        
        
    }
    return self;
}





@end
