//
//  BaseListViewController.m
//  QDZ
//
//  Created by dpwong on 2017/8/25.
//  Copyright © 2017年 dpwong. All rights reserved.
//

#import "BaseListViewController.h"
#import "RefreshHeader.h"
#import "RefreshFooter.h"
#import "BaseTableViewCell.h"
#import "TextCell.h"
#import "DPNetworking.h"

@interface BaseListViewController ()

@property (nonatomic, strong) UIImage *emptyImage;
@property (nonatomic, copy) NSString *emptyText;

@end

@implementation BaseListViewController


- (void)viewDidLoad {
    self.page = 1;

    self.allowedShowErrorView = YES;
    self.allowedShowEmptyView = YES;
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    __weak __typeof(self) wself = self;
    self.tableview.mj_header = [RefreshHeader headerWithRefreshingBlock:^{
        wself.isNeedRefresh = NO;
        wself.page = 1;
        [wself requestData];
    }];
    
    self.tableview.mj_footer = [RefreshFooter footerWithRefreshingBlock:^{
        wself.page++;
        [wself requestData];
        
    }];
    

}


- (void)requestData{
    [self.tableview.mj_header endRefreshing];
    [self.tableview.mj_footer endRefreshing];
}

- (void)needRefresh{
    self.isNeedRefresh = YES;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (self.isNeedRefresh && !self.tableview.mj_header.hidden) {
        self.isNeedRefresh = NO;
        [self.tableview.mj_header beginRefreshing];
    }
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.isNeedRefresh = NO;
}


- (void)registerCellClass{
    [self.tableview registerClass:[BaseTableViewCell class] forCellReuseIdentifier:NSStringFromClass([BaseTableViewCell class])];
    
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
                handle:(void(^)(DPNetworking *handle))handle
             parameter:(NSDictionary * _Nullable )parameters
                sucess:(nonnull void(^)(id _Nonnull responseObject))sucess
               failure:(nullable void(^)(id _Nonnull error))failure{
    

    
    promptBGView.hidden = YES;
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:parameters];
    [dic setObject:[NSNumber numberWithInteger:self.page < 1 ? 1 : self.page] forKey:@"page"];
    [dic setObject:@"20" forKey:@"page_size"];

    
    __weak __typeof(self) wself = self;

    [DPNetworking get:url
               handle:handle
           parameters:dic
              success:^(id  _Nonnull responseObject) {
                  __strong __typeof(wself) sself = wself;

                  ((void(*)(id, SEL, id, id))objc_msgSend)(sself, NSSelectorFromString(@"sucess:responseObject:"), sucess, responseObject);
                  [sself.tableview.mj_header endRefreshing];


                  if ([responseObject isKindOfClass:[NSArray class]]) {
                      if (((NSArray *)responseObject).count < 20) {
                          [sself.tableview.mj_footer endRefreshingWithNoMoreData];
                      }else{
                          [sself.tableview.mj_footer endRefreshing];
                      }
                      if (sself.page == 1 && ((NSArray *)responseObject).count == 0) {
                          [sself showEmpty];
                      }
                  }
              }
              failure:^(id  _Nonnull error) {
                  __strong __typeof(wself) sself = wself;

                  ((void(*)(id, SEL, id, id))objc_msgSend)(sself, NSSelectorFromString(@"failure:error:"), failure, error);
                  [sself.tableview.mj_header endRefreshing];
                  [sself.tableview.mj_footer endRefreshing];
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


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TextCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TextCell class])];
    cell.contentModel = [self.listArray objectAtIndex:indexPath.row];
    return cell;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
