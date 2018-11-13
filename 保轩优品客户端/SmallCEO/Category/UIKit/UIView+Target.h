//
//  UIImageView+Touchable.h
//  TouchableImageView
//
//  Created by Johnny on 4/25/14.
//  Copyright (c) 2014 Johnny. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Touchable)

- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

@end
