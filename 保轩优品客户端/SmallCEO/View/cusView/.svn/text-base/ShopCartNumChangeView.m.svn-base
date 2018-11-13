//
//  ShopCartNumChangeView.m
//  Lemuji
//
//  Created by quanmai on 15/7/16.
//  Copyright (c) 2015年 quanmai. All rights reserved.
//

#import "ShopCartNumChangeView.h"

@interface ShopCartNumChangeView (){
    UIButton *plusBtn;
    UIButton *minusBtn;
}

@end


@implementation ShopCartNumChangeView
@synthesize textF;
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
//        self.layer.cornerRadius=4;
        self.layer.borderWidth = 1;
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
        
        float threePercent=frame.size.width/3.0;
        
        minusBtn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, threePercent, frame.size.height)];
        minusBtn .backgroundColor=[UIColor clearColor];
        minusBtn.layer.cornerRadius=0;
        [minusBtn setImage:[UIImage imageNamed:@"csl_minus.png"] forState:UIControlStateNormal];
        [minusBtn setImage:[UIImage imageNamed:@"csl_minus.png"] forState:UIControlStateSelected];
        [minusBtn addTarget:self action:@selector(minusNum:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:minusBtn];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(threePercent, 0, 1, frame.size.height)];
        line.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:line];
        
        plusBtn=[[UIButton alloc] initWithFrame:CGRectMake(threePercent*2, 0, threePercent, frame.size.height)];
        plusBtn .backgroundColor=[UIColor clearColor];
        plusBtn.layer.cornerRadius=0;
        [plusBtn setImage:[UIImage imageNamed:@"csl_plus.png"] forState:UIControlStateNormal];
        [plusBtn setImage:[UIImage imageNamed:@"csl_plus.png"] forState:UIControlStateSelected];
        [plusBtn addTarget:self action:@selector(plusNum:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:plusBtn];
        
        UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(threePercent*2, 0, 1, frame.size.height)];
        line1.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:line1];
        
        textF=[[UITextField alloc] initWithFrame:CGRectMake(threePercent, 0, threePercent, frame.size.height)];
        [textF setBorderStyle:UITextBorderStyleNone];
        textF.delegate=nil;
        textF.userInteractionEnabled=NO;
        textF.backgroundColor=[UIColor clearColor];
        textF.textColor=[UIColor blackColor];
        textF.keyboardType=UIKeyboardTypeNumberPad;
        textF.textAlignment=NSTextAlignmentCenter;
        [self addSubview:textF];
        
        
    }
    return self;
}

#pragma mark - 加减商品
-(void)minusNum:(UIButton *)btn{
    NSInteger d = btn.tag;
    DLog(@"%ld",(long)d);
    DLog(@"%ld",(long)self.tag);
    [self changeText:@"-1"];
    //    if ([textF.text integerValue]>1) {
    //        textF.text= [NSString stringWithFormat:@"%ld",[textF.text integerValue]-1];
    //    }

}
-(void)plusNum:(UIButton *)btn{
    //    int num = [textF.text intValue];
    NSInteger d = btn.tag;
    DLog(@"%ld",(long)d);
    [self changeText:@"+1"];
    //    if (self.canBuyNum != 0 && self.canBuyNum <= num) {
    //        NSString *msg = [NSString stringWithFormat:@"è¯¥äº§åéè´­%dä»¶",self.canBuyNum];
    //        UIAlertView *alt = [[UIAlertView alloc] initWithTitle:App_Alert_Notice_Title message:msg delegate:nil cancelButtonTitle:@"ç¡®å®" otherButtonTitles:nil, nil];
    //        [alt show];
    //        textF.text = [NSString stringWithFormat:@"%d",self.canBuyNum];
    //    }else {
    //        textF.text= [NSString stringWithFormat:@"%ld",[textF.text integerValue]+1];
    //    }

}

-(void)setInitialText:(NSString *)num{
    textF.text=num;
}

-(NSString *)getNewNum{
    NSInteger num=[textF.text integerValue];
    if (num<=0) {
        return @"1";
    }else{
        return [NSString stringWithFormat:@"%ld",num];
    }
    
}

-(void)changeText:(NSString *)num{
    if ([self.delegate respondsToSelector:@selector(changeNumWithString:)]) {
        [self.delegate changeNumWithString:num];
    }
}


@end
