//
//  RiLiView.h
//  gongfubao
//
//  Created by chensanli on 15/6/5.
//  Copyright (c) 2015年 quanmai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DateOut.h"

@protocol RiliViewDelegate;


@interface RiLiView : UIView

@property(nonatomic,assign) id<RiliViewDelegate> delegate;
@property (nonatomic,strong)DateOut* date;
@property (nonatomic,strong)UILabel* dateLab;
@property (nonatomic,strong)UILabel* timeLab;
@property (nonatomic,assign)int all;
@property (nonatomic,assign)int RfirstDay;
@property (nonatomic,strong)NSMutableArray* arrDay;
@property (nonatomic,strong)NSMutableArray* arrTime;



-(instancetype)initWithFrame:(CGRect)frame andYear:(int)year andMonth:(int)month :(NSDictionary *)dic withStep:(BOOL)isStep;
@end

@protocol RiliViewDelegate <NSObject>

-(void)giveUp:(long)date work:(float)workTime;

@end



