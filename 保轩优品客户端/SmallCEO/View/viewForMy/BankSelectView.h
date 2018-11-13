//
//  BankSelectView.h
//  SmallCEO
//
//  Created by huang on 15/8/26.
//  Copyright (c) 2015年 lemuji. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BankSelectViewDelegate;

@interface BankSelectView : UIView

@property (nonatomic, assign) id<BankSelectViewDelegate> delegate;

+ (BankSelectView *)sharedView;

+ (void)setBankInfoArray:(NSArray *)infoArray;

+ (void)show;

+ (void)dismiss;

@end

@protocol BankSelectViewDelegate <NSObject>

- (void)bankSelectView:(BankSelectView *)view didSelectAtIndex:(NSInteger)index;

@end