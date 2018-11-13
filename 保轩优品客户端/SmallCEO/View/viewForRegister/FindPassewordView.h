//
//  FindPassewordView.h
//  WanHao
//
//  Created by Lai on 14-4-17.
//  Copyright (c) 2014年 wuxiaohui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FindPassewordView : UIView<UITextFieldDelegate>
{
    SEL _sel;
    id  _target;
}

@property(nonatomic,strong)NSMutableArray       *textArray;
-(void)addPassWordViewSelector:(id)target selector:(SEL)sel;
-(void)removeKeyBoard;
@end
