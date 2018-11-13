//
//  CaptchaView.h
//  chufake
//
//  Created by wuxiaohui on 13-12-25.
//  Copyright (c) 2013年 quanmai. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  CaptchaViewdelegate<NSObject>
-(void)captchagain:(BOOL)againb;
@end

@interface CaptchaView : UIView<UITextFieldDelegate>
{
    UILabel *_timeLabe;
    SEL _sel;
    id  _target;
    int time;
    UITextField *_phoneNumberTextfield;
}


@property (nonatomic, weak) NSTimer *timer;
@property(nonatomic,weak) id<CaptchaViewdelegate>delegate;
-(void)stoptimer;
-(void)timerStar;
-(void)removeKeyBoard;
-(void)addCapchaSelector:(id)target selector:(SEL)sel;

@end
