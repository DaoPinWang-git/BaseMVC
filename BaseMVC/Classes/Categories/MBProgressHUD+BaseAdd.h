//
//  MBProgressHUD+Add.h
//  QDZ
//
//  Created by dpwong on 2017/8/25.
//  Copyright © 2017年 dpwong. All rights reserved.
//

//#import <MBProgressHUD/MBProgressHUD.h>
#import <MBProgressHUD/MBProgressHUD.h>

@interface MBProgressHUD (BaseAdd)

+ (MBProgressHUD *)showMessage:(NSString *)message;

+ (MBProgressHUD *)showError:(NSError *)error;

+ (MBProgressHUD *)showWait:(UIView *)toView;

+ (void)hideWait:(UIView *)toView;

@end
