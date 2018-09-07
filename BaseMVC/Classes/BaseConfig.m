//
//  BaseConfig.m
//  AFNetworking
//
//  Created by dpwong on 2018/9/6.
//

#import "BaseConfig.h"

static BaseConfig *config = nil;

@implementation BaseConfig

+ (BaseConfig *)sharedConfig{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        config = [[BaseConfig alloc] init];
    });
    return config;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        self.config = [NSMutableDictionary dictionary];
    }
    return self;
}



/**
 NavigationBar 背景颜色
 */
- (void)setNavigationBarBackgroundColor:(UIColor *)color{
    self.config[@"BaseNavigationBarBackgroundColor"] = color;
}

- (UIColor *)navigationBarBackgroundColor{
    UIColor *color = self.config[@"BaseNavigationBarBackgroundColor"];
    if (color == nil) {
        color = [UIColor whiteColor];
    }
    return color;
}

/**
 NavigationBar 文字颜色
 */
- (void)setNavigationBarTextColor:(UIColor *)color{
    self.config[@"BaseNavigationBarTextColor"] = color;
}

- (UIColor *)navigationBarTextColor{
    UIColor *color = self.config[@"BaseNavigationBarTextColor"];
    if (color == nil) {
        color = [UIColor whiteColor];
    }
    return color;
}

/**
 通用View背景颜色
 */
- (void)setViewBackgroundColor:(UIColor *)color{
    self.config[@"BaseViewBackgroundColor"] = color;
}

- (UIColor *)viewBackgroundColor{
    UIColor *color = self.config[@"BaseViewBackgroundColor"];
    if (color == nil) {
        color = [UIColor whiteColor];
    }
    return color;
}

/**
 通用线背景颜色
 */
- (void)setCellLineColor:(UIColor *)color{
    self.config[@"BaseCellLineColor"] = color;
}

- (UIColor *)cellLineColor{
    UIColor *color = self.config[@"BaseCellLineColor"];
    if (color == nil) {
        color = [UIColor whiteColor];
    }
    return color;
}

@end
