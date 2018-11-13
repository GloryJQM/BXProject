//
//  SelctTab.h
//  chufake
//
//  Created by wuxiaohui on 13-12-31.
//  Copyright (c) 2013年 quanmai. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^topTapBlock)(NSInteger index,NSString *titleStr);

@interface SelctTab : UIView
{
    __strong    topTapBlock _block;
    UIButton* _oldbtn;
}

@property(nonatomic,strong) NSArray         *titleArray;
@property(nonatomic,strong) NSMutableArray  *labelArray;
-(void)btnSelectIndexInSelctTab:(NSInteger)index;
-(void)setTopTapSelectBlock:(topTapBlock) block;
@end
