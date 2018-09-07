# DPNetworking

[![CI Status](http://img.shields.io/travis/413655409@qq.com/DPNetworking.svg?style=flat)](https://travis-ci.org/413655409@qq.com/DPNetworking)
[![Version](https://img.shields.io/cocoapods/v/DPNetworking.svg?style=flat)](http://cocoapods.org/pods/DPNetworking)
[![License](https://img.shields.io/cocoapods/l/DPNetworking.svg?style=flat)](http://cocoapods.org/pods/DPNetworking)
[![Platform](https://img.shields.io/cocoapods/p/DPNetworking.svg?style=flat)](http://cocoapods.org/pods/DPNetworking)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

DPNetworking is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "DPNetworking"
```

## Usage

### Quick to use
```ruby
#import "DPNetworking.h"


  // 单例  只需要配置一次
    /************** 以下只是举例，请根据自身需要配置 **************/
    // 通用网络请求设置
    DPNetConfig *config = [DPNetConfig sharedManager];

    // 设置baseRUL
    config.baseURL = @"http://api.xxxx.com/app/";
    
    // 设置通用的头部信息
    config.HTTPHeaderDic = @{@"token" : @"xxxxxxxx", @"versions" : @"1.0.0"};
    
    // 设置返回格式
    config.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"application/json", @"text/jaon" ,@"text/javascript",@"text/html", nil];
    
    // 设置通用的请求失败处理
    config.failureBlock = ^BOOL(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSError *e = (NSError*)error;
        NSData *errorData = e.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
        if (errorData) {
            NSDictionary *serializedData = [NSJSONSerialization JSONObjectWithData: errorData options:kNilOptions error:nil];
            // 如判断token是否失效
            if ([serializedData[@"code"] integerValue] == 1010) {
                NSLog(@"token 失效");
                return NO;
            }
            NSLog(@"\n error:%@ \n ******************** \n URL:%@",serializedData, error.userInfo[@"NSErrorFailingURLKey"]);
        }
        return YES;
    };
    
    /******************************************************/

    
    [DPNetworking get:@"xxxx"
               handle:^(DPNetworking * _Nonnull handle) {
                   // 如果对本次请求需要什么特殊设置，可以在此处设置
                   handle.requestSerializer.timeoutInterval = 15.f;
                   [handle.requestSerializer setValue:@"1" forHTTPHeaderField:@"status"];
               }
           parameters:@{@"key" : @"value"}
              success:^(id responseObject) {
                  
              }
              failure:^(id error) {
                  
              }];

```



## Author
dpwong, 413655409@qq.com

## License

DPNetworking is available under the MIT license. See the LICENSE file for more info.
