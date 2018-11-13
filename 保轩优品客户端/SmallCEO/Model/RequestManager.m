//
//  RequestManager.m
//  SmallCEO
//
//  Created by huang on 15/8/18.
//  Copyright (c) 2015年 lemuji. All rights reserved.
//

#import "RequestManager.h"

@implementation RequestManager

+ (RequestManager*)sharedManager
{
    static dispatch_once_t once;
    static RequestManager *sharedManager;
    dispatch_once(&once, ^{
        sharedManager = [[RequestManager alloc] init];
        sharedManager.method = HttpMethodPost;
    });
    return sharedManager;
}

+ (void)startRequestWithUrl:(NSString *)url body:(NSString *)body successBlock:(successBlock)sBlock failureBlock:(failureBlock)fBlock
{
    TokenURLRequest *request = [[TokenURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    NSString *httpMethod = [RequestManager sharedManager].method == HttpMethodPost ? @"POST" : @"GET";
    [request setHTTPMethod:httpMethod];
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    if (fBlock == nil)
    {
        [operation setCompletionBlockWithSuccess:sBlock failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [SVProgressHUD showErrorWithStatus:@"网络错误"];
        }];
    }
    else
    {
        [operation setCompletionBlockWithSuccess:sBlock failure:fBlock];
    }
    [operation start];
}

@end
