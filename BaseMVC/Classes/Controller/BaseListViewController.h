//
//  BaseListViewController.h
//  QDZ
//
//  Created by dpwong on 2017/8/25.
//  Copyright © 2017年 dpwong. All rights reserved.
//

#import "BaseDetailsViewController.h"

@interface BaseListViewController : BaseDetailsViewController


/**
 是否需要刷新
 */
@property (nonatomic, assign) BOOL isNeedRefresh;

/**
 显示空数据界面
 */
- (void)showEmpty;

/**
 设置空数据界面
 */
- (void)setEmpty:(UIImage *_Nullable)image text:(NSString *_Nullable)text;

/**
 页数
 */
@property (nonatomic, assign) NSInteger page;



/**
 get
 
 @param url 接口名
 @param parameters 参数
 @param sucess 完成回调
 @param failure 失败回调
 */
- (void)getListRequest:(NSString *_Nonnull)url
             parameter:(NSDictionary * _Nullable )parameters
                sucess:(nonnull void(^)(id _Nonnull responseObject))sucess
               failure:(nullable void(^)(id _Nonnull error))failure;


/**
 get(带缓存)，缓存只返回第一页的数据
 
 @param url 接口名
 @param handle 对本次请求如有特殊设置，配置handle
 @param parameters 参数
 @param sucess 完成回调
 @param failure 失败回调
 */
- (void)getListRequest:(NSString *_Nonnull)url
                handle:(void(^)(DPNetworking *handle))handle
             parameter:(NSDictionary * _Nullable )parameters
                sucess:(nonnull void(^)(id _Nonnull responseObject))sucess
               failure:(nullable void(^)(id _Nonnull error))failure;


@end
