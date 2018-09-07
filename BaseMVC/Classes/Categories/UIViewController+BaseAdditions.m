//
//  UIViewController+Custom.m
//  MobileCRM
//
//  Created by wangweishun on 7/23/14.
//  Copyright (c) 2014 wangweishun. All rights reserved.
//

#import "UIViewController+BaseAdditions.h"
#import "BaseConfig.h"
#import "UIButton+DPTitlePostionType.h"
#import "UIImage+BaseAdditions.h"

/**
 * 自定义导航栏BarButtonItem的高度
 */
#define kCustomBarButtonItemH 40

/**
 * 自定义导航栏BarButtonItem的偏移量
 */
#define kCustomLeftBarButtonItemEdgeInset -15



@interface BarButton : UIButton

@end


@implementation BarButton

- (CGSize)intrinsicContentSize {
    return UILayoutFittingExpandedSize;
}


@end

@implementation UIViewController (BaseAdditions)

- (void)back
{

    if (self.navigationController == nil) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else if (self == [self.navigationController.viewControllers objectAtIndex:0]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
    

}



- (void)setLeftBarButtonWithTitle:(NSString *)title action:(SEL)action
{
    [self setLeftBarButtonWithImage:nil title:title action:action];

}


- (void)setLeftBarButtonWithImage:(UIImage *)image action:(SEL)action{
    [self setLeftBarButtonWithImage:image title:nil action:action];

}


- (void)setLeftBarButtonWithImage:(UIImage *)image title:(NSString *)title action:(SEL)action{
    BarButton *LeftBtn = [[BarButton alloc] initWithFrame:CGRectMake(0, 0, 50, kCustomBarButtonItemH)];

    if (image != nil) {
        [LeftBtn setImage:image forState:UIControlStateNormal];
    }
//    LeftBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -20,0, 0);
//    LeftBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -15,0, 0);
    if (title.length > 0) {
        
        if (image) {
            LeftBtn.titleLabel.font = [UIFont systemFontOfSize:10];
        }else{
            LeftBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        }
        [LeftBtn setTitleColor:[[BaseConfig sharedConfig] navigationBarTextColor] forState:UIControlStateNormal];
        [LeftBtn setTitle:title forState:UIControlStateNormal];
        
        [LeftBtn setTitlePositionWithType:DPButtonTitlePostionTypeBottom space:5];
    }
    
    
    [LeftBtn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    LeftBtn.backgroundColor = [UIColor clearColor];
    
    
    LeftBtn.contentEdgeInsets = UIEdgeInsetsMake(0, kCustomLeftBarButtonItemEdgeInset, 0, 0);
    
    
    if (action == nil) {
        LeftBtn.enabled = NO;
    }
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:LeftBtn];
    
}







- (void)setRightBarButtonWithTitle:(NSString *)title action:(SEL)action
{
    [self setRightBarButtonWithImage:nil title:title action:action];
}


- (void)setRightBarButtonWithImage:(UIImage *)image action:(SEL)action{
    [self setRightBarButtonWithImage:image title:nil action:action];
}

- (void)setRightBarButtonWithImage:(UIImage *)image title:(NSString *)title action:(SEL)action{
    BarButton *LeftBtn = [[BarButton alloc] initWithFrame:CGRectMake(0, 0, 50, kCustomBarButtonItemH)];

//    LeftBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 20);
//    LeftBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 15);
    if (image != nil) {
        [LeftBtn setImage:image forState:UIControlStateNormal];
    }
    
    if (title.length > 0) {
        if (image) {
            LeftBtn.titleLabel.font = [UIFont systemFontOfSize:10];
        }else{
            LeftBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        }
        [LeftBtn setTitleColor:[[BaseConfig sharedConfig] navigationBarTextColor] forState:UIControlStateNormal];
        [LeftBtn setTitle:title forState:UIControlStateNormal];
        
        [LeftBtn setTitlePositionWithType:DPButtonTitlePostionTypeBottom space:5];
    }
    
    
    [LeftBtn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    LeftBtn.backgroundColor = [UIColor clearColor];
    
    
    LeftBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, kCustomLeftBarButtonItemEdgeInset);
    
    
    if (action == nil) {
        LeftBtn.enabled = NO;
    }
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:LeftBtn];
    
}

- (void)showMsg:(NSString *)title
            msg:(NSString *)msg
       butTitle:(NSString *)butTitle
        handler:(void (^ )(UIAlertAction *action))handler{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    
    // Create the actions.
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:butTitle style:UIAlertActionStyleCancel handler:handler];
    
    
    // Add the actions.
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)showMsgWithTwoButs:(NSString *)title
                       msg:(NSString *)msg
              leftbutTitle:(NSString *)butTitle
             rightbutTitle:(NSString *)rightbutTitle
                   leftHandler:(void (^)(UIAlertAction *action))leftHandler
                   handler:(void (^)(UIAlertAction *action))handler{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    
    // Create the actions.
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:butTitle style:UIAlertActionStyleDefault handler:leftHandler];
    
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:rightbutTitle style:UIAlertActionStyleDefault handler:handler];

    // Add the actions.
    [alertController addAction:cancelAction];
    [alertController addAction:confirmAction];

    [self presentViewController:alertController animated:YES completion:nil];
}




+ (UIViewController *)viewInViewController:(UIView *)view{
    for (UIView* next = [view superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
    
}


- (void)customNavigationBar{
//    [self.navigationController.navigationBar setTranslucent:YES];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    //去黑线
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
}

- (void)defaultNavigationBar{
//    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor] opaque:YES size:CGSizeMake(SCREEN_WIDTH, 66)] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = nil;
}

- (void)delNavBarBottomLine{
    //去黑线
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
}

- (void)recoverNavBarBottomLine{
    self.navigationController.navigationBar.shadowImage = nil;
}

@end
