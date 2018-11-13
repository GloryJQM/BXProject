//
//  FindPassewordView.m
//  WanHao
//
//  Created by Lai on 14-4-17.
//  Copyright (c) 2014年 wuxiaohui. All rights reserved.
//

#import "FindPassewordView.h"
#import "FUIButton.h"

@implementation FindPassewordView

-(void)dealloc{
    [_textArray removeAllObjects];
    
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _textArray = [[NSMutableArray alloc]init];
        
        UILabel *passwordTip = [[UILabel alloc] initWithFrame:CGRectMake(53.0/2.0, 24.0, self.frame.size.width-53.0, 20.0)];
        passwordTip.text = @"请输入密码:";
        passwordTip.font=[UIFont systemFontOfSize:16];
        passwordTip.backgroundColor = [UIColor clearColor];
        [self addSubview:passwordTip];
        
        
        UITextField *keyTextfield = [[UITextField alloc]initWithFrame:CGRectMake(53.0/2.0, 24.0+25, self.frame.size.width-53.0, 30.0)];
        keyTextfield.text = @"";
//        keyTextfield.placeholder = @"请输入密码";
        keyTextfield.textAlignment = NSTextAlignmentCenter;
        keyTextfield.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        keyTextfield.textColor = [UIColor colorWithWhite:0.4 alpha:1.0];
        keyTextfield.layer.borderColor = [[UIColor colorWithWhite:0.8 alpha:1.0] CGColor];
        keyTextfield.layer.borderWidth = 1.0;
        keyTextfield.layer.cornerRadius = 3.0;
        keyTextfield.secureTextEntry = YES;
        keyTextfield.backgroundColor = [UIColor clearColor];
        keyTextfield.tag = 400;
        keyTextfield.delegate = self;
        [self addSubview:keyTextfield];
        [_textArray addObject:keyTextfield];
        UIButton *btnT1=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 33)];
        btnT1.backgroundColor=[UIColor colorFromHexCode:@"d9d9d9" alpha:1];
        [btnT1 setTitle:@"轻触此处可隐藏键盘" forState:UIControlStateNormal];
        btnT1.titleLabel.font=[UIFont systemFontOfSize:14];
        [btnT1 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [btnT1 addTarget:self action:@selector(missKeyBoard) forControlEvents:UIControlEventTouchUpInside];
        keyTextfield.inputAccessoryView=btnT1;
        
        UILabel *confirmTip = [[UILabel alloc] initWithFrame:CGRectMake(53.0/2.0, 24.0+25+35, self.frame.size.width-53.0, 20.0)];
        confirmTip.text = @"再次输入密码:";
        confirmTip.font=[UIFont systemFontOfSize:16];
        confirmTip.backgroundColor = [UIColor clearColor];
        [self addSubview:confirmTip];
        
        UITextField *nextKeyTextfield = [[UITextField alloc]initWithFrame:CGRectMake(53.0/2.0, 24.0+25+35+25, self.frame.size.width-53.0, 30.0)];
        nextKeyTextfield.text = @"";
//        nextKeyTextfield.placeholder = @"再次输入";
        nextKeyTextfield.textAlignment = NSTextAlignmentCenter;
        nextKeyTextfield.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        nextKeyTextfield.textColor = [UIColor colorWithWhite:0.4 alpha:1.0];
        nextKeyTextfield.layer.borderColor = [[UIColor colorWithWhite:0.8 alpha:1.0] CGColor];
        nextKeyTextfield.layer.borderWidth = 1.0;
        nextKeyTextfield.layer.cornerRadius = 3.0;
        nextKeyTextfield.secureTextEntry = YES;
        nextKeyTextfield.backgroundColor = [UIColor clearColor];
        nextKeyTextfield.tag = 500;
        nextKeyTextfield.delegate = self;
        [self addSubview:nextKeyTextfield];
        [_textArray addObject:nextKeyTextfield];
        UIButton *btnT=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 33)];
        btnT.backgroundColor=[UIColor colorFromHexCode:@"d9d9d9" alpha:1];
        [btnT setTitle:@"轻触此处可隐藏键盘" forState:UIControlStateNormal];
        btnT.titleLabel.font=[UIFont systemFontOfSize:14];
        [btnT setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [btnT addTarget:self action:@selector(missKeyBoard) forControlEvents:UIControlEventTouchUpInside];
        nextKeyTextfield.inputAccessoryView=btnT;
        
        
        
        FUIButton*btn = [[FUIButton alloc]initWithFrame:CGRectMake(53.0/2.0, 24.0+25+35+25+35+20,  self.frame.size.width-53.0, 30.0)];
        btn.cornerRadius = 3.0;
        btn.buttonColor = App_Main_Color;
        [btn setTitle:@"完成找回" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(passWordBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeKeyBoard)];
        tap.numberOfTapsRequired = 1;
        [self addGestureRecognizer:tap];
        
        
        // Initialization code
    }
    return self;
}
- (void)missKeyBoard {
    [self endEditing:YES];
}
-(void)addPassWordViewSelector:(id)target selector:(SEL)sel{
    _target = target;
    _sel = sel;
}

-(void)passWordBtn:(FUIButton*)btn{
    
    NSString *passWordStr = ((UITextField*)[_textArray objectAtIndex:0]).text;
    NSString *passWordStr1 = ((UITextField*)[_textArray objectAtIndex:1]).text;
    
    
    if (![passWordStr isEqualToString:passWordStr1]) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"两次输入的密码不同,请重新输入" delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil];
        [alertView show];
        ((UITextField*)[_textArray objectAtIndex:1]).text = @"";
        return;
    }
    if ([passWordStr isEqualToString:@""]||[passWordStr1 isEqualToString:@""]) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"输入的内容不能为空" delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil];
        [alertView show];
        return;
    }
    [_target performSelector:_sel withObject:passWordStr];
    
    ((UITextField*)[_textArray objectAtIndex:0]).text = @"";
    ((UITextField*)[_textArray objectAtIndex:1]).text = @"";
    
}

-(void)removeKeyBoard{
    
    for (int i=0; i<2; i++) {
        UITextField*textfield = (UITextField*)[_textArray objectAtIndex:i];
        [textfield resignFirstResponder];
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if (IS_IPHONE4)
        if (500 == textField.tag) {
            [UIView animateWithDuration:0.375 animations:^{
                CGRect rect = self.frame;
                rect.origin.y -= 50;
                rect.size.height += 50;
                self.frame = rect;
            }];
        }
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (IS_IPHONE4)
        if (500 == textField.tag) {
            [UIView animateWithDuration:0.375 animations:^{
                CGRect rect = self.frame;
                rect.origin.y += 50;
                rect.size.height -= 50;
                self.frame = rect;
            }];
        }
}
   

@end
