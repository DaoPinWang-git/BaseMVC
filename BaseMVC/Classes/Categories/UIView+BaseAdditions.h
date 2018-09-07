//
//  UIView+Additions.h
//  MobileCRM
//
//  Created by wangweishun on 7/22/14.
//  Copyright (c) 2014 wangweishun. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^BackBlockInView)(UIView *view,id obj);

typedef void (^GestureActionBlock)(UIGestureRecognizer *gestureRecoginzer);

@interface UIView (BaseAdditions)

@property (nonatomic,copy) BackBlockInView backBlock;

@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat right;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;

@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;

@property (nonatomic) CGPoint origin;
@property (nonatomic) CGSize size;


@property (nonatomic, readonly) UIViewController *viewController;


- (UIImage *)imageForView;

- (void)addTapActionWithBlock:(GestureActionBlock)block;
- (void)addPaningActionWithBlock:(GestureActionBlock)block;

@end
