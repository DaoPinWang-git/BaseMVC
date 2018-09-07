//
//  BaseNavigationController.m
//  HealthApp
//
//  Created by dpwong on 2017/7/31.
//  Copyright © 2017年 刘瑾. All rights reserved.
//

#import "BaseNavigationController.h"


@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    self.visibleViewController.hidesBottomBarWhenPushed = YES;
    
    
    [super pushViewController:viewController animated:animated];
}

- (nullable UIViewController *)popViewControllerAnimated:(BOOL)animated{
    UIViewController *firstVC = [self.viewControllers firstObject];
    
    firstVC.hidesBottomBarWhenPushed = NO;
    
    return [super popViewControllerAnimated:animated];
}

- (nullable NSArray<__kindof UIViewController *> *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated{
    UIViewController *firstVC = [self.viewControllers firstObject];
    
    firstVC.hidesBottomBarWhenPushed = viewController != firstVC;
    return [super popToViewController:viewController animated:animated];
}

- (nullable NSArray<__kindof UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated{
    UIViewController *firstVC = [self.viewControllers firstObject];
    
    firstVC.hidesBottomBarWhenPushed = NO;
    
    
    return [super popToRootViewControllerAnimated:animated];
}


@end
