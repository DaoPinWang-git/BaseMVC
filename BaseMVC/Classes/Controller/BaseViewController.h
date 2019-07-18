//
//  BaseViewController.h
//  QDZ
//
//  Created by dpwong on 2017/8/24.
//  Copyright © 2017年 dpwong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class DPNetworking;
/**

 @param vc 自身
 @param obj 返回的数据
 */
typedef void(^BackBlock)(UIViewController * _Nonnull vc,id _Nullable obj);


@interface BaseViewController : UIViewController{
    UIView *promptBGView;
    UIImageView *promptImageView;
    UILabel *promptText;

}

/**
 是否显示出错界面
 */
@property (nonatomic, assign) BOOL allowedShowErrorView;

/**
 是否显示空数据界面
 */
@property (nonatomic, assign) BOOL allowedShowEmptyView;

/**
 返回给上一层ViewController数据（可以为空）

 */
@property (nonatomic, copy) BackBlock _Nullable backBlock;

/**
 是否是第一次进入这个UIViewController
 */
@property (nonatomic, assign, readonly) BOOL isFirst;


/**
 显示出错界面
 */
- (void)showError;

/**
 设置出错界面
 */
- (void)setError:(UIImage *_Nullable)image text:(NSString *_Nullable)text;

/**
 网络请求
 */
- (void)requestData;


/**
 get

 @param url 接口名
 @param parameters 参数
 @param sucess 完成回调
 @param failure 失败回调
 */
- (void)getRequest:(NSString *_Nonnull)url
         parameter:(id _Nullable )parameters
            sucess:(nonnull void(^)(id _Nonnull responseObject))sucess
           failure:(nullable void(^)(id _Nonnull error))failure;


/**
 get

 @param handle 对本次请求如有特殊设置，配置handle
 */
- (void)getRequest:(NSString *_Nonnull)url
            handle:(nullable void(^)(DPNetworking *handle))handle
         parameter:(id _Nullable )parameters
            sucess:(nonnull void(^)(id _Nonnull responseObject))sucess
           failure:(nullable void(^)(id _Nonnull error))failure;

/**
 post

 @param url 接口名
 @param parameters 参数
 @param sucess 完成回调
 @param failure 失败回调
 */
- (void)postRequest:(NSString *_Nonnull)url
          parameter:(id _Nullable )parameters
             sucess:(nonnull void(^)(id _Nonnull responseObject))sucess
            failure:(nullable void(^)(id _Nonnull error))failure;

/**
 post

 @param handle 对本次请求如有特殊设置，配置handle
 */
- (void)postRequest:(NSString *_Nonnull)url
             handle:(nullable void(^)(DPNetworking *handle))handle
          parameter:(id _Nullable )parameters
             sucess:(nonnull void(^)(id _Nonnull responseObject))sucess
            failure:(nullable void(^)(id _Nonnull error))failure;

/**
 patch

 @param url 接口名
 @param parameters 参数
 @param sucess 完成回调
 @param failure 失败回调
 */
- (void)patchRequest:(NSString *_Nonnull)url
           parameter:(id _Nullable )parameters
              sucess:(nonnull void(^)(id _Nonnull responseObject))sucess
             failure:(nullable void(^)(id _Nonnull error))failure;

/**
 patch

 @param handle 对本次请求如有特殊设置，配置handle
 */
- (void)patchRequest:(NSString *_Nonnull)url
              handle:(nullable void(^)(DPNetworking *handle))handle
           parameter:(id _Nullable )parameters
              sucess:(nonnull void(^)(id _Nonnull responseObject))sucess
             failure:(nullable void(^)(id _Nonnull error))failure;

/**
 put

 @param url 接口名
 @param parameters 参数
 @param sucess 完成回调
 @param failure 失败回调
 */
- (void)putRequest:(NSString *_Nonnull)url
         parameter:(id _Nullable )parameters
            sucess:(nonnull void(^)(id _Nonnull responseObject))sucess
           failure:(nullable void(^)(id _Nonnull error))failure;
/**
 put

 @param handle 对本次请求如有特殊设置，配置handle
 */
- (void)putRequest:(NSString *_Nonnull)url
            handle:(nullable void(^)(DPNetworking *handle))handle
         parameter:(id _Nullable )parameters
            sucess:(nonnull void(^)(id _Nonnull responseObject))sucess
           failure:(nullable void(^)(id _Nonnull error))failure;

/**
 delete

 @param url 接口名
 @param parameters 参数
 @param sucess 完成回调
 @param failure 失败回调
 */
- (void)delRequest:(NSString *_Nonnull)url
         parameter:(id _Nullable )parameters
            sucess:(nonnull void(^)(id _Nonnull responseObject))sucess
           failure:(nullable void(^)(id _Nonnull error))failure;

/**
 delete

 @param handle 对本次请求如有特殊设置，配置handle
 */
- (void)delRequest:(NSString *_Nonnull)url
            handle:(nullable void(^)(DPNetworking *handle))handle
         parameter:(id _Nullable )parameters
            sucess:(nonnull void(^)(id _Nonnull responseObject))sucess
           failure:(nullable void(^)(id _Nonnull error))failure;
@end

NS_ASSUME_NONNULL_END
