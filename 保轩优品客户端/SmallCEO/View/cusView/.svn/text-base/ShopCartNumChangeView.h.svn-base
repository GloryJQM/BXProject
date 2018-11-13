//
//  ShopCartNumChangeView.h
//  Lemuji
//
//  Created by quanmai on 15/7/16.
//  Copyright (c) 2015年 quanmai. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ShopCartNumChangeViewDelegate <NSObject>

-(void)changeNumWithString:(NSString *)num;

@end

@interface ShopCartNumChangeView : UIView

@property(nonatomic,assign) id<ShopCartNumChangeViewDelegate> delegate;
@property(nonatomic,strong) UITextField *textF;
@property(nonatomic,assign) int canBuyNum;
-(void)setInitialText:(NSString *)num;

-(NSString *)getNewNum;

@end
