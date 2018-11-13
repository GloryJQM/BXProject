//
//  FindphonenumberView.m
//  WanHao
//
//  Created by Lai on 14-4-17.
//  Copyright (c) 2014年 wuxiaohui. All rights reserved.
//

#import "FindphonenumberView.h"
#import "FUIButton.h"

@implementation FindphonenumberView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        _phoneNumberTextfield = [[UITextField alloc]initWithFrame:CGRectMake(53.0/2.0, 24.0, self.frame.size.width-53.0, 30.0)];
        _phoneNumberTextfield.text = @"";
        _phoneNumberTextfield.placeholder = @"请输入手机号";
        _phoneNumberTextfield.textAlignment = NSTextAlignmentCenter;
        _phoneNumberTextfield.keyboardType=UIKeyboardTypeNumberPad;
        _phoneNumberTextfield.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _phoneNumberTextfield.textColor = [UIColor colorWithWhite:0.4 alpha:1.0];
        _phoneNumberTextfield.layer.borderColor = [[UIColor colorWithWhite:0.8 alpha:1.0] CGColor];
        _phoneNumberTextfield.layer.borderWidth = 1.0;
        _phoneNumberTextfield.layer.cornerRadius = 3.0;
        _phoneNumberTextfield.backgroundColor = [UIColor clearColor];
        _phoneNumberTextfield.delegate = self;
        [self addSubview:_phoneNumberTextfield];
        UIButton *btnT=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 33)];
        btnT.backgroundColor=[UIColor colorFromHexCode:@"d9d9d9" alpha:1];
        [btnT setTitle:@"轻触此处可隐藏键盘" forState:UIControlStateNormal];
        btnT.titleLabel.font=[UIFont systemFontOfSize:14];
        [btnT setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [btnT addTarget:self action:@selector(missKeyBoard) forControlEvents:UIControlEventTouchUpInside];
        _phoneNumberTextfield.inputAccessoryView=btnT;
        
        FUIButton*btn = [[FUIButton alloc]initWithFrame:CGRectMake(53.0/2.0, 71.5,  self.frame.size.width-53.0, 30.0+5)];
        btn.cornerRadius = 3.0;
        btn.buttonColor = App_Main_Color;
        [btn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(phoneNumberbtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0.0, 225.0/2.0, self.frame.size.width, 50.0)];
        bottomView.backgroundColor = [UIColor clearColor];
        [self addSubview:bottomView];
        //  [_viewArray addObject:bottomView];
        
        
        // Initialization code
    }
    return self;
}

-(void)phoneNumberbtn:(FUIButton*)btn{
    
    
    if ([_phoneNumberTextfield.text isEqualToString:@""]) {
        UIAlertView *alertive = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"请输入手机号码!" delegate:self cancelButtonTitle:@"好的" otherButtonTitles: nil];
        [alertive show];
        return;
    }
    
    [_target performSelector:_sel withObject:_phoneNumberTextfield.text];
    _phoneNumberTextfield.text = @"";
    
}

-(void)missKeyBoard{
    [_phoneNumberTextfield endEditing:YES];
}



-(void)agreementTap:(UIGestureRecognizer*)tap{
    
    
}

-(void)addEnterPhonenumberSelect:(id)target selector:(SEL)sel{
    _target = target;
    _sel = sel;
    
}

-(void)removeKeyBoard{
    [_phoneNumberTextfield resignFirstResponder];
}



/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */


@end
