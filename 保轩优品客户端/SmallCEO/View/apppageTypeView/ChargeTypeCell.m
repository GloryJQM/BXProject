//
//  ChargeTypeCell.m
//  WanHao
//
//  Created by quanmai on 15/6/18.
//  Copyright (c) 2015年 wuxiaohui. All rights reserved.
//

#import "ChargeTypeCell.h"

@implementation ChargeTypeCell
@synthesize textF,cardNo,passwordTF;


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier   type:(NSInteger)type{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //只有金额
        if (type==1) {

            textF=[[UITextField alloc] initWithFrame:CGRectMake(33.0f,10,UI_SCREEN_WIDTH-34-17, 37)];
            [textF setBorderStyle:UITextBorderStyleRoundedRect]; //外框类型
            textF.placeholder=@"请输入金额";
            textF.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
            textF.autocorrectionType = UITextAutocorrectionTypeNo;
            textF.autocapitalizationType = UITextAutocapitalizationTypeNone;
            textF.keyboardType = UIKeyboardTypeNumberPad;
            textF.clearButtonMode = UITextFieldViewModeWhileEditing; //编辑时会出现个修改X
            textF.textAlignment = NSTextAlignmentLeft;
            textF.autocorrectionType = UITextAutocorrectionTypeNo;//不纠错
            textF.text = @"";
            [self.contentView addSubview:textF];
//            _chargecontent.delegate=self;

        }
        //充值卡类型
        else{
            backView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH-20, 92)];
            backView.backgroundColor=[UIColor whiteColor];
            [self.contentView addSubview:backView];
            
            
            for (int i=0; i<2; i++) {
                
                UILabel *temp=[[UILabel alloc] initWithFrame:CGRectMake(33, 20+42*i, 70, 16)];
                temp.textColor=[UIColor colorFromHexCode:@"717272"];
                [backView addSubview:temp];
                
                
                if(i==0){
                    temp.text=@"卡号:";
                    cardNo=[[UITextField alloc] initWithFrame:CGRectMake(90, 10+47*i, UI_SCREEN_WIDTH-90-20, 37)];
                    [cardNo setBorderStyle:UITextBorderStyleRoundedRect]; //外框类型
                    cardNo.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
                    [backView addSubview:cardNo];
                }
                
                if (i==1) {
                    temp.text=@"密码:";
                    passwordTF=[[UITextField alloc] initWithFrame:CGRectMake(90, 5+47*i, UI_SCREEN_WIDTH-90-20, 37)];
                    [passwordTF setBorderStyle:UITextBorderStyleRoundedRect]; //外框类型
                    passwordTF.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
                    [backView addSubview:passwordTF];
                }
                
                
            }

        }
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
