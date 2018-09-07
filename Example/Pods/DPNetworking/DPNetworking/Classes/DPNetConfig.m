//
//  DPNetConfig.m
//  DPNetworing
//
//  Created by dpwong on 2018/1/23.
//  Copyright © 2018年 dpwong. All rights reserved.
//

#import "DPNetConfig.h"

@implementation DPNetConfig


+ (DPNetConfig *)sharedManager{
    static DPNetConfig *handle = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        handle = [[DPNetConfig alloc] init];
        handle.timeoutInterval = 30.f;
    });
    
    return handle;
}

@end
