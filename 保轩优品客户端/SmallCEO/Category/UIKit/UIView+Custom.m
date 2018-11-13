//
//  UIView+Custom.m
//  DeKang
//
//  Created by quanmai on 16/3/30.
//  Copyright © 2016年 quanmai. All rights reserved.
//

#import "UIView+Custom.h"

@implementation UIView (Custom)

-(void)addLineWithHorizontalNum:(NSInteger)horiNo verticalNum:(NSInteger)vertiNO{
    CGFloat horizontalWidth = self.frame.size.width / horiNo;
    CGFloat verticalHight = self.frame.size.height / vertiNO;
    for (NSInteger i = 1; i < horiNo; i ++) {
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(horizontalWidth * i, 0, 0.5, self.frame.size.height)];
        line.backgroundColor = [UIColor grayColor];
        [self addSubview:line];
    }
    
    for (NSInteger i = 1; i < vertiNO ; i ++) {
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, verticalHight * i, self.frame.size.width, 0.5)];
        line.backgroundColor = [UIColor grayColor];
        [self addSubview:line];
    }
}


-(NSArray *)getSubViewsWithViewClass:(Class)theClass{
    NSMutableArray *viewArray = [[NSMutableArray alloc] initWithCapacity:0];
    for (NSInteger i = 0; i < self.subviews.count; i ++) {
        UIView *view = [self.subviews objectAtIndex:i];
//        if (view.userInteractionEnabled == NO) {
//            break;
//        }
        if ([view isKindOfClass:theClass]) {
            [viewArray addObject:view];
        }else{
            NSArray *array = [view getSubViewsWithViewClass:theClass];
            if (array.count != 0) {
                [viewArray addObjectsFromArray:array];
            }
        }
    }
    return viewArray;
}

@end
