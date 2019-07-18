//
//  BaseCollectionViewController.h
//  QDZ
//
//  Created by dpwong on 2017/9/4.
//  Copyright © 2017年 dpwong. All rights reserved.
//

#import "BaseViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface BaseCollectionViewController : BaseViewController<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionViewFlowLayout *layout;

@property (nonatomic, strong) UICollectionView * _Nonnull collectionView;

/**
 列表数据
 */
@property (nonatomic, strong) NSMutableArray * _Nonnull listArray;

/**
 cell大小
 */
@property (nonatomic, assign) CGSize itemSize;

/**
 到边的距离
 */
@property (nonatomic, assign) UIEdgeInsets sectionInset;

/**
 同一行相邻两个cell的最小间距(在前[super viewDidLoad]赋值，默认5)
 */
@property (nonatomic, assign) CGFloat minimumInteritemSpacing;

/**
 最小两行之间的间距(在前[super viewDidLoad]赋值，默认5)
 */
@property (nonatomic, assign) CGFloat minimumLineSpacing;



/**
 是否需要刷新
 */
@property (nonatomic, assign) BOOL isNeedRefresh;

/**
 注册cell
 */
- (void)registerCellClass;

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
 get(带缓存)
 
 @param url 接口名
 @param handle 对本次请求如有特殊设置，配置handle
 @param parameters 参数
 @param sucess 完成回调
 @param failure 失败回调
 */

- (void)getListRequest:(NSString *_Nonnull)url
                handle:(nullable void(^)(DPNetworking *handle))handle
             parameter:(NSDictionary * _Nullable )parameters
                sucess:(nonnull void(^)(id _Nonnull responseObject))sucess
               failure:(nullable void(^)(id _Nonnull error))failure;



@end
NS_ASSUME_NONNULL_END
