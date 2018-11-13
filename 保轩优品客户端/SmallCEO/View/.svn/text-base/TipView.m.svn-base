//
//  TipView.m
//  CslProject
//
//  Created by chensanli on 15/3/20.
//  Copyright (c) 2015年 chenweidong. All rights reserved.
//

#import "TipView.h"

@implementation TipView
@synthesize imageV;
@synthesize delegate;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        
        originFrameHeight=frame.size.height;
        openKeybool=YES;
        num=0;
        
        bgView=[[UIView alloc] initWithFrame:CGRectMake(4, 0, frame.size.width-8, frame.size.height)];
        bgView.backgroundColor=[UIColor colorFromHexCode:@"#fefefe"];
        [self addSubview:bgView];
        
        scrollV=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        scrollV.delegate=self;
        scrollV.backgroundColor=[UIColor clearColor];
        [self addSubview:scrollV];
        scrollV.scrollEnabled=NO;
        
        
        
        
        imageV=[[UIImageView alloc] initWithFrame:CGRectMake(10, (frame.size.height-17.5)/2.0, 20, 17.5)];
//        imageV.contentMode=UIViewContentModeScaleAspectFit;
        imageV.backgroundColor=[UIColor clearColor];
        [self addSubview:imageV];
        
        
        UIButton *temp=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, scrollV.frame.size.width, scrollV.frame.size.height)];
        temp .backgroundColor=[UIColor clearColor];
        [temp addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:temp];
        
//        [self initUIWithArr:originArr];
        
//        scrollV.contentSize=CGSizeMake(frame.size.width, frame.size.height*originArr.count);
        
    }
    return self;
}


//-(id)initWithFrame:(CGRect)frame  scrollArr:(NSArray *)arr{
//    self=[super initWithFrame:frame];
//    if (self) {
//        originArr=[NSArray arrayWithArray:arr];
//        
//        originFrameHeight=frame.size.height;
//        openKeybool=YES;
//        num=0;
//        scrollV=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
//        scrollV.delegate=self;
//        scrollV.backgroundColor=[UIColor clearColor];
//        [self addSubview:scrollV];
//        scrollV.scrollEnabled=NO;
//        
//        imageV=[[UIImageView alloc] initWithFrame:CGRectMake(10, (frame.size.height-17.5)/2.0, 20, 17.5)];
//        imageV.backgroundColor=[UIColor clearColor];
//        [self addSubview:imageV];
//        
//        
//        [self updateUIWithArr:originArr];
//        
//        scrollV.contentSize=CGSizeMake(frame.size.width, frame.size.height*originArr.count);
//        
//        UIButton *temp=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, scrollV.frame.size.width, scrollV.frame.size.height)];
//        temp .backgroundColor=[UIColor clearColor];
//        [temp addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:temp];
//        
//        
//    }
//    return self;
//}


-(void)updateUIWithDic:(NSDictionary *)dict{
    
    
    NSDictionary *tempDic=[NSDictionary dictionaryWithDictionary:dict];
     NSArray *arr=(NSArray *)[tempDic valueForKey:@"notice"];
    num=0;
    [scrollV setContentOffset:CGPointMake(0, 0) animated:NO];
    dicArr=[NSArray arrayWithArray:arr];
    
    NSMutableArray *mArr=[[NSMutableArray alloc] initWithCapacity:0];
    for (int i=0; i<dicArr.count; i++) {
        NSDictionary *tempDic=(NSDictionary *)[dicArr objectAtIndex:i];
        NSString *titleString=(NSString *)[tempDic valueForKey:@"subject"];
        [mArr addObject:titleString];
    }
    
    originArr=[NSArray arrayWithArray:mArr];
//    originArr=@[@"ttt",@"sadfasf"];
    for (UIView *view in scrollV.subviews) {
        [view removeFromSuperview];
    }
    
    
    float x =[[tempDic valueForKey:@"x"] floatValue];
    float width =[[tempDic valueForKey:@"width"] floatValue];
    float height =[[tempDic valueForKey:@"height"] floatValue];
    float font_size =[[tempDic valueForKey:@"font_size"] floatValue];
    NSString  *font_color =[tempDic valueForKey:@"font_color"];
    NSString  *bg_color =[tempDic valueForKey:@"bg_color"];
    
    bgView.backgroundColor=[UIColor colorFromHexCode:bg_color];
    imageV.frame=CGRectMake(x, (originFrameHeight-height)/2.0, width, height);
    float labelx=CGRectGetMaxX(imageV.frame)+10;
    
    for (int i=0; i<originArr.count; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(labelx, originFrameHeight*i, UI_SCREEN_WIDTH-labelx-20, originFrameHeight)];
        label.textColor = [UIColor colorFromHexCode:font_color];
        label.font = [UIFont systemFontOfSize:font_size];
        label.backgroundColor = [UIColor clearColor];
        label.text=[originArr objectAtIndex:i];
        [scrollV addSubview:label];
    }
    
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(labelx, originFrameHeight*originArr.count, UI_SCREEN_WIDTH-labelx-20, originFrameHeight)];
    label1.textColor = [UIColor blackColor];
    label1.font = [UIFont systemFontOfSize:14];
    label1.backgroundColor = [UIColor clearColor];
    label1.text=[originArr objectAtIndex:0];
    [scrollV addSubview:label1];
    
//    UIView *superView=[self superview];
//    if (superView!=nil) {
//        [self performSelector:@selector(scrollTip) withObject:nil afterDelay:2];
//    }
        if (scrollTimer) {
            [scrollTimer invalidate];
            scrollTimer = nil;
        }
        scrollTimer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(scrollTip) userInfo:nil repeats:YES];

    
//    [self scrollTip];
}


-(void)buttonClick:(UIButton *)button{
    int index=num%originArr.count;
//    if ([delegate respondsToSelector:@selector(TipViewBtnTag:)]) {
//        [delegate TipViewBtnTag:index];
//    }
    if ([delegate respondsToSelector:@selector(gotoGoodsList:linkvale:title:)]) {
        NSString *linktype=[[dicArr objectAtIndex:index] valueForKey:@"link_type"];
        NSString *link_value=[[dicArr objectAtIndex:index] valueForKey:@"link_value"];
        [delegate gotoGoodsList:[linktype intValue] linkvale:link_value title:@""];
    }
}

//-(void)didMoveToSuperview{
////    NSLog(@"didMoveToSuperview");
//    [self performSelector:@selector(scrollTip) withObject:nil afterDelay:2];
//}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
//     NSLog(@"scrollViewDidEndScrollingAnimation");
//    if (self) {
//        
//        [self performSelector:@selector(scrollTip) withObject:nil afterDelay:2];
//        
//    }
    
}


-(void)setAnimationEnable:(BOOL)value{
    openKeybool=value;
}


-(void)scrollTip{
    if (!openKeybool) {
        return;
    }
    if(num==originArr.count){
        num=0;
        [scrollV setContentOffset:CGPointMake(0, 0) animated:NO];
    }
    num++;
//    [UIView animateWithDuration:0.3 animations:^{
//        scrollV.contentOffset=CGPointMake(0, originFrameHeight*(float)num);
//    }];
    
    [scrollV setContentOffset:CGPointMake(0, originFrameHeight*(float)num) animated:YES];
    
    NSLog(@"");
}


@end
