//
//  RequestManager.h
//  SmallCEO
//
//  Created by huang on 15/8/18.
//  Copyright (c) 2015年 lemuji. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFURLConnectionOperation.h"

typedef NS_ENUM(NSUInteger, HttpMethod)
{
    HttpMethodPost,
    HttpMethodGet
};

typedef void(^successBlock)(AFHTTPRequestOperation*, id);
typedef void(^failureBlock)(AFHTTPRequestOperation*, NSError*);

@interface RequestManager : NSObject

@property (nonatomic, assign)HttpMethod method;      //default is post method.

+ (RequestManager*)sharedManager;

+ (void)startRequestWithUrl:(NSString *)url body:(NSString *)body successBlock:(successBlock)sBlock failureBlock:(failureBlock)fBlock;

@end
