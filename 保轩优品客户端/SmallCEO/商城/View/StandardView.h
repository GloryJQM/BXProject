//
//  StandardView.h
//  SmallCEO
//
//  Created by 任成龙 on 2017/7/10.
//  Copyright © 2017年 lemuji. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol StandardViewDelegate <NSObject>
- (void)standardTitleStr:(NSString *)titleStr goods_id:(NSString *)goods_id goods_num:(NSInteger)goods_num attr_id:(NSString *)attr_id;
@end
@interface StandardView : UIView
@property (nonatomic, weak) id <StandardViewDelegate> delegate;
- (instancetype)initWithDic:(NSDictionary *)dataDic title:(NSString *)titleStr goods_id:(NSString *)goods_id;
@property (nonatomic, assign) NSInteger number;

@property (nonatomic, strong) NSMutableDictionary *buttonDic;

@end
