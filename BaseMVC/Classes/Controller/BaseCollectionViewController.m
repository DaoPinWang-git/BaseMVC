//
//  BaseCollectionViewController.m
//  QDZ
//
//  Created by dpwong on 2017/9/4.
//  Copyright © 2017年 dpwong. All rights reserved.
//

#import "BaseCollectionViewController.h"
#import "Masonry.h"
#import "BaseConfig.h"
#import "DPNetworking.h"

@interface BaseCollectionViewController ()

@property (nonatomic, strong) UIImage *emptyImage;
@property (nonatomic, copy) NSString *emptyText;

@end

@implementation BaseCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.allowedShowErrorView = YES;
    self.allowedShowEmptyView = YES;


    // Do any additional setup after loading the view.
    self.layout = [[UICollectionViewFlowLayout alloc] init];
    
    //同一行相邻两个cell的最小间距
    if (self.minimumInteritemSpacing == 0) {
        self.minimumInteritemSpacing = 5;
    }
    self.layout.minimumInteritemSpacing = self.minimumInteritemSpacing;
    //最小两行之间的间距
    if (self.minimumLineSpacing == 0) {
        self.minimumLineSpacing = 5;
    }
    self.layout.minimumLineSpacing = self.minimumLineSpacing;
        
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.layout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    
    [promptBGView removeFromSuperview];
    
    [self.collectionView addSubview:promptBGView];
    
    [self registerCellClass];
    self.listArray = [NSMutableArray array];
    
    
    if (CGSizeEqualToSize(self.itemSize, CGSizeZero)) {
        self.itemSize = CGSizeMake((SCREEN_WIDTH - 20 - 5) / 2, (SCREEN_WIDTH - 20 - 5) / 2);
    }
    
    if (UIEdgeInsetsEqualToEdgeInsets(self.sectionInset, UIEdgeInsetsZero)) {
        self.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    }
    self.page = 1;

    
    __weak __typeof(self) wself = self;
    self.collectionView.mj_header = [RefreshHeader headerWithRefreshingBlock:^{
        wself.isNeedRefresh = NO;
        wself.page = 1;
        [wself requestData];
    }];
    
    self.collectionView.mj_footer = [RefreshFooter footerWithRefreshingBlock:^{
        wself.page++;
        [wself requestData];
        
    }];
    

}



- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (self.isNeedRefresh && !self.collectionView.mj_header.hidden) {
        self.isNeedRefresh = NO;
        [self.collectionView.mj_header beginRefreshing];
    }
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.isNeedRefresh = NO;
}


- (void)registerCellClass{
    [self.collectionView registerClass:[BaseCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([BaseCollectionViewCell class])];
    
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionReusableView"];
    
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UICollectionReusableView"];
}

- (void)showEmpty{
    if (self.allowedShowEmptyView){
        ((void(*)(id, SEL, id, id))objc_msgSend)(self, NSSelectorFromString(@"showPrompt:text:"), self.emptyImage, self.emptyText);
    }else{
        promptBGView.hidden = YES;
    }
}


- (void)setEmpty:(UIImage *)image text:(NSString *)text{
    self.emptyText = text;
    self.emptyImage = image;
}

- (void)getListRequest:(NSString *_Nonnull)url
             parameter:(NSDictionary * _Nullable )parameters
                sucess:(nonnull void(^)(id _Nonnull responseObject))sucess
               failure:(nullable void(^)(id _Nonnull error))failure{
    [self getListRequest:url handle:nil parameter:parameters sucess:sucess failure:failure];
}


- (void)getListRequest:(NSString *_Nonnull)url
                handle:(nullable void(^)(DPNetworking *handle))handle
             parameter:(NSDictionary * _Nullable )parameters
                sucess:(nonnull void(^)(id _Nonnull responseObject))sucess
               failure:(nullable void(^)(id _Nonnull error))failure{
    
    
    
    promptBGView.hidden = YES;
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:parameters];
    if (![NSString isHaveValue:dic[@"page"]]) {
        [dic setObject:[NSNumber numberWithInteger:self.page < 1 ? 1 : self.page] forKey:@"page"];
    }
    
    if (![NSString isHaveValue:dic[@"page_size"]]) {
        [dic setObject:@"20" forKey:@"page_size"];
    }

    
    __weak __typeof(self) wself = self;

    [DPNetworking get:url
               handle:handle
           parameters:dic
              success:^(id  _Nonnull responseObject) {
                  __strong __typeof(wself) sself = wself;

                  ((void(*)(id, SEL, id, id))objc_msgSend)(sself, NSSelectorFromString(@"sucess:responseObject:"), sucess, responseObject);

                  [sself.collectionView.mj_header endRefreshing];

                  if (((NSArray *)responseObject).count < 20) {
                      [sself.collectionView.mj_footer endRefreshingWithNoMoreData];
                  }else{
                      [sself.collectionView.mj_footer endRefreshing];
                  }

                  if (sself.page == 1 && ((NSArray *)responseObject).count == 0) {
                      [sself showEmpty];
                  }

              }
              failure:^(id  _Nonnull error) {
                  __strong __typeof(wself) sself = wself;

                  ((void(*)(id, SEL, id, id))objc_msgSend)(sself, NSSelectorFromString(@"failure:error:"), failure, error);
                  [sself.collectionView.mj_header endRefreshing];
                  [sself.collectionView.mj_footer endRefreshing];
              }];

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.listArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    BaseCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([BaseCollectionViewCell class]) forIndexPath:indexPath];
    cell.contentModel = [self.listArray objectAtIndex:indexPath.item];
    return cell;

}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.itemSize;
}



-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return self.sectionInset;
}


- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
