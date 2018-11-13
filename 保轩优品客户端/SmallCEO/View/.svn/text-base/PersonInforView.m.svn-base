//
//  PersonInforView.m
//  Lemuji
//
//  Created by gaojun on 15-7-16.
//  Copyright (c) 2015年 quanmai. All rights reserved.
//

#import "PersonInforView.h"

@implementation PersonInforView

-(instancetype)initWithFrame:(CGRect)frame
{

    self = [super initWithFrame:frame];
    if (self) {
        self.informationLabel = [[UILabel alloc] initWithFrame:CGRectMake(13, 13, 70, 20)];
        self.informationLabel.textColor = SUB_TITLE;
        [self addSubview:self.informationLabel];
        
        self.informationField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.informationLabel.frame), self.informationLabel.frame.origin.y, 200, 20)];
        _informationField.textColor = SUB_TITLE;
        [self addSubview:_informationField];
        
        self.line = [[UIView alloc] initWithFrame:CGRectMake(14, 38, UI_SCREEN_WIDTH - 28, 1)];
        _line.backgroundColor = [UIColor colorFromHexCode:@"e8e8e8"];
        [self addSubview:_line];
        
    }
    return self;
}



@end
