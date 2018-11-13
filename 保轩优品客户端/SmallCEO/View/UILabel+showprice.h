//
//  UIlabel+showprice.h
//  chufake
//
//  Created by pan on 13-12-18.
//  Copyright (c) 2013年 quanmai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (showprice)

@property (nonatomic ) float price;

+ (NSString *)formatPrice:(float)price;

@end



@interface NSString (cos)

-(float)stringWidth;

@end
