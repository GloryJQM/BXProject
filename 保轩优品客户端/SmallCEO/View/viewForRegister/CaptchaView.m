//
//  CaptchaView.m
//  chufake
//
//  Created by wuxiaohui on 13-12-25.
//  Copyright (c) 2013年 quanmai. All rights reserved.
//

#import "CaptchaView.h"
#import "FUIButton.h"

@implementation CaptchaView
{
    FUIButton*againBtn;
}
-(void)dealloc{
    NSLog(@"CaptchaView!");
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        UILabel *passwordTip = [[UILabel alloc] initWithFrame:CGRectMake(53.0/2.0, 24.0, self.frame.size.width-53.0, 20.0)];
        passwordTip.text = @"请输入短信验证码:";
        passwordTip.font=[UIFont systemFontOfSize:16];
        passwordTip.backgroundColor = [UIColor clearColor];
        [self addSubview:passwordTip];
        
        
        
        _phoneNumberTextfield = [[UITextField alloc]initWithFrame:CGRectMake(53.0/2.0, 24.0+25, self.frame.size.width-53.0, 30.0)];
        _phoneNumberTextfield.text = @"";
        _phoneNumberTextfield.textAlignment = NSTextAlignmentCenter;
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
        
        FUIButton*btn = [[FUIButton alloc]initWithFrame:CGRectMake(53.0/2.0, 24.0+25+35,  self.frame.size.width-53.0, 30.0+5)];
        btn.cornerRadius = 3.0;
        btn.buttonColor = App_Main_Color;
        [btn setTitle:@"提交验证" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(captchaNumberbtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        
        
        UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0.0, 24.0+25+35+35+5, self.frame.size.width, 50.0)];
        bottomView.backgroundColor = [UIColor clearColor];
        [self addSubview:bottomView];
        
        
        againBtn = [[FUIButton alloc]initWithFrame:CGRectMake(53.0/2.0, 0.0, 114.0, 30.0+5)];
        againBtn.cornerRadius = 3.0;
        againBtn.buttonColor = [UIColor colorFromHexCode:@"#6C6C6C"];
        [againBtn setTitle:@"重获验证码" forState:UIControlStateNormal];
        [againBtn addTarget:self action:@selector(againBtn:) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:againBtn];
        
        _timeLabe = [[UILabel alloc]initWithFrame:CGRectMake(312.0/2.0, 0.0, 160.0, 30.0+5)];
        _timeLabe.text = @"59秒后重获验证码";
        _timeLabe.textColor = [UIColor colorFromHexCode:@"#6C6C6C"];
        _timeLabe.backgroundColor = [UIColor clearColor];
        [bottomView addSubview:_timeLabe];
        time = 60.0;
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(changeTimeAtTimedisplay:) userInfo:nil repeats:YES];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeKeyBoard)];
        tap.numberOfTapsRequired = 1;
        [self addGestureRecognizer:tap];
        
       
    }
    return self;
}
- (void)missKeyBoard {
    [_phoneNumberTextfield endEditing:YES];
}

-(void)timerStar{
    time = 60.0;
}

-(void)changeTimeAtTimedisplay:(id)sender{
    time --;
    if (time <= 0) {
         _timeLabe.text = @"";
        againBtn.enabled = YES;
    }else{
          _timeLabe.text = [NSString stringWithFormat:@"%d秒后重获验证码",time];
        againBtn.enabled = NO;
    }
   
}

-(void)addCapchaSelector:(id)target selector:(SEL)sel{
    _target = target;
    _sel = sel;

}
-(void)captchaNumberbtn:(FUIButton*)btn{
    
    if ([_phoneNumberTextfield.text isEqualToString:@""]) {
        UIAlertView *alerV = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"请输入你的验证码" delegate:self cancelButtonTitle:@"好的" otherButtonTitles: nil];
        [alerV show];
        return;
    }
    [self endEditing:YES];
    if (_target) {
         [_target performSelector:_sel withObject:_phoneNumberTextfield.text];
    }
   
    _phoneNumberTextfield.text = @"";
}
-(void)againBtn:(FUIButton*)btn{
    time = 59.0;
    [_delegate captchagain:YES];
}

-(void)removeKeyBoard{
    [_phoneNumberTextfield resignFirstResponder];
}



@end
