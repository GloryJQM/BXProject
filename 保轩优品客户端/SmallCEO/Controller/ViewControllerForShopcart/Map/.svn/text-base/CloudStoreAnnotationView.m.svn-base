//
//  CloudStoreAnnotationView.m
//  SmallCEO
//
//  Created by huang on 16/4/26.
//  Copyright © 2016年 lemuji. All rights reserved.
//

#import "CloudStoreAnnotationView.h"

@implementation CloudStoreAnnotationView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *hitView = [super hitTest:point withEvent:event];
    if (hitView == nil && self.selected)
    {
        CloudStoreCalloutView *calloutView = self.calloutView;
        CGPoint pointInCalloutView = [self convertPoint:point toView:calloutView];
        hitView = [calloutView hitTest:pointInCalloutView withEvent:event];
    }
    
    return hitView;
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];

    UIView *calloutView = self.calloutView;
    if (selected)
    {
        CGRect annotationViewBounds = self.bounds;
        CGRect calloutViewFrame = calloutView.frame;
        // Center the callout view above and to the right of the annotation view.
        
        calloutViewFrame.origin.x = -(CGRectGetWidth(calloutViewFrame) - CGRectGetWidth(annotationViewBounds)) * 0.5;
        calloutViewFrame.origin.y = -CGRectGetHeight(calloutViewFrame);
        calloutView.frame = calloutViewFrame;
        
        [self addSubview:calloutView];
    }
    else
    {
        [calloutView removeFromSuperview];
    }
}

- (void)dealloc
{
    [self.calloutView removeFromSuperview];
    self.calloutView = nil;
}

@end
