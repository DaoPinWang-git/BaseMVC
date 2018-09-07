//
//  BaseViewController.m
//  QDZ
//
//  Created by dpwong on 2017/8/24.
//  Copyright © 2017年 dpwong. All rights reserved.
//

#import "BaseViewController.h"
#import "NSString+BaseAdditions.h"
#import "Masonry.h"
#import "UIView+BaseAdditions.h"
#import "MBProgressHUD+BaseAdd.h"
#import "BaseConfig.h"
#import "DPNetworking.h"


@interface BaseViewController ()


//@property (nonatomic, strong) UIImageView *promptImageView;
//@property (nonatomic, strong) UILabel *promptText;


@property (nonatomic, strong) UIImage *errorImage;
@property (nonatomic, copy) NSString *errorText;


@end

@implementation BaseViewController
@synthesize isFirst = _isFirst;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    promptBGView = [[UIView alloc] init];
    promptBGView.backgroundColor = [UIColor whiteColor];
    promptBGView.hidden = YES;
    [self.view addSubview:promptBGView];

    self.view.backgroundColor = [[BaseConfig sharedConfig] viewBackgroundColor];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;

    _isFirst = YES;
}


- (BOOL)isFirst{
    
    BOOL b = _isFirst;
    
    return b;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.isFirst) {
        [self requestData];
    }
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (0.1*1000ull) *NSEC_PER_MSEC),dispatch_get_main_queue(), ^{
        self->_isFirst = NO;
    });
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

}

- (void)setAllowedShowEmptyView:(BOOL)allowedShowEmptyView{
    _allowedShowEmptyView = allowedShowEmptyView;
    
    if (!allowedShowEmptyView) {
        promptBGView.hidden = YES;
    }
}

- (void)requestData{
    
}




- (void)showError{
    [self showPrompt:self.errorImage text:self.errorText];
}

- (void)setError:(UIImage *)image text:(NSString *)text{
    self.errorText = text;
    self.errorImage = image;
}


- (void)showPrompt:(UIImage *)image text:(NSString *)text{
    
    if (image == nil || ![NSString isHaveValue:text]) {
        return;
    }
    [promptBGView.superview addSubview:promptBGView];
    promptBGView.hidden = NO;
    promptBGView.frame = CGRectMake(0, 0, promptBGView.superview.width, promptBGView.superview.height);
    
//    [promptBGView mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(promptBGView.superview);
//    }];

    
    [promptImageView removeFromSuperview];
    [promptText removeFromSuperview];
    
    

    
    promptImageView = [[UIImageView alloc] init];
    //    promptImageView.backgroundColor = RandomColor;
    [promptBGView addSubview:promptImageView];
    
    
    promptText = [[UILabel alloc] init];
    promptText.textAlignment = NSTextAlignmentCenter;
    promptText.numberOfLines = 0;
    promptText.textColor = [UIColor blackColor];
    [promptBGView addSubview:promptText];
    
    
    promptImageView.image = image;
    promptText.text = text;
    
    CGFloat th = [promptText sizeThatFits:CGSizeMake(self.view.width - 40, MAXFLOAT)].height;
    
    
    
    [promptText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self->promptBGView).offset(20);
        make.right.equalTo(self->promptBGView).offset(-20);
        make.height.mas_equalTo(th);
//        if (UI_IS_IPAD) {
//            make.centerY.equalTo(promptBGView).offset(40);
//        }else{
            if (SCREEN_HEIGHT > 480) {
                make.centerY.equalTo(self->promptBGView).offset(-10);
            }else{
                make.centerY.equalTo(self->promptBGView).offset(40);
            }
//        }

        

    }];
    
    
    [promptImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self->promptBGView);
        make.size.mas_equalTo(image.size);
        make.bottom.equalTo(self->promptText.mas_top).offset(-65);
    }];
    
    
    [promptBGView layoutIfNeeded];
}


