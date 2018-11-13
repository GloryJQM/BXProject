//
//  UIImageView+Touchable.m
//  TouchableImageView
//
//  Created by Johnny on 4/25/14.
//  Copyright (c) 2014 Johnny. All rights reserved.
//

#import "UIView+Target.h"

@implementation UIView (Touchable)

- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
{
    self.userInteractionEnabled = YES;
    UIControl *touchControl = [[UIControl alloc] initWithFrame:self.bounds];
    touchControl.backgroundColor = [UIColor clearColor];
    touchControl.tag=self.tag;
    [self addSubview:touchControl];
    
    [touchControl addTarget:target action:action forControlEvents:controlEvents];
}

@end
