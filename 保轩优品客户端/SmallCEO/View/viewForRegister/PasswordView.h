//
//  PasswordView.h
//  chufake
//
//  Created by wuxiaohui on 13-12-25.
//  Copyright (c) 2013年 quanmai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PasswordView : UIView<UITextFieldDelegate>
{
    SEL _sel;
    id  _target;
}

@property(nonatomic,strong)NSMutableArray       *textArray;
-(void)addPassWordViewSelector:(id)target selector:(SEL)sel;
-(void)removeKeyBoard;
@end
