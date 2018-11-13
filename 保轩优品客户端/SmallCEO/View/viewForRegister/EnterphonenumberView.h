//
//  EnterphonenumberView.h
//  chufake
//
//  Created by wuxiaohui on 13-12-25.
//  Copyright (c) 2013年 quanmai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FUIButton.h"

@protocol EnterphonenumberViewDelegate <NSObject>

@optional


- (void)showServiceWeb;


@end


@interface EnterphonenumberView : UIView<UITextFieldDelegate>
{
    id  _target;
    SEL _sel;
    UITextField *_phoneNumberTextfield;
    UITextField *_recommendTextfield;
    BOOL agreeBool;
    FUIButton*btn;//获取验证码按钮
    UIView *bottomView;//底部视图
    UIButton *noBtn;//没有邀请码按钮
    UIButton *haveBtn;//有邀请码按钮
}
@property UITextField *_recommendTextfield;
@property(nonatomic,assign) id<EnterphonenumberViewDelegate> delegate;
-(void)addEnterPhonenumberSelect:(id)target selector:(SEL)sel;
-(void)removeKeyBoard;


@end
