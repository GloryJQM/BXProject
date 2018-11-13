//
//  RCLAFNetworking.m
//  SmallCEO
//
//  Created by 任成龙 on 2017/6/29.
//  Copyright © 2017年 lemuji. All rights reserved.
//

#import "RCLAFNetworking.h"

@implementation RCLAFNetworking
+ (void)postWithUrl:(NSString *)url BodyString:(NSString *)bodyStr isPOST:(BOOL)isPost success:(void (^)(id responseObject))success fail:(void (^)(NSError *error))failure {
    [SVProgressHUD show];
    NSString *urlStr = MOBILE_SERVER_URL(url);
    TokenURLRequest *request = [[TokenURLRequest alloc] initWithURL:[NSURL URLWithString:urlStr]];
    if (isPost) {
        [request setHTTPMethod:@"POST"];
    }else {
        [request setHTTPMethod:@"GET"];
    }
    [request setHTTPBody:[bodyStr dataUsingEncoding:NSUTF8StringEncoding]];
    
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([url isEqualToString:@"payOrderApiNew.php"]) {
            if (success) {
                success(responseObject);
            }
            return;
        }
        if ([[responseObject objectForKey:@"is_success"] intValue] == 1) {
            if (success) {
                success(responseObject);
            }
            [SVProgressHUD dismiss];
        }else if ([[responseObject objectForKey:@"status"] intValue] == 1){
            [SVProgressHUD dismiss];
            if (success) {
                success(responseObject);
            }
        }else {
            if ([responseObject valueForKey:@"info"]!=nil) {
                [SVProgressHUD showSuccessWithStatus:[responseObject valueForKey:@"info"]] ;
            }else{
                [SVProgressHUD showSuccessWithStatus:@"网络错误"] ;
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
        [SVProgressHUD showErrorWithStatus:@"网络错误"];
    }];
    [op start];
}

+ (void)noSVPPostWithUrl:(NSString *)url BodyString:(NSString *)bodyStr success:(void (^)(id responseObject))success fail:(void (^)(NSError *error))failure {
    NSString *urlStr = MOBILE_SERVER_URL(url);
    TokenURLRequest *request = [[TokenURLRequest alloc] initWithURL:[NSURL URLWithString:urlStr]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[bodyStr dataUsingEncoding:NSUTF8StringEncoding]];
    
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([[responseObject objectForKey:@"is_success"] intValue] == 1) {
            if (success) {
                success(responseObject);
            }
        }else if ([[responseObject objectForKey:@"status"] intValue] == 1){
            if (success) {
                success(responseObject);
            }
        }else {
            if ([responseObject valueForKey:@"info"]!=nil) {
                [SVProgressHUD showCorrectWithStatus:[responseObject valueForKey:@"info"]];
            }else{
                [SVProgressHUD showErrorWithStatus:@"网络错误"];
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
        [SVProgressHUD showErrorWithStatus:@"网络错误"];
    }];
    [op start];
}
@end
