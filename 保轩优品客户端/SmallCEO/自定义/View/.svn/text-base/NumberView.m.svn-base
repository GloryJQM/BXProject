//
//  NumberView.m
//  SmallCEO
//
//  Created by 任成龙 on 2017/7/31.
//  Copyright © 2017年 lemuji. All rights reserved.
//

#import "NumberView.h"
@interface NumberView()<UITextFieldDelegate>{
    UIButton *_selectButton;
    UIView *TfBackView;
    UILabel *warningLabel;
}

@end
@implementation NumberView
- (instancetype)initWithFrame:(CGRect)frame finishBlock:(void (^) (NSInteger number))finishBlock {
    self = [super initWithFrame:frame];
    if (self) {
        self.finishBlock = finishBlock;
        [self creationView];
    }
    return self;
}

- (void)creationView {
    
    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor colorFromHexCode:@"#E4E4E4"].CGColor;
    self.layer.cornerRadius = 2;
    
    for(int i = 0;i<2;i++) {
        UIButton* btn = [[UIButton alloc]initWithFrame:CGRectMake(100*i, 0, 40, 40)];
        btn.tag = i;
        [btn setBackgroundColor:WHITE_COLOR];
        [btn addTarget:self action:@selector(choseNum:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *line = [[UILabel alloc] init];
        line .backgroundColor = [UIColor colorFromHexCode:@"#E9E9E9"];
        [btn addSubview:line];
        
        if(i==0) {
            line.frame = CGRectMake(39.5, 0, 0.5, 40);
            [btn setImage:[UIImage imageNamed:@"csl_minus.png"] forState:UIControlStateNormal];
            _selectButton = btn;
        }else if(i==1) {
            [btn setImage:[UIImage imageNamed:@"csl_plus.png"] forState:UIControlStateNormal];
            line.frame = CGRectMake(0, 0, 0.5, 40);
        }
        [self addSubview:btn];
    }
    
    self.textField = [[UITextField alloc]initWithFrame:CGRectMake(40, 0, 60, 40)];
    _textField.keyboardType = UIKeyboardTypeNumberPad;
    _textField.delegate = self;
    _textField.backgroundColor = WHITE_COLOR;
    _textField.textAlignment = NSTextAlignmentCenter;
    _textField.text = @"1";
    _textField.font = [UIFont systemFontOfSize:13];
    [self addSubview:_textField];
}

- (void)choseNum:(UIButton *)sender {
    if(sender.tag == 0) {
        if([self.textField.text integerValue] > 1) {
            self.textField.text = [NSString stringWithFormat:@"%d",[self.textField.text intValue] - 1];
        }
    } else {
        self.textField.text = [NSString stringWithFormat:@"%d",[self.textField.text intValue] + 1];
    }
    
    [self minusColor];
    if (self.finishBlock) {
        self.finishBlock([self.textField.text integerValue]);
    }
}

//减号颜色
- (void)minusColor {
    if ([self.textField.text isEqualToString:@"1"]) {
        [_selectButton setImage:[UIImage imageNamed:@"csl_minus1@2x"] forState:UIControlStateNormal];
        _selectButton.userInteractionEnabled = NO;
    }else {
        [_selectButton setImage:[UIImage imageNamed:@"csl_minus"] forState:UIControlStateNormal];
        _selectButton.userInteractionEnabled = YES;
    }
}

- (void)missKeyBoard {
    [self endEditing:YES];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (!TfBackView) {
        TfBackView = [[UIView alloc]init];
    }
    TfBackView.frame = CGRectMake(0, - UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT);
    TfBackView.userInteractionEnabled = YES;
    [TfBackView addTarget:self action:@selector(missKeyBoard) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:TfBackView];
    
    if (!warningLabel) {
        warningLabel = [[UILabel alloc] init];
    }
    warningLabel.frame = CGRectMake(0, 0, UI_SCREEN_WIDTH, 30);
    warningLabel.font = [UIFont systemFontOfSize:14.0];
    warningLabel.textAlignment = NSTextAlignmentCenter;
    warningLabel.text = @"轻触灰色区域隐藏键盘";
    warningLabel.textColor = backWhite;
    textField.inputAccessoryView = warningLabel;
    
    
    TfBackView.frame = CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT);
    self.frame = CGRectMake(0, -216 + 44, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT);
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.frame = CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT);
    TfBackView.frame = CGRectMake(0, -UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT);
    if (textField.text.length < 1 || textField.text.length > 3|| [textField.text isEqualToString:@"0"]) {
        self.textField.text = @"1";
    }
    [self minusColor];
    if (self.finishBlock) {
        self.finishBlock([self.textField.text integerValue]);
    }
    
}

@end
