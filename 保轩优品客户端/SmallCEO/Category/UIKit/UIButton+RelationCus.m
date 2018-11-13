//
//  UIButton+RelationCus.m
//  WanHao
//
//  Created by quanmai on 15/6/18.
//  Copyright (c) 2015年 wuxiaohui. All rights reserved.
//

#import "UIButton+RelationCus.h"
#import <objc/runtime.h>

@implementation UIButton(RelationCus)

-(void)setRelateBtn:(UIButton *)relateBtn{
//    self.relateBtn=relateBtn;
    objc_setAssociatedObject(self, @selector(relateBtn), relateBtn, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIButton *)relateBtn{
    return objc_getAssociatedObject(self, @selector(relateBtn));
//    return self.relateBtn;
}

@end

@implementation UIButton(TryOutButton)

-(void)setTryOutType:(TryOutButtonType)buttonType
{
    objc_setAssociatedObject(self, @selector(tryOutType), [NSNumber numberWithInteger:buttonType], OBJC_ASSOCIATION_ASSIGN);
}

-(TryOutButtonType)tryOutType{
    return [objc_getAssociatedObject(self, @selector(tryOutType)) integerValue];
}

@end

@implementation UIButton(GroupBuyButton)

-(void)setGroupBuyType:(GroupBuyButtonType)groupBuyType
{
    objc_setAssociatedObject(self, @selector(groupBuyType), [NSNumber numberWithInteger:groupBuyType], OBJC_ASSOCIATION_ASSIGN);
}

-(GroupBuyButtonType)groupBuyType{
    return [objc_getAssociatedObject(self, @selector(groupBuyType)) integerValue];
}

-(void)setActionBlock:(dispatch_block_t)actionBlock{
    objc_setAssociatedObject(self, @selector(actionBlock), actionBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(dispatch_block_t)actionBlock{
    return objc_getAssociatedObject(self, @selector(actionBlock));
}

-(void)addControlblock:(dispatch_block_t)block forControlEvents:(UIControlEvents)controlEvents{
    self.actionBlock=block;
    [self addTarget:self action:@selector(actionDid) forControlEvents:controlEvents];
}

-(void)actionDid{
    self.actionBlock();
}

@end


@implementation UITextField(RelationCus)


-(void)setHideStatus:(NSString *)hideStatus{
    objc_setAssociatedObject(self, @selector(hideStatus), hideStatus, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(NSString *)hideStatus{
    return  objc_getAssociatedObject(self, @selector(hideStatus));
}


@end
