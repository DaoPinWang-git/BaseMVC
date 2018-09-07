//
//  DPNetworking.m
//  DPNetworing
//
//  Created by dpwong on 2018/1/18.
//  Copyright © 2018年 dpwong. All rights reserved.
//

#import "DPNetworking.h"
#import "NSDictionary+DPReplacingNulls.h"

@implementation DPNetworking

+ (DPNetworking *)manager{
    
    DPNetConfig *config = [DPNetConfig sharedManager];
    
    DPNetworking *handle = [[DPNetworking alloc] initWithBaseURL:[NSURL URLWithString:config.baseURL]];
    handle.requestSerializer = [AFJSONRequestSerializer serializer];
    handle.requestSerializer.timeoutInterval = config.timeoutInterval;
    for (NSString *key in config.HTTPHeaderDic.allKeys) {
        [handle.requestSerializer setValue:config.HTTPHeaderDic[key] forHTTPHeaderField:key];
    }
    
    handle.responseSerializer.acceptableContentTypes = config.acceptableContentTypes;
    
    if (config.cerPaths.count > 0) {
        [handle setSecurityPolicy:[DPNetworking customSecurityPolicy]];
    }
    
    return handle;
}

+ (AFSecurityPolicy*)customSecurityPolicy {
    DPNetConfig *config = [DPNetConfig sharedManager];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];

    securityPolicy.allowInvalidCertificates = config.allowInvalidCertificates;
    
    securityPolicy.validatesDomainName = config.validatesDomainName;
    
    NSMutableSet *set = [NSMutableSet set];
    
    for (NSString *cerPath in config.cerPaths) {
        [set addObject:[NSData dataWithContentsOfFile:cerPath]];
    }
    
    securityPolicy.pinnedCertificates = set;
    
    return securityPolicy;
}



+ (void)success:(void (^)(id responseObject))success task:(NSURLSessionDataTask *)task responseObject:(id)responseObject{
    
    if (success) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            success([(NSDictionary *)responseObject dictionaryByReplacingNullsWithBlanks]);
        }else if ([responseObject isKindOfClass:[NSArray class]]){
            success([(NSArray *)responseObject arrayByReplacingNullsWithBlanks]);
        }else{
            success(responseObject);
        }
        return;
    }
    DPNetConfig *config = [DPNetConfig sharedManager];
    
    if (config.successBlock) {
        config.successBlock(task, responseObject);
        
    }
    
}


+ (void)failure:(void (^)(id error))failure task:(NSURLSessionDataTask *)task error:(NSError *)error{
    if (failure) {
        failure(error);
        return;
    }
    
    DPNetConfig *config = [DPNetConfig sharedManager];
    if (config.failureBlock) {
        config.failureBlock(task, error);
    }
    
}

//get 请求

+ (void)get:(NSString *)url
 parameters:(id)parameters
    success:(void (^)(id responseObject))success
    failure:(void (^)(id error))failure{
    [DPNetworking get:url handle:nil parameters:parameters success:success failure:failure];
}


+ (void)get:(NSString *)url
     handle:(void(^)(DPNetworking *handle))handle
 parameters:(id)parameters
    success:(void(^)(id responseObject))success
    failure:(void(^)(id error))failure{
    
    DPNetworking *networking= [DPNetworking manager];
    
    if (handle) {
        handle(networking);
    }
    
    [networking GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [DPNetworking success:success task:task responseObject:responseObject];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [DPNetworking failure:failure task:task error:error];
        
    }];
}

//post 请求
+ (void)post:(NSString *)url
  parameters:(id)parameters
     success:(void (^)(id responseObject))success
     failure:(void (^)(id error))failure{
    [DPNetworking post:url handle:nil parameters:parameters success:success failure:failure];
}

+ (void)post:(NSString *)url
      handle:(void(^)(DPNetworking *handle))handle
  parameters:(id)parameters
     success:(void (^)(id responseObject))success
     failure:(void (^)(id error))failure{
    
    
    DPNetworking *networking= [DPNetworking manager];
    
    if (handle) {
        handle(networking);
    }
    
    [networking POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [DPNetworking success:success task:task responseObject:responseObject];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [DPNetworking failure:failure task:task error:error];
        
    }];
}

//patch 请求

+ (void)patch:(NSString *)url
   parameters:(id)parameters
      success:(void (^)(id responseObject))success
      failure:(void (^)(id error))failure{
    [DPNetworking patch:url handle:nil parameters:parameters success:success failure:failure];
}

+ (void)patch:(NSString *)url
       handle:(void(^)(DPNetworking *handle))handle
   parameters:(id)parameters
      success:(void (^)(id responseObject))success
      failure:(void (^)(id error))failure{
    
    DPNetworking *networking= [DPNetworking manager];
    
    if (handle) {
        handle(networking);
    }
    
    [networking PATCH:url parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [DPNetworking success:success task:task responseObject:responseObject];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [DPNetworking failure:failure task:task error:error];
        
    }];
}

//put 请求
+ (void)put:(NSString *)url
 parameters:(id)parameters
    success:(void (^)(id responseObject))success
    failure:(void (^)(id error))failure{
    [DPNetworking put:url handle:nil parameters:parameters success:success failure:failure];
}

+ (void)put:(NSString *)url
     handle:(void(^)(DPNetworking *handle))handle
 parameters:(id)parameters
    success:(void (^)(id responseObject))success
    failure:(void (^)(id error))failure{
    
    DPNetworking *networking= [DPNetworking manager];
    
    if (handle) {
        handle(networking);
    }
    
    [networking PUT:url parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [DPNetworking success:success task:task responseObject:responseObject];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [DPNetworking failure:failure task:task error:error];
        
    }];
}

//delete 请求
+ (void)del:(NSString *)url
 parameters:(id)parameters
    success:(void (^)(id responseObject))success
    failure:(void (^)(id error))failure{
    [DPNetworking del:url handle:nil parameters:parameters success:success failure:failure];
    
}

+ (void)del:(NSString *)url
     handle:(void(^)(DPNetworking *handle))handle
 parameters:(id)parameters
    success:(void (^)(id responseObject))success
    failure:(void (^)(id error))failure{
    
    DPNetworking *networking= [DPNetworking manager];
    
    if (handle) {
        handle(networking);
    }
    
    [networking DELETE:url parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [DPNetworking success:success task:task responseObject:responseObject];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [DPNetworking failure:failure task:task error:error];
        
    }];
}

@end

