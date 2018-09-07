//
//  DPNetworking.h
//  HealthApp
//
//  Created by dpwong on 2018/1/18.
//  Copyright © 2018年 dpwong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "DPNetConfig.h"


NS_ASSUME_NONNULL_BEGIN

@interface DPNetworking : AFHTTPSessionManager


/**
 get请求
 
 @param url 接口名
 @param parameters 参数
 @param success 成功返回block
 @param failure 失败返回block
 */
+ (void)get:(NSString *)url
 parameters:(nullable id)parameters
    success:(void(^)(id responseObject))success
    failure:(nullable void(^)(id error))failure;


/**
 get请求
 
 @param url 接口名
 @param handle 本次请求的主体，如果需要单独添加配置，可以在这里配置
 @param parameters 参数
 @param success 成功返回block
 @param failure 失败返回block
 */
+ (void)get:(NSString *)url
     handle:(nullable void(^)(DPNetworking *handle))handle
 parameters:(nullable id)parameters
    success:(void(^)(id responseObject))success
    failure:(nullable void(^)(id error))failure;



/**
 post请求
 
 @param url 接口名
 @param parameters 参数
 @param success 成功返回block
 @param failure 失败返回block
 */

+ (void)post:(NSString *)url
  parameters:(nullable id)parameters
     success:(void(^)(id responseObject))success
     failure:(nullable void(^)(id error))failure;


/**
 post请求
 
 @param url 接口名
 @param handle 本次请求的主体，如果需要单独添加配置，可以在这里配置
 @param parameters 参数
 @param success 成功返回block
 @param failure 失败返回block
 */

+ (void)post:(NSString *)url
      handle:(nullable void(^)(DPNetworking *handle))handle
  parameters:(nullable id)parameters
     success:(void(^)(id responseObject))success
     failure:(nullable void(^)(id error))failure;

/**
 patch请求
 
 @param url 接口名
 @param parameters 参数
 @param success 成功返回block
 @param failure 失败返回block
 */
+ (void)patch:(NSString *)url
   parameters:(nullable id)parameters
      success:(void(^)(id responseObject))success
      failure:(nullable void(^)(id error))failure;


/**
 patch请求
 
 @param url 接口名
 @param handle 本次请求的主体，如果需要单独添加配置，可以在这里配置
 @param parameters 参数
 @param success 成功返回block
 @param failure 失败返回block
 */

+ (void)patch:(NSString *)url
       handle:(nullable void(^)(DPNetworking *handle))handle
   parameters:(nullable id)parameters
      success:(void(^)(id responseObject))success
      failure:(nullable void(^)(id error))failure;


/**
 put请求
 
 @param url 接口名
 @param parameters 参数
 @param success 成功返回block
 @param failure 失败返回block
 */
+ (void)put:(NSString *)url
 parameters:(nullable id)parameters
    success:(void(^)(id responseObject))success
    failure:(void(^)(id error))failure;


/**
 put请求
 
 @param url 接口名
 @param handle 本次请求的主体，如果需要单独添加配置，可以在这里配置
 @param parameters 参数
 @param success 成功返回block
 @param failure 失败返回block
 */

+ (void)put:(NSString *)url
     handle:(nullable void(^)(DPNetworking *handle))handle
 parameters:(nullable id)parameters
    success:(void(^)(id responseObject))success
    failure:(nullable void(^)(id error))failure;

/**
 delete请求
 
 @param url 接口名
 @param parameters 参数
 @param success 成功返回block
 @param failure 失败返回block
 */
+ (void)del:(NSString *)url
 parameters:(nullable id)parameters
    success:(void(^)(id responseObject))success
    failure:(nullable void(^)(id error))failure;


/**
 del请求
 
 @param url 接口名
 @param handle 本次请求的主体，如果需要单独添加配置，可以在这里配置
 @param parameters 参数
 @param success 成功返回block
 @param failure 失败返回block
 */

+ (void)del:(NSString *)url
     handle:(nullable void(^)(DPNetworking *handle))handle
 parameters:(nullable id)parameters
    success:(void(^)(id responseObject))success
    failure:(nullable void(^)(id error))failure;


@end


NS_ASSUME_NONNULL_END