- (void)sucess:(nonnull void(^)(id _Nonnull responseObject))sucess responseObject:(id)responseObject{
    [MBProgressHUD hideWait:self.view];
    
    sucess(responseObject);
    
}

- (void)failure:(nullable void(^)(id _Nonnull error))failure error:(id)error{
    [MBProgressHUD hideWait:self.view];
    
//    if (appDelegate.status == AFNetworkReachabilityStatusNotReachable) {
//        if (self.allowedShowErrorView){
//            [self setError:[UIImage imageNamed:@"empty_img_internet"] text:@"网络竟然崩溃了"];
//            [self showError];
//        }else{
//            [MBProgressHUD showMessage:@"网络竟然崩溃了"];
//        }
//        return;
//    }

    if (failure) {
        failure(error);
    }else{
        NSError *e = (NSError*)error;
        /// 本地自定义错误
//        if (e.code == LocalErrorCode) {
//            [MBProgressHUD showMessage:e.domain];
//            return;
//        }

        
        NSData *errorData = e.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
        if (errorData) {
            NSDictionary *serializedData = [NSJSONSerialization JSONObjectWithData: errorData options:kNilOptions error:nil];
            NSString *customCode = serializedData[@"customCode"];
            
            if (![customCode isKindOfClass:[NSNull class]] && [customCode integerValue] == 403) {
                return;
            }
            
            [MBProgressHUD showMessage:[NSString stringWithFormat:@"%@",[serializedData objectForKey:@"message"]]];
        }else{
            if (self.allowedShowErrorView){
                [self setError:[UIImage imageNamed:@"empty_img_server"] text:@"服务器竟然制障了"];
                [self showError];
            }else{
                [MBProgressHUD showMessage:@"服务器竟然制障了"];
                
            }
        }
        
        
    }
}



- (void)getRequest:(NSString *_Nonnull)url
         parameter:(id _Nullable )parameters
            sucess:(nonnull void(^)(id _Nonnull responseObject))sucess
           failure:(nullable void(^)(id _Nonnull error))failure{
    [self getRequest:url handle:nil parameter:parameters sucess:sucess failure:failure];
}

- (void)getRequest:(NSString *_Nonnull)url
            handle:(void(^)(DPNetworking *handle))handle
         parameter:(id _Nullable )parameters
            sucess:(nonnull void(^)(id _Nonnull responseObject))sucess
           failure:(nullable void(^)(id _Nonnull error))failure{
    [self.view endEditing:YES];

    [MBProgressHUD showWait:self.view];
    promptBGView.hidden = YES;

    __weak __typeof(self) wself = self;

    [DPNetworking get:url
               handle:handle
           parameters:parameters
              success:^(id  _Nonnull responseObject) {
                  __strong __typeof(wself) sself = wself;

                  [sself sucess:sucess responseObject:responseObject];
              }
              failure:^(id  _Nonnull error) {
                  __strong __typeof(wself) sself = wself;

                  [sself failure:failure error:error];
              }];

}


- (void)postRequest:(NSString *_Nonnull)url
          parameter:(id _Nullable )parameters
             sucess:(nonnull void(^)(id _Nonnull responseObject))sucess
            failure:(nullable void(^)(id _Nonnull error))failure{
    [self postRequest:url
               handle:nil
            parameter:parameters
               sucess:sucess
              failure:failure];
}

- (void)postRequest:(NSString *_Nonnull)url
             handle:(void(^)(DPNetworking *handle))handle
          parameter:(id _Nullable )parameters
             sucess:(nonnull void(^)(id _Nonnull responseObject))sucess
            failure:(nullable void(^)(id _Nonnull error))failure{
    [self.view endEditing:YES];

    [MBProgressHUD showWait:self.view];
    
    promptBGView.hidden = YES;
    
    __weak __typeof(self) wself = self;

    [DPNetworking post:url
                handle:handle
            parameters:parameters
               success:^(id  _Nonnull responseObject) {
                   __strong __typeof(wself) sself = wself;

                   [sself sucess:sucess responseObject:responseObject];
               }
               failure:^(id  _Nonnull error) {
                   __strong __typeof(wself) sself = wself;

                   [sself failure:failure error:error];
               }];

}

