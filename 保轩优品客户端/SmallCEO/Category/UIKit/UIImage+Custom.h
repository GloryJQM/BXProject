//
//  UIImage+Custom.h
//  hhjr
//
//  Created by csl on 14-11-25.
//  Copyright (c) 2014年 chenweidong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef   enum{
    arrowRight=0,
    arrowLeft,
    arrowTop,
    arrowBottom
}ArrowDirection;

@interface UIImage (Custom)

+(UIImage*)  OriginImage:(UIImage *)image   scaleToSize:(CGSize)size;
+(UIImage*) imageWithColor:(UIColor*)color rect:(CGRect)rect;
+(UIImage *)getImageByURL:(NSString *)url;

+(UIImage *)imageWithArrowWithSize:(CGSize)size  direction:(ArrowDirection)direction lineColor:(UIColor *)color lineWidth:(CGFloat)lineWidth;
+(UIImage *)getPlusOrMinus:(BOOL)isPlus;
-(UIImage*)getSubImage:(CGRect)rect;
- (UIImage *)imageWithColor:(UIColor *)color;
- (UIColor *)colorAtPixel:(CGPoint)point;
+(UIImage *)drawRightArrowWithLength:(CGFloat)fValue  direction:(ArrowDirection)direction;

- (UIImage *) imageWithMinimumSize:(CGSize)size;

@end
