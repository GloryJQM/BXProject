//
//  EnterphonenumberView.m
//  chufake
//
//  Created by wuxiaohui on 13-12-25.
//  Copyright (c) 2013年 quanmai. All rights reserved.
//

#import "EnterphonenumberView.h"
#import "FUIButton.h"

@implementation EnterphonenumberView
@synthesize  _recommendTextfield;
@synthesize delegate;



- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _phoneNumberTextfield = [[UITextField alloc]initWithFrame:CGRectMake(53.0/2.0, 24.0, self.frame.size.width-53.0, 30.0)];
        _phoneNumberTextfield.text = @"";
        _phoneNumberTextfield.placeholder = @"请输入手机号";
        _phoneNumberTextfield.textAlignment = NSTextAlignmentCenter;
        _phoneNumberTextfield.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _phoneNumberTextfield.textColor = [UIColor colorWithWhite:0.4 alpha:1.0];
        _phoneNumberTextfield.layer.borderColor = [[UIColor colorWithWhite:0.8 alpha:1.0] CGColor];
        _phoneNumberTextfield.keyboardType=UIKeyboardTypeNumberPad;
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

        bottomView = [[UIView alloc]initWithFrame:CGRectMake(0.0, 24+35, self.frame.size.width, 50.0)];
        bottomView.backgroundColor = [UIColor clearColor];
        [self addSubview:bottomView];
      //  [_viewArray addObject:bottomView];
        
        
        UIButton *agreeBtn = [[UIButton alloc]initWithFrame:CGRectMake(53.0/2.0-10, 3.0, 44, 44)];
        agreeBtn.backgroundColor = [UIColor clearColor];
        [agreeBtn setImage:[UIImage imageNamed:@"btn_quan.png"] forState:UIControlStateNormal];
        [agreeBtn setImage:[UIImage imageNamed:@"btn_xuanzhe.png"] forState:UIControlStateSelected];
        [agreeBtn addTarget:self action:@selector(agreeBtn:) forControlEvents:UIControlEventTouchUpInside];
        agreeBtn.selected=YES;
        [bottomView addSubview:agreeBtn];
        
        agreeBool = agreeBtn.selected;
        
        UILabel *agreeLabel = [[UILabel alloc]initWithFrame:CGRectMake(53.0/2.0-10+40.0, 4.0, 220.0, 42.0)];
        agreeLabel.text = @"我同意商城条款";
        
        agreeLabel.backgroundColor = [UIColor clearColor];
        agreeLabel.textColor =[UIColor colorWithWhite:.4 alpha:1];;
        [bottomView addSubview:agreeLabel];
        
        
        
        UILabel *agreementLabel = [[UILabel alloc]initWithFrame:CGRectMake(230-3, 2.0, 70, 44)];
        agreementLabel.backgroundColor = [UIColor clearColor];
        agreementLabel.text  = @"服务条款";
        agreementLabel.userInteractionEnabled=YES;
        agreementLabel.textColor = [UIColor colorFromHexCode:@"#00C0F0"];
        [bottomView addSubview:agreementLabel];
        
        UITapGestureRecognizer *agreeTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(agreementTap)];
        agreeTap.numberOfTapsRequired =1;
        [agreementLabel addGestureRecognizer:agreeTap];
        
        btn = [[FUIButton alloc]initWithFrame:CGRectMake(53.0/2.0, 24+35+55,  self.frame.size.width-53.0, 35.0)];
        btn.cornerRadius = 3.0;
        btn.buttonColor = App_Main_Color;
        [btn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(phoneNumberbtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        
        
        //邀请码TextField
        _recommendTextfield = [[UITextField alloc]initWithFrame:CGRectMake(53.0/2.0, 24+35+55+45+45, self.frame.size.width-53.0, 30.0)];
        _recommendTextfield.text = @"";
        _recommendTextfield.placeholder = @"请输入邀请码";
        _recommendTextfield.textAlignment = NSTextAlignmentCenter;
        _recommendTextfield.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _recommendTextfield.textColor = [UIColor colorWithWhite:0.4 alpha:1.0];
        _recommendTextfield.layer.borderColor = [[UIColor colorWithWhite:0.8 alpha:1.0] CGColor];
        _recommendTextfield.layer.borderWidth = 1.0;
        _recommendTextfield.layer.cornerRadius = 3.0;
        _recommendTextfield.backgroundColor = [UIColor clearColor];
        _recommendTextfield.delegate = self;
        _recommendTextfield.hidden = YES;
        _recommendTextfield.tag = 500;
        [self addSubview:_recommendTextfield];
        UIButton *btnT1=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 33)];
        btnT1.backgroundColor=[UIColor colorFromHexCode:@"d9d9d9" alpha:1];
        [btnT1 setTitle:@"轻触此处可隐藏键盘" forState:UIControlStateNormal];
        btnT1.titleLabel.font=[UIFont systemFontOfSize:14];
        [btnT1 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [btnT1 addTarget:self action:@selector(missKeyBoard) forControlEvents:UIControlEventTouchUpInside];
        _recommendTextfield.inputAccessoryView=btnT;
        
        
        UIView *middleView = [[UIView alloc] initWithFrame:CGRectMake(53.0/2.0, 24+35+55+45, self.frame.size.width, 40.0)];
        middleView.backgroundColor = [UIColor clearColor];
        [self addSubview:middleView];
        
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 2, 140, 30)];
        label1.text = @"是否有邀请码:   是";
        label1.textColor = [UIColor colorWithWhite:0.2 alpha:1.0];
        label1.backgroundColor = [UIColor clearColor];
        [middleView addSubview:label1];
        
        //有邀请码按钮
        haveBtn = [[UIButton alloc]initWithFrame:CGRectMake(140, 0.0, 34, 34)];
        haveBtn.backgroundColor = [UIColor clearColor];
        [haveBtn setImage:[UIImage imageNamed:@"btn_quan.png"] forState:UIControlStateNormal];
        [haveBtn setImage:[UIImage imageNamed:@"btn_xuanzhe.png"] forState:UIControlStateSelected];
        [haveBtn addTarget:self action:@selector(haveBtn:) forControlEvents:UIControlEventTouchUpInside];
        haveBtn.selected = NO;
        [middleView addSubview:haveBtn];
        
        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(180, 2, 20, 30)];
        label2.text = @"否";
        label2.textColor = [UIColor colorWithWhite:0.2 alpha:1.0];
        label2.backgroundColor = [UIColor clearColor];
        [middleView addSubview:label2];
        //没有邀请码按钮
        noBtn = [[UIButton alloc]initWithFrame:CGRectMake(200, 0.0, 34, 34)];
        noBtn.backgroundColor = [UIColor clearColor];
        [noBtn setImage:[UIImage imageNamed:@"btn_quan.png"] forState:UIControlStateNormal];
        [noBtn setImage:[UIImage imageNamed:@"btn_xuanzhe.png"] forState:UIControlStateSelected];
        [noBtn addTarget:self action:@selector(noBtn:) forControlEvents:UIControlEventTouchUpInside];
        noBtn.selected=YES;
        [middleView addSubview:noBtn];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeKeyBoard)];
        tap.numberOfTapsRequired = 1;
        [self addGestureRecognizer:tap];
    }
    return self;
}


