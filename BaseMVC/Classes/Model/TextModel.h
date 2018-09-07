//
//  TextModel.h
//  HealthApp
//
//  Created by dpwong on 2017/7/31.
//  Copyright © 2017年 刘瑾. All rights reserved.
//

#import "BaseModel.h"

/**
 输入类型

 */
typedef NS_ENUM(NSInteger, BaseInputType) {
    /// 普通类型，可以输任何内容，默认
    InputTypeCommon = 0,
    /// 只能输入数字
    InputTypeNumber,
    /// 只能输入数字,小数
    InputTypeDecimalPad,
    /// 电话键盘
    InputTypePhone,
    /// 网址键盘
    InputTypeUrl,
    /// 邮箱键盘
    InputTypeEmail,
    /// 优先打开数字键盘
    InputTypeNumberAndPunctuation
};

@class TextModel;
/**
 选择回调
 */
typedef void(^SelectBlock)(TextModel *model, NSIndexPath *indexPath);


@interface TextModel : BaseModel
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *placeHolder;
@property (nonatomic, strong) UIView *accessoryView;
@property (nonatomic, strong) UIImage *arrowImage;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, assign) BOOL editable;  //default YES
@property (nonatomic, assign) BOOL allowHeightChange; //default NO
@property (nonatomic, assign) NSTextAlignment textAlignment;
@property (nonatomic, assign) CGFloat textFieldWidth;
@property (nonatomic, assign) NSInteger maxCharacters; //default NSUIntegerMax
@property (nonatomic, assign) BaseInputType inputType;
@property (nonatomic, copy) SelectBlock selectBlock;
@end
