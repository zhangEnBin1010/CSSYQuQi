//
//  HttpRequest.h
//  Vista
//
//  Created by JackWong on 15/9/30.
//  Copyright (c) 2015年 HX. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^AFSuccessCall)(id responseObject);
typedef void(^AFFailCall)(id error);

@interface HttpRequest : NSObject

//get方式网络请求
+(void)getWithURL:(NSString *)url sucess:(AFSuccessCall)sucess failure:(AFFailCall)failure;

//post方式网络请求
+(void)postWithURL:(NSString *)url parameters:(NSDictionary *)para sucess:(AFSuccessCall)sucess failure:(AFFailCall)failure;
//设置网络请求  设置网络是否是正在请求状态
+(void)setNetIndicator:(BOOL)bo;


@end
