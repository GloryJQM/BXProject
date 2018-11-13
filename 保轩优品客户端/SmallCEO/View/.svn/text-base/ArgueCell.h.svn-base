//
//  ArgueCell.h
//  SmallCEO
//
//  Created by XuMengFan on 15/11/8.
//  Copyright © 2015年 lemuji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "argueView.h"

@class ArgueModel;

//@protocol ArgueCellDelegate <NSObject>
//
//@optional
//- (void)getCellNewData:(NSArray *)dataArray objecte:(id)cell;
//- (void)getNewModel:(ArgueModel *)model objecte:(id)cell;
//
//@end


@interface ArgueCell : UITableViewCell

//@property (nonatomic, assign) id<ArgueCellDelegate>delegate;

//给初始cell上的控件赋值
//- (void)assignmentWithArray:(NSArray *)array;
- (void)assignmentWithModel:(ArgueModel *)model;

//得到cell上的空间值
//- (NSArray *)getAllControllersValueOnCell;
- (ArgueModel *)getCellModel;


@property (nonatomic, strong) argueView * argueView;
@end
