//
//  AlertLab.h
//  Mylng
//
//  Created by 马强 on 16/7/14.
//  Copyright © 2016年 马强. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AlertLabDelegate <NSObject>

-(void)alertViewRemoveAction;

@end

@interface AlertLab : UILabel

@property(nonatomic,strong)NSTimer *timer;
@property (nonatomic , assign) CGFloat time;
@property (nonatomic , copy) NSString *type;


@property(nonatomic,weak)id<AlertLabDelegate>delegate;
@property (nonatomic, copy) void (^success)(void);

-(instancetype)initWithFrame:(CGRect)frame AndTitle:(NSString*)title;

- (void)show;

- (instancetype)initWithTitle:(NSString *)title Success:(void (^)(void))success;
- (instancetype)initWithTitle:(NSString *)title;

+ (void)showTitle:(NSString *)title;

@end
