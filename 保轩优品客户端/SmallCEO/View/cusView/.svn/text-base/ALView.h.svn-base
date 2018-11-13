//
//  ALView.h
//  gongfubao
//
//  Created by chensanli on 15/6/30.
//  Copyright (c) 2015年 quanmai. All rights reserved.
//
#define ATM_APPEAR [UIView beginAnimations:nil context:UIGraphicsGetCurrentContext()];\
[UIView setAnimationDuration:

#define UI_SCREEN_WIDTH                 ([[UIScreen mainScreen] bounds].size.width)
#define UI_SCREEN_HEIGHT                ([[UIScreen mainScreen] bounds].size.height)

//#define BLUE_COLOR [UIColor colorFromHexCode:@"fc554c"]
//
//#define WHITE_COLOR [UIColor colorFromHexCode:@"FFFFFF"]

#define TIILE_COLOR [UIColor colorFromHexCode:@"111111"]

#import <UIKit/UIKit.h>

@protocol ALDelegate <NSObject>

-(void)sureClick :(NSString*)str;

-(void)clickBtn;

@end

@interface ALView : UIView
@property (nonatomic,assign)id delegate;
@property (nonatomic,strong)UIWindow* win;
@property (nonatomic,assign)BOOL animation;
@property (nonatomic,strong)UITextField* textFleld;
@property (nonatomic,assign)float y;

-(instancetype)initWithCancelBtnTitle:(NSString *)cancelBtnTitle andSureBtn:(NSString *)sureBtnTitle andTitle:(NSString *)title andMessage:(NSString *)message orPlaceholder:(NSString*) placeholder andIsPwd:(BOOL)isPwd Animation:(BOOL)animation;

-(instancetype)initWithCancelBtnTitle:(NSString*)cancelBtnTitle andSureBtn:(NSString*)sureBtnTitle andTitle:(NSString*)title andMsgView:(UIView*)msgView isAnimation:(BOOL)animation;

-(void)cancelClick;

-(void)goInWindow;
@end
