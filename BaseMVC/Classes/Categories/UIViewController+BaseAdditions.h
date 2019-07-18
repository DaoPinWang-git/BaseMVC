//
//  UIViewController+Custom.h
//  MobileCRM
//
//  Created by wangweishun on 7/23/14.
//  Copyright (c) 2014 wangweishun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (BaseAdditions)

/**
 *  title自定义，不调用back方法，支持左滑退出
 *
 */
- (void)setBackBarButtonItemWithTitle:(NSString *)title;

- (void)setBackBarButtonItemWithImage:(UIImage *)image;

- (void)back;


- (void)setLeftBarButtonWithTitle:(NSString *)title action:(SEL)action;

- (void)setLeftBarButtonWithImage:(UIImage *)image action:(SEL)action;

- (void)setLeftBarButtonWithImage:(UIImage *)image title:(NSString *)title action:(SEL)action;

- (void)setRightBarButtonWithTitle:(NSString *)title action:(SEL)action;

- (void)setRightBarButtonWithImage:(UIImage *)image action:(SEL)action;

- (void)setRightBarButtonWithImage:(UIImage *)image title:(NSString *)title action:(SEL)action;


- (void)showMsg:(NSString *)title msg:(NSString *)msg butTitle:(NSString *)butTitle handler:(void (^)(UIAlertAction *action))handler;
- (void)showMsgWithTwoButs:(NSString *)title
                       msg:(NSString *)msg
              leftbutTitle:(NSString *)butTitle
             rightbutTitle:(NSString *)rightbutTitle
               leftHandler:(void (^)(UIAlertAction *action))leftHandler
                   handler:(void (^)(UIAlertAction *action))handler;

- (void)customNavigationBar;
- (void)defaultNavigationBar;
- (void)delNavBarBottomLine;
- (void)recoverNavBarBottomLine;

@end
