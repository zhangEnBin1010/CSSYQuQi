//
//  HttpRequest.m
//  Vista
//
//  Created by JackWong on 15/9/30.
//  Copyright (c) 2015年 HX. All rights reserved.
//

#import "HttpRequest.h"
#import "AFHTTPRequestOperationManager.h"
@implementation HttpRequest

+ (void)getWithURL:(NSString *)url sucess:(AFSuccessCall)sucess failure:(AFFailCall)failure
{
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        sucess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}
+ (void)postWithURL:(NSString *)url parameters:(NSDictionary *)para sucess:(AFSuccessCall)sucess failure:(AFFailCall)failure
{
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",@"text/json", @"text/javascript",@"text/plain",nil];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        sucess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}
+ (void)setNetIndicator:(BOOL)bo
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:bo];
}


@end
