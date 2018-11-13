//
//  HomeCusViewItem.h
//  WanHao
//
//  Created by csl on 14-12-11.
//  Copyright (c) 2014年 wuxiaohui. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HomeCusViewItemDelegate <NSObject>


-(void)gotoGoodsList:(int)type linkvale:(NSString *)lValue title:(NSString *)keyword;

@optional
-(void)gotoTheme:(UIButton *)btn;
-(void)addItem:(UIButton *)btn;

@end

@interface HomeCusViewItem : UIView{
    UIScrollView *_itemScrollView;
    NSDictionary *itemDic;
}

@property(nonatomic,assign) id<HomeCusViewItemDelegate> delegate;


-(id)initWithFrame:(CGRect)frame  dataDic:(NSDictionary *)dic;

//更新UI数据
-(void)initUI:(NSDictionary *)_appDit;


@end
