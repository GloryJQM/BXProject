//
//  UIImage+Custom.m
//  hhjr
//
//  Created by csl on 14-11-25.
//  Copyright (c) 2014年 chenweidong. All rights reserved.
//

#import "UIImage+Custom.h"


#define UI_SCREEN_WIDTH_UIImage_Custom                 ([[UIScreen mainScreen] bounds].size.width)
#define UI_SCREEN_HEIGHT_UIImage_Custom                ([[UIScreen mainScreen] bounds].size.height)


#define myRgba_UIImage_Custom(r,g,b,a)                  ([UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a])

@implementation UIImage (Custom)
+(UIImage *)imageWithArrowWithSize:(CGSize)size  direction:(ArrowDirection)direction lineColor:(UIColor *)color lineWidth:(CGFloat)lineWidth{
    
    UIGraphicsBeginImageContextWithOptions(size, 0, [UIScreen mainScreen].scale);
    CGFloat width = size.width;
    CGFloat height = size.height;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    //Set the stroke (pen) color
    CGContextSetStrokeColorWithColor(context, color.CGColor);
    //Set the width of the pen mark
    CGContextSetLineWidth(context, lineWidth);
    CGContextSetLineJoin(context, kCGLineJoinRound);
    
    CGFloat gap = lineWidth / 2.0;
    //    CGContextSetShouldAntialias(context, NO);
    switch (direction) {
        case arrowRight:
        {
            CGContextMoveToPoint(context, gap, gap);
            CGContextAddLineToPoint(context, width - gap,height/2.0);
            CGContextAddLineToPoint(context, gap,height -gap);
        }
            break;
        case arrowLeft:
        {
            CGContextMoveToPoint(context, width - gap, gap);
            CGContextAddLineToPoint(context, gap,height/2.0);
            CGContextAddLineToPoint(context, width - gap,height - gap);
        }
            break;
        case arrowBottom:
        {
            CGContextMoveToPoint(context, gap, gap);
            CGContextAddLineToPoint(context, width/2.0,height - gap);
            CGContextAddLineToPoint(context, width - gap,gap);
        }
            break;
        case arrowTop:
        {
            CGContextMoveToPoint(context, gap, height - gap);
            CGContextAddLineToPoint(context, width/2.0,gap);
            CGContextAddLineToPoint(context, width - gap,height - gap);
        }
            break;
            
        default:
            break;
    }
    
    CGContextStrokePath(context);
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
+(UIImage *)getPlusOrMinus:(BOOL)isPlus{
    // NO代表透明
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(30, 30), NO, 0.0);
    // 获得上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(ctx, [UIColor darkGrayColor].CGColor);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    if (isPlus) {
        [path moveToPoint:CGPointMake(15, 10)];
        [path addLineToPoint:CGPointMake(15, 20)];
    }
    [path moveToPoint:CGPointMake(10, 15)];
    [path addLineToPoint:CGPointMake(20, 15)];
    
    path.lineWidth = 2;
    path.lineCapStyle = kCGLineCapRound;
    [path stroke];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
    
}

+(UIImage*)  OriginImage:(UIImage *)image   scaleToSize:(CGSize)size
{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    
    // 绘制改变大小的图片
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    // 返回新的改变大小后的图片
    return scaledImage;
}


+(UIImage*) imageWithColor:(UIColor*)color rect:(CGRect)rect
{
//    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
    
}


- (UIImage *)getSnapshotImage:(UIView *)view {
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(CGRectGetWidth(view.frame), CGRectGetHeight(view.frame)), NO, [UIScreen mainScreen].scale);
    [view drawViewHierarchyInRect:CGRectMake(0, 0, CGRectGetWidth(view.frame), CGRectGetHeight(view.frame)) afterScreenUpdates:NO];
    UIImage *snapshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //    btn.frame=self.view.bounds;
    //    [btn setImage:snapshot forState:UIControlStateNormal];
    
    return snapshot;

}

-(UIImage*)getSubImage:(CGRect)rect
{
    CGImageRef subImageRef = CGImageCreateWithImageInRect(self.CGImage, rect);
    CGRect smallBounds = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));
    
    UIGraphicsBeginImageContext(smallBounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, smallBounds, subImageRef);
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    
    return smallImage;
    
    //另一种方法
