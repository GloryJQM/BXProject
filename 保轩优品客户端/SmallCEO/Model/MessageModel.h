//
//  MessageModel.h
//  SmallCEO
//
//  Created by huang on 15/10/15.
//  Copyright (c) 2015年 lemuji. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface MessageModel : NSObject

@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, assign) BOOL isFeedback;

- (instancetype)initMessageModel:(NSDictionary *)dicData;

@end