- (void)patchRequest:(NSString *_Nonnull)url
          parameter:(id _Nullable )parameters
             sucess:(nonnull void(^)(id _Nonnull responseObject))sucess
            failure:(nullable void(^)(id _Nonnull error))failure{
    [self patchRequest:url
                handle:nil
             parameter:parameters
                sucess:sucess
               failure:failure];
}

- (void)patchRequest:(NSString *_Nonnull)url
              handle:(void(^)(DPNetworking *handle))handle
           parameter:(id _Nullable )parameters
              sucess:(nonnull void(^)(id _Nonnull responseObject))sucess
             failure:(nullable void(^)(id _Nonnull error))failure{
    [self.view endEditing:YES];

    [MBProgressHUD showWait:self.view];

    promptBGView.hidden = YES;

    __weak __typeof(self) wself = self;

    [DPNetworking patch:url
                 handle:handle
             parameters:parameters
                success:^(id  _Nonnull responseObject) {
                    __strong __typeof(wself) sself = wself;

                    [sself sucess:sucess responseObject:responseObject];
                }
                failure:^(id  _Nonnull error) {
                    __strong __typeof(wself) sself = wself;

                    [sself failure:failure error:error];
                }];

}


- (void)putRequest:(NSString *_Nonnull)url
         parameter:(id _Nullable )parameters
            sucess:(nonnull void(^)(id _Nonnull responseObject))sucess
           failure:(nullable void(^)(id _Nonnull error))failure{
    [self putRequest:url
              handle:nil
           parameter:parameters
              sucess:sucess
             failure:failure];
}

- (void)putRequest:(NSString *_Nonnull)url
            handle:(void(^)(DPNetworking *handle))handle
         parameter:(id _Nullable )parameters
            sucess:(nonnull void(^)(id _Nonnull responseObject))sucess
           failure:(nullable void(^)(id _Nonnull error))failure{
    [self.view endEditing:YES];

    [MBProgressHUD showWait:self.view];

    promptBGView.hidden = YES;

    __weak __typeof(self) wself = self;

    [DPNetworking put:url
               handle:handle
           parameters:parameters
              success:^(id  _Nonnull responseObject) {
                  __strong __typeof(wself) sself = wself;

                  [sself sucess:sucess responseObject:responseObject];
              }
              failure:^(id  _Nonnull error) {
                  __strong __typeof(wself) sself = wself;

                  [sself failure:failure error:error];
              }];

}


- (void)delRequest:(NSString *_Nonnull)url
         parameter:(id _Nullable )parameters
            sucess:(nonnull void(^)(id _Nonnull responseObject))sucess
           failure:(nullable void(^)(id _Nonnull error))failure{
    [self delRequest:url
              handle:nil
           parameter:parameters
              sucess:sucess
             failure:failure];
}

- (void)delRequest:(NSString *_Nonnull)url
            handle:(void(^)(DPNetworking *handle))handle
         parameter:(id _Nullable )parameters
            sucess:(nonnull void(^)(id _Nonnull responseObject))sucess
           failure:(nullable void(^)(id _Nonnull error))failure{
    [self.view endEditing:YES];

    [MBProgressHUD showWait:self.view];

    promptBGView.hidden = YES;

    __weak __typeof(self) wself = self;

    [DPNetworking del:url
               handle:handle
           parameters:parameters
              success:^(id  _Nonnull responseObject) {
                  __strong __typeof(wself) sself = wself;

                  [sself sucess:sucess responseObject:responseObject];
              }
              failure:^(id  _Nonnull error) {
                  __strong __typeof(wself) sself = wself;

                  [sself failure:failure error:error];
              }];

}

- (void)dealloc
{
    
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
