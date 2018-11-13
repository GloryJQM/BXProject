//
//  PutInView.h
//  Lemuji
//
//  Created by chensanli on 15/7/14.
//  Copyright (c) 2015年 quanmai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PutInView : UIView
@property (nonatomic,strong)NSMutableArray* textFArray;
@property (nonatomic,strong)UITextField* phoneNumTf;
@property (nonatomic,strong)UITextField* passWordTf;
@property (nonatomic,strong)UITextField* surePwdTf;
@property (nonatomic,strong)UITextField* twoCodeTf;
@property (nonatomic,strong)UITextField* yaoQingCodeTf;

-(instancetype)initWithFrame:(CGRect)frame and:(NSArray*)array;

-(void)setPlaceHolders:(NSArray *)arr;

@end
