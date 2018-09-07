//
//  BaseConfig.h
//  AFNetworking
//
//  Created by dpwong on 2018/9/6.
//

#import <Foundation/Foundation.h>

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height


#define UIColorFromValue(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define COLORA(R,G,B,A) [UIColor colorWithRed:(R)/255.0 green:(G)/255.0 blue:(B)/255.0 alpha:A]
#define COLOR(R,G,B) COLORA(R,G,B,1.0)
#define RandomColor COLOR(arc4random() % 255 + 1, arc4random() % 255 + 1, arc4random() % 255 + 1)


@interface BaseConfig : NSObject


/**
 所有全局的配置变量都放入这里
 */
@property (nonatomic, strong) NSMutableDictionary *config;

+ (BaseConfig *)sharedConfig;


/**
NavigationBar 背景颜色
 */
- (void)setNavigationBarBackgroundColor:(UIColor *)color;

- (UIColor *)navigationBarBackgroundColor;

/**
 NavigationBar 文字颜色
 */
- (void)setNavigationBarTextColor:(UIColor *)color;

- (UIColor *)navigationBarTextColor;

/**
 通用View背景颜色
 */
- (void)setViewBackgroundColor:(UIColor *)color;

- (UIColor *)viewBackgroundColor;

/**
 通用线背景颜色
 */
- (void)setCellLineColor:(UIColor *)color;

- (UIColor *)cellLineColor;

@end
