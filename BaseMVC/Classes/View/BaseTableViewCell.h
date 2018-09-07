//
//  BaseTableViewCell.h
//  HealthApp
//
//  Created by dpwong on 2017/7/31.
//  Copyright © 2017年 刘瑾. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseModel.h"

@interface BaseTableViewCell : UITableViewCell

@property (nonatomic, strong) BaseModel *contentModel;
@property (nonatomic, strong) UIView *line;


/**
 右边图片，使用时直接赋值
 */
@property (nonatomic, strong)   UIImage      *rightImage;

/**
 *  右边的view，使用时直接赋值
 *  继承时重写 - (void)setRightView:(UIView *)rightView;,需要回调[super setRightView:rightView]，然后再重新布局
 
 - (void)setRightView:(UIView *)rightView{
    [super setRightView:rightView];
 
    [self.contentTextView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset((- self.rightViewWidth - 10 - 10));
    }];
 }
 
 */
@property (nonatomic, strong)   UIView      *rightView;

/**
 右边view的宽度
 */
@property (nonatomic, assign, readonly) CGFloat rightViewWidth;

/**
 左边图片，使用时直接赋值
 */
@property (nonatomic, strong)   UIImage      *leftImage;

/**
 *  左边的view，使用时直接赋值
 *  继承时重写 - (void)setLeftView:(UIView *)leftView;,需要回调[super setLeftView:leftView]，然后再重新布局
 
 - (void)setLeftView:(UIView *)leftView{
    [super setLeftView:leftView];
 
    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(self.leftViewWidth + 10 + 10);
    }];
 }
 
 */
@property (nonatomic, strong)   UIView      *leftView;

/**
 左边view的宽度
 */
@property (nonatomic, assign, readonly) CGFloat leftViewWidth;

@property (nonatomic, weak) UITableView *parentTableView;
@end
