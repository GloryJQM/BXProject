//
//  UIlabel+showprice.m
//  chufake
//
//  Created by pan on 13-12-18.
//  Copyright (c) 2013年 quanmai. All rights reserved.
//

#import "UILabel+showprice.h"
#import <objc/runtime.h>

static char UIB_PROPERTY_KEY;

@implementation UILabel (showprice)
@dynamic price;

+ (NSString *)formatPrice:(float)price;
{
    NSString *str;
    float f = fmod(price, 1);
    if (f > 0) {
        str = [NSString stringWithFormat:@"¥%.2f",price];
    }else{
        str = [NSString stringWithFormat:@"¥%.0f",price];
    }
    return str;
}

- (void)setPrice:(float)price
{
    objc_setAssociatedObject(self, &UIB_PROPERTY_KEY, @(price), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.text = [UILabel formatPrice:price];
}



- (float)price
{
    return [objc_getAssociatedObject(self, &UIB_PROPERTY_KEY) floatValue];
}




@end

@implementation NSString (cos)

-(float)stringWidth{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    UIFont *font=[UIFont systemFontOfSize:17];
    NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
    //    CGSize labelSize = [self boundingRectWithSize:CGSizeMake(FLT_MAX, FLT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    CGSize labelSize ;
    if (C_IOS7) {
        labelSize = [self boundingRectWithSize:CGSizeMake(FLT_MAX, FLT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    }else{
        labelSize = [self sizeWithFont:font constrainedToSize:CGSizeMake(FLT_MAX,FLT_MAX) lineBreakMode:NSLineBreakByCharWrapping];
    }
    
    return labelSize.width;
}

@end
