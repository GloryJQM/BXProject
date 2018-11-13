//
//  BottomView.h
//  SmallCEO
//
//  Created by 任成龙 on 2017/7/7.
//  Copyright © 2017年 lemuji. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol BottomViewDelegate <NSObject>
- (void)bottomViewIndex:(NSInteger)index titleName:(NSString *)string;
@end

@interface BottomView : UIView
@property (nonatomic, strong) UIButton *collectButton;
@property (nonatomic, strong) UILabel *redPointLabel;
@property (nonatomic, copy) void (^finishBlock)(NSString *titleString);
@property (nonatomic, weak) id <BottomViewDelegate> delegate;
- (instancetype)initWithBlock:(void (^)(NSString *titleString))block is_point_type:(NSInteger)is_point_type;
@property (nonatomic, assign) BOOL isCollect;
@property (nonatomic, copy) NSString *countStr;
@end
