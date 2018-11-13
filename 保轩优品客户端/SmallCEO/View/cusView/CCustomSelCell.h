//
//  CCustomSelCell.h
//  WanHao
//
//  Created by Cai on 15-1-6.
//  Copyright (c) 2015年 wuxiaohui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCustomSelCell : UITableViewCell
{
    UILabel         *_titleLab;
    UILabel         *_linelab;
}

-(void)reloadData:(NSString *)title;
-(void)lineIsDisappear:(BOOL)isDisappear;

@end
