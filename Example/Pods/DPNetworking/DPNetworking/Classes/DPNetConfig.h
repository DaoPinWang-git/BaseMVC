//
//  DPNetConfig.h
//  DPNetworing
//
//  Created by dpwong on 2018/1/23.
//  Copyright © 2018年 dpwong. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN


typedef BOOL(^DPNetSuccessBlock)(NSURLSessionDataTask * task, id  _Nullable responseObject);

typedef BOOL(^DPNetFailureBlock)(NSURLSessionDataTask * _Nullable task, NSError * error);


@interface DPNetConfig : NSObject

/**
 baseURL
 */
@property (nonatomic, copy) NSString *baseURL;

/**
 请求头部信息
 */
@property (nonatomic, copy) NSDictionary *HTTPHeaderDic;

/**
 请求超时时长（默认30s）
 */
@property (nonatomic, assign) NSTimeInterval timeoutInterval;

/**
 返回内容类型
 */
@property (nonatomic, copy, nullable) NSSet <NSString *> *acceptableContentTypes;

/**
 是否允许无效证书（也就是自建的证书），默认为NO
 如果是需要验证自建证书，需要设置为YES
 */
@property (nonatomic, assign) BOOL allowInvalidCertificates;

/**
是否需要验证域名，默认为YES；
 假如证书的域名与你请求的域名不一致，需把该项设置为NO；
 置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；
 如置为NO，建议自己添加对应域名的校验逻辑。
  */
@property (nonatomic, assign) BOOL validatesDomainName;

/**
 证书路径
 */
@property (nonatomic, copy) NSArray<NSString *> *cerPaths;

/**
 统一成功回调（如果需要继续往下执行返回YES）
 */
@property (nonatomic,copy, nullable) DPNetSuccessBlock successBlock;

/**
 统一失败回调（如果需要继续往下执行返回YES）
 */
@property (nonatomic,copy, nullable) DPNetFailureBlock failureBlock;



/**
 单例
 
 @return DPNetConfig
 */
+ (DPNetConfig *)sharedManager;


@end

NS_ASSUME_NONNULL_END

