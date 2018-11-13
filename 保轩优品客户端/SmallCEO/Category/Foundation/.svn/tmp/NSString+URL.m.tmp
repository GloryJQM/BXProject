//
//  NSString+URL.m
//  MobileInsurance
//
//  Created by Cai on 14-7-30.
//  Copyright (c) 2014年 jiang. All rights reserved.
//

#import "NSString+URL.h"

@implementation NSString(URL)

- (NSString *)URLEncodedString
{
    NSString *encodedValue = (NSString*)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                (CFStringRef)self, nil,
                                                                                (CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8));
    return encodedValue;
}


@end