//    UIImage *image = [UIImage imageNamed:@"asdf"];
//    CGImageRef imageRef = image.CGImage;
//    
//    CGRect rect1 = CGRectZero;
//    
//    CGImageRef imageRefRect = CGImageCreateWithImageInRect(imageRef, rect1);
//    
//    UIImage *imageRect = [[UIImage alloc] initWithCGImage:imageRefRect];
}



- (UIColor *)colorAtPixel:(CGPoint)point {
    // Cancel if point is outside image coordinates
    if (!CGRectContainsPoint(CGRectMake(0.0f, 0.0f, self.size.width, self.size.height), point)) {
        return nil;
    }
    
    
    // Create a 1x1 pixel byte array and bitmap context to draw the pixel into.
    // Reference: http://stackoverflow.com/questions/1042830/retrieving-a-pixel-alpha-value-for-a-uiimage
    NSInteger pointX = trunc(point.x);
    NSInteger pointY = trunc(point.y);
    CGImageRef cgImage = self.CGImage;
    NSUInteger width = self.size.width;
    NSUInteger height = self.size.height;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    int bytesPerPixel = 4;
    int bytesPerRow = bytesPerPixel * 1;
    NSUInteger bitsPerComponent = 8;
    unsigned char pixelData[4] = { 0, 0, 0, 0 };
    CGContextRef context = CGBitmapContextCreate(pixelData,
                                                 1,
                                                 1,
                                                 bitsPerComponent,
                                                 bytesPerRow,
                                                 colorSpace,
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
    CGContextSetBlendMode(context, kCGBlendModeCopy);
    
    // Draw the pixel we are interested in onto the bitmap context
    CGContextTranslateCTM(context, -pointX, pointY-(CGFloat)height);
    CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, (CGFloat)width, (CGFloat)height), cgImage);
    CGContextRelease(context);
    
    // Convert color values [0..255] to floats [0.0..1.0]
    CGFloat red   = (CGFloat)pixelData[0] / 255.0f;
    CGFloat green = (CGFloat)pixelData[1] / 255.0f;
    CGFloat blue  = (CGFloat)pixelData[2] / 255.0f;
    CGFloat alpha = (CGFloat)pixelData[3] / 255.0f;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}


- (UIImage *)imageWithColor:(UIColor *)color
{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, self.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextClipToMask(context, rect, self.CGImage);
    [color setFill];
    CGContextFillRect(context, rect);
    UIImage*newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+(UIImage *)getImageByURL:(NSString *)url {
    return [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL: [NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]]];
}



-(UIImage *)drawImage{
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(UI_SCREEN_WIDTH_UIImage_Custom, 64), 0, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //Set the stroke (pen) color
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithWhite:0.4 alpha:1.0].CGColor);
    //Set the width of the pen mark
    CGContextSetLineWidth(context, 1.0);
    CGContextMoveToPoint(context, 0.0, 0);
    CGContextAddLineToPoint(context, UI_SCREEN_WIDTH_UIImage_Custom,0);
    CGContextStrokePath(context);
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+(UIImage *)drawRightArrowWithLength:(CGFloat)fValue  direction:(ArrowDirection)direction {
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(fValue, fValue), 0, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //Set the stroke (pen) color
    CGContextSetStrokeColorWithColor(context, myRgba_UIImage_Custom(174, 174, 174, 1).CGColor);
    //Set the width of the pen mark
    CGContextSetLineWidth(context, 1.0);
    switch (direction) {
        case arrowRight:
        {
            CGContextMoveToPoint(context, 0.0, 0);
            CGContextAddLineToPoint(context, fValue/2.0,fValue/2.0);
            CGContextAddLineToPoint(context, 0,fValue);
        }
            break;
        case arrowLeft:
        {
            
        }
            break;
        case arrowBottom:
        {
            
        }
            break;
        case arrowTop:
        {
            
        }
            break;
            
        default:
            break;
    }
    
    CGContextStrokePath(context);
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


- (UIImage *) imageWithMinimumSize:(CGSize)size {
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(size.width, size.height), NO, 0.0f);
    [self drawInRect:rect];
    UIImage *resized = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [resized resizableImageWithCapInsets:UIEdgeInsetsMake(size.height/2, size.width/2, size.height/2, size.width/2)];
}

@end
