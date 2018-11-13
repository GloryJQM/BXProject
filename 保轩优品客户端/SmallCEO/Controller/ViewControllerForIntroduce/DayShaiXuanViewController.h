//
//  DayShaiXuanViewController.h
//  SmallCEO
//
//  Created by 俊严 on 15/10/16.
//  Copyright (c) 2015年 lemuji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DayShaiXuanViewController : UIViewController
@property (nonatomic, assign)BOOL isClick;

@property (nonatomic,strong) void(^popBlock)(int vcTag);

@property (nonatomic, strong)NSMutableArray * buttonArray;

@property (nonatomic, strong)NSMutableArray * labelArray;

@property (nonatomic, assign)BOOL isFirst;

@property (nonatomic, strong)NSDictionary * dataDic;

@property (nonatomic, strong)NSString * titleStr;

@property (nonatomic, assign)int whichVC;

@property (nonatomic,strong)NSString* date;

@property (nonatomic, assign)int whichShouYiTap;

@property (nonatomic, assign) int timeType;


@property (nonatomic, assign) BOOL isFormSell;
@end
