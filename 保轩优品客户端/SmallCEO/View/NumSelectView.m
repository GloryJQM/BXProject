//
//  NumSelectView.m
//  Lemuji
//
//  Created by quanmai on 15/7/16.
//  Copyright (c) 2015年 quanmai. All rights reserved.
//

#import "NumSelectView.h"


@interface NumSelectView (){
    UILabel *lable;
    UIButton *btn;
}

@end

@implementation NumSelectView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=NAVI_COLOR;
        self.layer.cornerRadius=4;
        self.frame=CGRectMake(frame.origin.x, frame.origin.y, 47, 24);
        lable=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 47/2.0, 24)];
        lable.textColor=BLACK_COLOR;
        lable.font=[UIFont systemFontOfSize:13];
        lable.text=@"";
        lable.backgroundColor=[UIColor clearColor];
        lable.textAlignment=NSTextAlignmentRight;
        [self addSubview:lable];
        
        
        UIImageView *imageV=[[UIImageView alloc] initWithFrame:CGRectMake(47/2.0+5, 0, 47/2.0-10, 24)];
        imageV.backgroundColor=[UIColor clearColor];
        imageV.layer.cornerRadius=0;
        imageV.contentMode=UIViewContentModeLeft;
        imageV.image=[UIImage imageNamed:@"csl_arrow_down"];
        [self addSubview:imageV];
        
        btn=[[UIButton alloc] initWithFrame:self.bounds];
        btn.backgroundColor=[UIColor clearColor];
        [self addSubview:btn];
    }
    return self;
}


-(void)setText:(NSString *)num{
    lable.text=num;
}


-(void)addMyTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents tag:(NSInteger)tag{
    btn.tag=tag;
    [btn addTarget:target action:action forControlEvents:controlEvents];
}

@end
