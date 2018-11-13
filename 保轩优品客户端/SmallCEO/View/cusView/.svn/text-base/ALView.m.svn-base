//
//  ALView.m
//  gongfubao
//
//  Created by chensanli on 15/6/30.
//  Copyright (c) 2015年 quanmai. All rights reserved.
//

#import "ALView.h"

@implementation ALView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithCancelBtnTitle:(NSString *)cancelBtnTitle andSureBtn:(NSString *)sureBtnTitle andTitle:(NSString *)title andMessage:(NSString *)message orPlaceholder:(NSString *)placeholder andIsPwd:(BOOL)isPwd Animation:(BOOL)animation
{
    self = [super init];
    if(self)
    {
        self.animation = animation;
        if (animation) {
            self.frame = CGRectMake(10, UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH-20, 160);
        }else
        {
            self.frame = CGRectMake(10, UI_SCREEN_HEIGHT/2-80, UI_SCREEN_WIDTH-20, 160);
        }
        
        self.backgroundColor = [UIColor colorFromHexCode:@"dddddd"];
        self.alpha = .95;
        float x = self.frame.size.width;
        UILabel* lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 15, x, 25)];
        lab.text = title;
        lab.font = [UIFont boldSystemFontOfSize:20];
        lab.textAlignment = NSTextAlignmentCenter;
        [self addSubview:lab];
        
        int i = 0;
        if(placeholder == nil)
        {
            UILabel* msg = [[UILabel alloc]initWithFrame:CGRectMake(25, 40, x-50, 50)];
            msg.numberOfLines = 0;
            msg.textColor = [UIColor colorFromHexCode:@"111111"];
            msg.textAlignment = NSTextAlignmentCenter;
            [self addSubview:msg];
            
            msg.text = message;
            
            CGSize size =  [msg sizeThatFits:CGSizeMake(x-50, 200)];
            
            if(size.height>UI_SCREEN_HEIGHT*.618)
            {
                size.height = UI_SCREEN_HEIGHT*.618;
            }
            
            [msg setFrame:CGRectMake(25, 40, x-50, size.height)];
            [self setFrame:CGRectMake(10, UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH-20, 110+size.height)];
            
            if(sureBtnTitle == nil)
            {
                i = 1;
            }else
            {
                i = 2;
            }
        }else
        {
            UIView* vi = [[UITextField alloc]initWithFrame:CGRectMake(25, 50, x-50, 35)];
            vi.backgroundColor = [UIColor whiteColor];
            vi.layer.cornerRadius = 5.0;
            [self addSubview:vi];
            
            UITextField* textF = [[UITextField alloc]initWithFrame:CGRectMake(5, 0, x-60, 35)];
            if(isPwd)
            {
                textF.secureTextEntry = YES;
            }
            textF.placeholder = placeholder;
            textF.backgroundColor = [UIColor colorFromHexCode:@"ffffff"];
            self.textFleld = textF;
            [vi addSubview:textF];
            i = 2;
        }
        
        
        for(int j = 0;j<i;j++)
        {
            UIButton* btn = [[UIButton alloc]initWithFrame:CGRectMake(15+j*((x-(30*i))/i+30), self.frame.size.height-25-35, (x-(30*i))/i, 35)];
            if(j==0)
            {
                [btn setBackgroundColor:WHITE_COLOR];
                [btn setTitleColor:TIILE_COLOR forState:UIControlStateNormal];
                [btn setTitle:cancelBtnTitle forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
            }else if(j==1)
            {
                [btn setBackgroundColor:BLUE_COLOR];
                [btn setTitle:sureBtnTitle forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(clickSure) forControlEvents:UIControlEventTouchUpInside];
            }
            btn.layer.cornerRadius = 8.0;
            
            [self addSubview:btn];
        }
    }
    self.y = self.frame.size.height;
    self.layer.cornerRadius = 10.0;
    return self;
}

-(instancetype)initWithCancelBtnTitle:(NSString *)cancelBtnTitle andSureBtn:(NSString *)sureBtnTitle andTitle:(NSString *)title andMsgView:(UIView *)msgView isAnimation:(BOOL)animation
{
    self = [super init];
    if(self)
    {
        self.animation = animation;
        if (animation) {
            self.frame = CGRectMake(0, UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH, 200);
        }else
        {
            self.frame = CGRectMake(0, UI_SCREEN_HEIGHT/2-100, UI_SCREEN_WIDTH, 200);
        }
        
        [self addSubview:msgView];
        
        int i = 0;
        if(sureBtnTitle == nil)
        {
            i = 1;
        }else
        {
            i = 2;
        }
        
        float x = self.frame.size.width;
        for(int j = 0;j<i;j++)
        {
            UIButton* btn = [[UIButton alloc]initWithFrame:CGRectMake(15+j*((x-(30*i))/i+30), self.frame.size.height-25-45, (x-(30*i))/i, 45)];
            if(j==0)
            {
                [btn setBackgroundColor:App_Main_Color];
                [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [btn setTitle:cancelBtnTitle forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
            }else if(j==1)
            {
                [btn setBackgroundColor:BLUE_COLOR];
                [btn setTitle:sureBtnTitle forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(clickSure) forControlEvents:UIControlEventTouchUpInside];
            }
            [self addSubview:btn];
        }
        self.y = self.frame.size.height;
    }
    return self;
}

-(void)cancelClick
{
    [UIView animateWithDuration:0.2 animations:^{
        [self setTransform:CGAffineTransformMake(1, 0, 0, 1, 0, 0)];
    } completion:^(BOOL finished) {
        for ( __strong UIWindow *window  in [UIApplication sharedApplication].windows )
            
        {
            if(window.tag == 889)
            {
                window.hidden = YES;
                window = nil;
            }
        }
    }];
}

-(void)goInWindow
{
    self.win = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.win setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:.7]];
    self.win.windowLevel = 2001;
    self.win.tag = 889;
    [self.win addSubview:self];
    [self.win makeKeyAndVisible];
    
    if(self.animation)
    {
        ATM_APPEAR .2];
        DLog(@"%f",self.y);
        [self setTransform:CGAffineTransformMake(1, 0, 0, 1, 0, -(UI_SCREEN_HEIGHT-(UI_SCREEN_HEIGHT-self.y)/2))];
        [UIView commitAnimations];
    }
}

-(void)clickSure
{
    if([self.delegate respondsToSelector:@selector(sureClick:)])
    {
        [self.delegate sureClick:self.textFleld.text];
    }
    
    [UIView animateWithDuration:0.2 animations:^{
        [self setTransform:CGAffineTransformMake(1, 0, 0, 1, 0, 0)];
    } completion:^(BOOL finished)
    {
        for ( __strong UIWindow *window  in [UIApplication sharedApplication].windows )
        {
            if(window.tag == 889)
            {
                window.hidden = YES;
                window = nil;
            }
        }
    }];
}



@end
