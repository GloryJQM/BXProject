//
//  NumberView.h
//  SmallCEO
//
//  Created by 任成龙 on 2017/7/31.
//  Copyright © 2017年 lemuji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NumberView : UIView
@property (nonatomic, copy) void (^finishBlock) (NSInteger number);
- (instancetype)initWithFrame:(CGRect)frame finishBlock:(void (^) (NSInteger number))finishBlock;
@property (nonatomic, strong) UITextField *textField;
@end
