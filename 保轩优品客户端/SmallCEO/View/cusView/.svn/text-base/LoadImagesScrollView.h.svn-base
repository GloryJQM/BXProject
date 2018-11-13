//
//  LoadImagesScrollView.h
//  Lemuji
//
//  Created by quanmai on 15/7/27.
//  Copyright (c) 2015年 quanmai. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LoadImagesScrollViewDelegate <NSObject>

- (void)gameOver;

@end

@interface LoadImagesScrollView : UIScrollView

@property(nonatomic,strong) NSMutableArray  *imageUrlArr;
@property(nonatomic,strong) NSMutableArray  *contentUrlArr;
@property(nonatomic,strong) NSMutableArray *downImageArr;
@property (nonatomic, weak) id <LoadImagesScrollViewDelegate> loadDelegate;
- (void)addImageToScrollView:(int)index;
@end
