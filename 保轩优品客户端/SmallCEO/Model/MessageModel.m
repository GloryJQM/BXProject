//
//  MessageModel.m
//  SmallCEO
//
//  Created by huang on 15/10/15.
//  Copyright (c) 2015年 lemuji. All rights reserved.
//

#import "MessageModel.h"

@implementation MessageModel

- (instancetype)initMessageModel:(NSDictionary *)dicData
{
    self = [super init];
    if (self != nil)
    {
        self.content = [NSString stringWithFormat:@"%@", [dicData objectForKey:@"content"]];
        self.createTime = [NSString stringWithFormat:@"%@", [dicData objectForKey:@"create_time"]];
        
        NSString *str = [NSString stringWithFormat:@"%@", [dicData objectForKey:@"to"]];
        self.isFeedback = ![str isEqualToString:@"0"];
    }
    
    return self;
}

@end
