//
//  UIView+Masonry.h
//  WWJIkcrm
//
//  Created by wang.dp on 16/8/15.
//  Copyright © 2016年 王的 MacBook Pro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (BaseMasonry)
- (void) distributeSpacingHorizontallyWith:(NSArray*)views;
- (void) distributeSpacingVerticallyWith:(NSArray*)views;
@end
