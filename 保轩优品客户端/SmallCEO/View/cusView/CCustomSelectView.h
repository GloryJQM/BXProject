//
//  CCustomSelectView.h
//  WanHao
//
//  Created by Cai on 15-1-6.
//  Copyright (c) 2015年 wuxiaohui. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CCustomSelectView;

@protocol CCustomSelectViewDelegate <NSObject>

-(void)CCustomSelectViewCellDidSelect:(int)cellindex customview:(CCustomSelectView *)selView;
@optional
-(void)CCustomSelectViewCancel;
-(void)CCustomSelectViewCancelWithIndex:(NSInteger)selTag;

@end

@interface CCustomSelectView : UIView<UITableViewDataSource,UITableViewDelegate>
{
    UITableView     *_contentTable;
    NSMutableArray  *_conArr;
    
}

@property(nonatomic,assign)id <CCustomSelectViewDelegate> ccselViewDelegate;
- (id)initWithFrame:(CGRect)frame content:(NSArray *)arr;
-(void)updataUIWithArr:(NSArray *)arr title:(NSString *)t;
-(void)tableUpdateData:(NSArray *)contenArr;

@end