-(void)phoneNumberbtn:(FUIButton*)btn{
    [self endEditing:YES];
    
    if ([_phoneNumberTextfield.text isEqualToString:@""]) {
        UIAlertView *alertive = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"请输入手机号码!" delegate:self cancelButtonTitle:@"好的" otherButtonTitles: nil];
        [alertive show];
        return;
    }
    
    if (haveBtn.selected == YES && [_recommendTextfield.text isEqualToString:@""]) {
        UIAlertView *alertive = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"请输入邀请码！" delegate:self cancelButtonTitle:@"好的" otherButtonTitles: nil];
        [alertive show];
        return;
    }
    
        if (agreeBool == NO) {
            UIAlertView *alertive = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"请同意服务条款！" delegate:self cancelButtonTitle:@"好的" otherButtonTitles: nil];
            [alertive show];
            return;
        }
    
    
    [_target performSelector:_sel withObject:_phoneNumberTextfield.text withObject:_recommendTextfield.text];
    _phoneNumberTextfield.text = @"";
    _recommendTextfield.text = @"";

}

-(void)agreeBtn:(UIButton*)button{
    [self endEditing:YES];
    button.selected = !button.selected;
    agreeBool = button.selected;

}

- (void)haveBtn:(UIButton *)button{
    noBtn.selected = NO;
    if (button.selected == YES)
        return;
    button.selected = !button.selected;
    _recommendTextfield.hidden = NO;

}

- (void)noBtn:(UIButton *)button{
    [self endEditing:YES];
    haveBtn.selected = NO;
    if (button.selected == YES) {
        return;
    }
    button.selected = !button.selected;
    _recommendTextfield.hidden = YES;

}
-(void)missKeyBoard
{
    [self endEditing:YES];
}
-(void)agreementTap{

    if ([delegate respondsToSelector:@selector(showServiceWeb)]) {
        [delegate showServiceWeb];
    }
}

-(void)addEnterPhonenumberSelect:(id)target selector:(SEL)sel{
    _target = target;
    _sel = sel;
}

-(void)removeKeyBoard{
    [_phoneNumberTextfield resignFirstResponder];
    [_recommendTextfield resignFirstResponder];
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if (IS_IPHONE4)
        if (500 == textField.tag) {
            [UIView animateWithDuration:0.375 animations:^{
                CGRect rect = self.frame;
                rect.origin.y -= 120;
                rect.size.height += 120;
                self.frame = rect;
            }];
        }
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (IS_IPHONE4)
        if (500 == textField.tag) {
            [UIView animateWithDuration:0.375 animations:^{
                CGRect rect = self.frame;
                rect.origin.y += 120;
                rect.size.height -=120;
                self.frame = rect;
            }];
        }
}

@end
