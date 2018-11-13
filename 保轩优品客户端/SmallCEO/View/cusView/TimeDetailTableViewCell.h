//
//  TimeDetailTableViewCell.h
//  gongfubao
//
//  Created by chensanli on 15/6/5.
//  Copyright (c) 2015年 quanmai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RiLiView.h"

@interface TimeDetailTableViewCell : UITableViewCell

@property (nonatomic,strong)RiLiView* rlVi;

-(void)upDataWith:(int)year andMonth:(int)month delegate:(id<RiliViewDelegate>)delegate :(NSDictionary *)dic withStep:(BOOL)isStep;

@end
