//
//  ItemListView.h
//  WanHao
//
//  Created by wuxiaohui on 14-2-11.
//  Copyright (c) 2014年 wuxiaohui. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ItemListView;
@protocol ItemListViewDelegate <NSObject>

-(NSInteger)numberOfRowsInItemListView:(ItemListView *)itemListView;
-(CGFloat)ItemListView:(ItemListView *)itemListView widthOfRows:(NSInteger)index;
-(CGFloat)ItemListView:(ItemListView *)itemListView heightOfRows:(NSInteger)index;
-(UIView *)ItemListView:(ItemListView *)itemListView viewOfRows:(NSInteger)index;
-(void)ItemListView:(ItemListView *)itemListView didSelectRowAtIndex:(NSInteger)index;

@end

@interface ItemListView : UIView<UIScrollViewDelegate>

@property (weak)        id<ItemListViewDelegate> delegate;

@property (nonatomic,strong) UIScrollView *scrollView;

-(void)reladListView;

@end
