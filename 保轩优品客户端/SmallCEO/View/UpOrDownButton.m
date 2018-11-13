//
//  UpOrDownButton.m
//  SmallCEO
//
//  Created by nixingfu on 16/1/4.
//  Copyright © 2016年 lemuji. All rights reserved.
//

#import "UpOrDownButton.h"

@implementation UpOrDownButton

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.rightView = [[UIImageView alloc]  init];
        CGFloat off = 0;
        if (IS_IPHONE4 || IS_IPHONE5) {
            off = 25;
        }else {
            off = 35;
        }
        self.rightView.frame = CGRectMake(UI_SCREEN_WIDTH/3.0-off, 17, 9, 5);
        [self addSubview:self.rightView];
        
        
        self.titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, UI_SCREEN_WIDTH/3.0-off, 20)];
        self.titleLab.font = [UIFont systemFontOfSize:14];
        self.titleLab.textAlignment = NSTextAlignmentCenter;
        self.titleLab.textColor = [UIColor colorFromHexCode:@"373737"];
        [self addSubview:self.titleLab];
        
    }
    return self;
}
@end
