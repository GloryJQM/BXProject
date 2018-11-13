//
//  XHDatePickerView.h
//  XHDatePicker
//
//  Created by 江欣华 on 16/8/16.
//  Copyright © 2016年 江欣华. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface XHDatePickerView : UIView


@property (nonatomic,strong)UIColor *themeColor;
@property (nonatomic, retain) NSDate *maxLimitDate;//限制最大时间（没有设置默认2049）
@property (nonatomic, retain) NSDate *minLimitDate;//限制最小时间（没有设置默认1970）
@property (nonatomic, assign) NSInteger type;
-(instancetype)initWithCompleteBlock:(void(^)(NSDate *))completeBlock andType:(NSInteger) type;

-(void)show;


@end
