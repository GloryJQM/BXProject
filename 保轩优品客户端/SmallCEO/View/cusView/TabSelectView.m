//
//  TabSelectView.m
//  Lemuji
//
//  Created by quanmai on 15/7/15.
//  Copyright (c) 2015年 quanmai. All rights reserved.
//

#import "TabSelectView.h"


@interface TabSelectView (){
    UIScrollView *hSv;
    UIButton *_button;
}

@end

@implementation TabSelectView

- (instancetype)initWithFrame:(CGRect)frame isBlack:(BOOL)isBlack kinds:(int)kind
{
    self = [super initWithFrame:frame];
    if (self) {
        isBlackMode = isBlack;
        [self setMode];
        CGFloat hSV_Hight;
        if (kind == 0) {
            hSV_Hight = self.frame.size.height;
        }else if (kind == 1){
            hSV_Hight = 83;
        }else {
            hSV_Hight = 42;
        }
        self.frame=CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, hSV_Hight);
        
        //下阴影线
        UILabel *lable1=[[UILabel alloc] initWithFrame:CGRectMake(0, hSV_Hight-1, frame.size.width, 1)];
        lable1.backgroundColor=LINE_SHALLOW_COLOR;
        [self addSubview:lable1];
        
        hSv=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, hSV_Hight-1)];
        hSv.scrollEnabled=YES;
        hSv.showsHorizontalScrollIndicator = NO;
        hSv.showsVerticalScrollIndicator = NO;
        [self addSubview:hSv];
        
    }
    return self;
}

-(void)setMode{
    if (isBlackMode) {
        selectColor=Pitchup_Color;
//        selectColor=Main_Color;
        noSelectColor = [UIColor colorFromHexCode:@"373737"];
        selectFont=[UIFont boldSystemFontOfSize:15];
        noSelectFont=[UIFont systemFontOfSize:15];
        self.backgroundColor=[UIColor whiteColor];
        hSv.backgroundColor=[UIColor whiteColor];
        
    }else{
        selectColor = Pitchup_Color;
        noSelectColor = [UIColor colorFromHexCode:@"373737"];
        selectFont=[UIFont boldSystemFontOfSize:15];
        noSelectFont=[UIFont systemFontOfSize:15];
        self.backgroundColor=[UIColor colorFromHexCode:@"eeeeee"];
        hSv.backgroundColor=[UIColor colorFromHexCode:@"eeeeee"];
        
    }
}

-(void)updateWithArr:(NSArray *)array{
    //522号
    for (UIView *view in hSv.subviews) {
        [view removeFromSuperview];
    }
    hSv.contentSize=CGSizeMake(hSv.frame.size.width,41*array.count);
    
    for (NSInteger i=0; i<array.count; i++) {
        UIButton *btnT=[[UIButton alloc] initWithFrame:CGRectMake(0, 41*i, hSv.frame.size.width, 40.5)];
        [btnT addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btnT.tag=1000+i;
        
        NSDictionary *dic=[array objectAtIndex:i];
        if ([dic isKindOfClass:[NSDictionary class]]) {
            [btnT setTitle:[NSString stringWithFormat:@"     %@",[dic valueForKey:@"cat_name"]]  forState:UIControlStateNormal];
        }
        btnT.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [btnT setTitleColor:noSelectColor forState:UIControlStateNormal];
        [btnT setTitleColor:selectColor forState:UIControlStateSelected];
        btnT.titleLabel.font = noSelectFont;
        [hSv addSubview:btnT];
        
        
        if (isBlackMode) {
            
            [btnT setBackgroundColor:[UIColor whiteColor]];
            UILabel *line=[[UILabel alloc] initWithFrame:CGRectMake(20, 40.5+41*i, hSv.frame.size.width-20, 0.5)];
            line.backgroundColor = LINE_SHALLOW_COLOR;
            line.tag = btnT.tag +10000;
            [hSv addSubview:line];
            
            NSString *secondStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"second"];
            if ([[btnT currentTitle] isEqualToString:secondStr]) {
                UIImageView *image1 = [[UIImageView alloc] initWithFrame:CGRectMake(btnT.width - 30, 10, 22, 17)];
//                image1.image = [UIImage imageNamed:@"icon-xuanzhong@2x"];
                [btnT addSubview:image1];
                btnT.hidden = NO;
                btnT.titleLabel.font=selectFont;
                preBtn=btnT;
                btnT.selected=YES;
            }
            if (!secondStr) {
                if (i == 0) {
                    UIImageView *image1 = [[UIImageView alloc] initWithFrame:CGRectMake(btnT.width - 30, 10, 22, 17)];
//                    image1.image = [UIImage imageNamed:@"icon-xuanzhong@2x"];
                    [btnT addSubview:image1];
                    btnT.hidden = NO;
                    btnT.titleLabel.font=selectFont;
                    preBtn=btnT;
                    btnT.selected=YES;
                }
            }
        }else {
            
            NSString *firstStr= [[NSUserDefaults standardUserDefaults] objectForKey:@"first"];
            [btnT setBackgroundColor:[UIColor colorFromHexCode:@"eeeeee"]];
            if (!firstStr) {
                if (i == 0) {
                    preBtn=btnT;
                    btnT.selected=YES;
                    [btnT setBackgroundColor:[UIColor whiteColor]];
                    btnT.titleLabel.font=selectFont;
                    
                    NSInteger index = (int)btnT.tag-1000;
                    
                    if ([self.delegate respondsToSelector:@selector(tabView:clickAtIndex:)]) {
                        [self.delegate tabView:nil clickAtIndex:index];
                    }
                }
            }
            
            
            if ([[btnT currentTitle] isEqualToString:firstStr]) {
                
                preBtn=btnT;
                btnT.selected=YES;
                [btnT setBackgroundColor:[UIColor whiteColor]];
                btnT.titleLabel.font=selectFont;
                
                NSInteger index = (int)btnT.tag-1000;

                if ([self.delegate respondsToSelector:@selector(tabView:clickAtIndex:)]) {
                    [self.delegate tabView:nil clickAtIndex:index];
                }
            }
            
           
        }
    }
}
-(void)btnClick:(UIButton *)btn{
    NSUserDefaults *na = [NSUserDefaults standardUserDefaults];
    if (btn != preBtn) {
        preBtn.selected = NO;
        btn.selected = YES;
        if (isBlackMode) {
            UILabel *line=(UILabel *)[hSv viewWithTag:btn.tag-10000];
            line.hidden = YES;
            
            moveLine.frame = CGRectMake(20, CGRectGetMaxY(btn.frame), hSv.frame.size.width-20, 0.5);
            
            [preBtn setBackgroundColor:[UIColor whiteColor]];
            [na setObject:[btn currentTitle] forKey:@"second"];
            
        }else {
            [btn setBackgroundColor:[UIColor whiteColor]];
            [preBtn setBackgroundColor:[UIColor colorFromHexCode:@"eeeeee"]];
            [na setObject:[btn currentTitle] forKey:@"first"];
        }
        preBtn = btn;
    }
    
    NSInteger index = (int)btn.tag-1000;
    
    __weak TabSelectView *weakSelf=self;
    if ([self.delegate respondsToSelector:@selector(tabView:clickAtIndex:)]) {
        [self.delegate tabView:weakSelf clickAtIndex:index];
    }
}


@end
