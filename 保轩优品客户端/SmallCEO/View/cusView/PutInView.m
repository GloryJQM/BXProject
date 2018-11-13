//
//  PutInView.m
//  Lemuji
//
//  Created by chensanli on 15/7/14.
//  Copyright (c) 2015年 quanmai. All rights reserved.
//

#import "PutInView.h"

@implementation PutInView

-(instancetype)initWithFrame:(CGRect)frame and:(NSArray *)array
{
    self = [super init];
    if(self)
    {
        for(int i = 0;i<array.count;i++)
        {
            UIView* backGroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0+62*i, frame.size.width, 62)];
            backGroundView.userInteractionEnabled = YES;
            
            UIButton *btnI=[[UIButton alloc] initWithFrame:backGroundView.bounds];
            btnI .backgroundColor=[UIColor clearColor];
            btnI.layer.cornerRadius=0;
            btnI.tag=i;
            [btnI addTarget:self action:@selector(tfBecomeFirstResponder:) forControlEvents:UIControlEventTouchUpInside];
            [backGroundView addSubview:btnI];
            
            UILabel* titleLab = [[UILabel alloc]initWithFrame:CGRectMake(5, 12, 80, 18)];
            titleLab.text = array[i];
            titleLab.font = [UIFont systemFontOfSize:14];
            titleLab.textColor = [UIColor blackColor];
            [backGroundView addSubview:titleLab];
            
            UITextField* textF = [[UITextField alloc]initWithFrame:CGRectMake(85, 12, backGroundView.frame.size.width-85, 20)];
            textF.textColor = BLACK_COLOR;
            
            
            textF.tag = i;
            [backGroundView addSubview:textF];
            if(i==0)
            {
                self.phoneNumTf = textF;
            }else if(i==1)
            {
                self.passWordTf = textF;
            }else if(i==2)
            {
                self.surePwdTf = textF;
            }else if(i==3)
            {
                self.twoCodeTf = textF;
            }else if(i==4)
            {
                self.yaoQingCodeTf = textF;
            }
            
            
            UIView* line = [[UIView alloc]initWithFrame:CGRectMake(5, 36, frame.size.width-10, 1)];
            line.backgroundColor = LINE_SHALLOW_COLOR;
            
            [backGroundView addSubview:line];
            
            [self addSubview:backGroundView];
            
            [self.textFArray addObject:textF];
            
            
        }
    }
    
    [self setFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 62*array.count)];
    
    return self;
}

-(void)setPlaceHolders:(NSArray *)arr{
    
    NSArray *tempArr=[NSArray arrayWithArray:arr];
    if (tempArr.count==5) {
        NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:14], NSForegroundColorAttributeName: [UIColor colorFromHexCode:@"686868"]};
        NSMutableAttributedString *temp1=[[NSMutableAttributedString alloc] initWithString:[tempArr objectAtIndex:0]  attributes:dic];
        NSMutableAttributedString *temp2=[[NSMutableAttributedString alloc] initWithString:[tempArr objectAtIndex:1]  attributes:dic];
        NSMutableAttributedString *temp3=[[NSMutableAttributedString alloc] initWithString:[tempArr objectAtIndex:2]  attributes:dic];
        NSMutableAttributedString *temp4=[[NSMutableAttributedString alloc] initWithString:[tempArr objectAtIndex:3]   attributes:dic];
        NSMutableAttributedString *temp5=[[NSMutableAttributedString alloc] initWithString:[tempArr objectAtIndex:4]   attributes:dic];
        
        self.phoneNumTf.attributedPlaceholder=temp1;
        self.passWordTf.attributedPlaceholder=temp2;
        self.surePwdTf.attributedPlaceholder=temp3;
        self.twoCodeTf.attributedPlaceholder=temp4;
        self.yaoQingCodeTf.attributedPlaceholder=temp5;
        
    }
}

-(void)tfBecomeFirstResponder:(UIButton *)btn{
    if (btn.tag==0) {
        [self.phoneNumTf becomeFirstResponder];
    }
    if (btn.tag==1) {
        [self.passWordTf becomeFirstResponder];
    }
    if (btn.tag==2) {
        [self.surePwdTf becomeFirstResponder];
    }
    if (btn.tag==3) {
        [self.twoCodeTf becomeFirstResponder];
    }
}

@end
