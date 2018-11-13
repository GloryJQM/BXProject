//
//  TimeDetailTableViewCell.m
//  gongfubao
//
//  Created by chensanli on 15/6/5.
//  Copyright (c) 2015年 quanmai. All rights reserved.
//

#import "TimeDetailTableViewCell.h"

@implementation TimeDetailTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        return self;
    }
    return nil;
}

-(void)upDataWith:(int)year andMonth:(int)month delegate:(id<RiliViewDelegate>)delegate :(NSDictionary *)dic withStep:(BOOL)isStep
{
    if(self.rlVi!=nil ){
        [self.rlVi removeFromSuperview];
        self.rlVi=nil;
    }

    self.rlVi = [[RiLiView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 44*5) andYear:year andMonth:month :dic withStep:isStep];
    
    self.rlVi.delegate=delegate;
    [self addSubview:self.rlVi];
}




@end
