//
//  ShareView.h
//  Lemuji
//
//  Created by Cai on 15-8-4.
//  Copyright (c) 2015年 quanmai. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ShareViewDelegate;

@interface ShareView : UIView

@property (nonatomic, weak) id<ShareViewDelegate> delegate;

- (instancetype)initWithShareButtonNameArray:(NSArray *)nameArray animation:(BOOL)animation;

- (void)show;

@end

@protocol ShareViewDelegate <NSObject>

- (void)shareView:(ShareView *)shareView clickButtonAtIndex:(NSInteger)index;

@end
