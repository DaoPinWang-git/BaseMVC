//
//  MBProgressHUD+Add.m
//  QDZ
//
//  Created by dpwong on 2017/8/25.
//  Copyright © 2017年 dpwong. All rights reserved.
//

#import "MBProgressHUD+BaseAdd.h"

@implementation MBProgressHUD (BaseAdd)

+ (MBProgressHUD *)showMessage:(NSString *)message{

    UIWindow *window = [UIApplication sharedApplication].keyWindow;

    MBProgressHUD *mb = [self HUDForView:window];
    if (mb == nil) {
        mb = [MBProgressHUD showHUDAddedTo:window animated:YES];
        mb.bezelView.color = [UIColor colorWithWhite:0 alpha:0.5];

    }

    mb.detailsLabel.text = message;
    mb.mode = MBProgressHUDModeText;
    mb.userInteractionEnabled = NO;
    
    [mb hideAnimated:YES afterDelay:1.0];
    return mb;
}

+ (MBProgressHUD *)showError:(NSError *)error{
    return [MBProgressHUD showMessage:error.localizedDescription];
}

+ (MBProgressHUD *)showWait:(UIView *)toView{
    MBProgressHUD *mb = [self HUDForView:toView];

    if (mb == nil) {
        mb = [MBProgressHUD showHUDAddedTo:toView animated:YES];
        mb.bezelView.color = [UIColor colorWithWhite:0 alpha:0.5];
    }
    return mb;
}

+ (void)hideWait:(UIView *)toView{
    [MBProgressHUD hideHUDForView:toView animated:NO];
}

@end
