//
//  WWJInputCell.h
//  WWJIkcrm
//
//  Created by 王的 MacBook pro on 15/9/26.
//  Copyright © 2015年 王的 MacBook Pro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"

#define TextDidChangeNotification [[NSNotificationCenter defaultCenter] postNotificationName:TextDidChangeNotificationName object:nil]
#define TextDidChangeNotificationName @"TextDidChangeNotificationName"

typedef NS_ENUM(NSUInteger, UserInputView) {
    UserInputViewTextView = 0,
    UserInputViewTextField,
};

@interface InputCell : BaseTableViewCell<UITextViewDelegate,UITextFieldDelegate>
/**
 *  标题
 */
@property (nonatomic, copy)     NSString    *title;

/**
 *  内容
 */
@property (nonatomic, copy)     NSString    *content;

/**
 *  输入的类型
 */
@property (nonatomic, assign)   BaseInputType inputType;


@property (nonatomic, copy)     NSString    *placeholder;



///**
// *  线
// */
//@property (nonatomic, strong)   UIView      *lineView;

/**
 *  是否可编辑，默认YES
 */
@property (nonatomic, assign) BOOL isEditable;

@property (nonatomic, strong) UILabel *titleLabel;

/**
 *  内容文本框(尽量不要用contentTextView.text属性来设置内容，直接用self.content属性)
 */
@property (nonatomic, strong) UITextView *contentTextView;

@property (nonatomic, strong) UITextField *contentTextField;

@property (nonatomic, strong) UILabel *placeholderLabel;

/**
 *  使用哪种类型的输入框，默认:UserInputViewTextView
 */
@property (nonatomic, assign) UserInputView userInput;

/**
 *  自身合适的高度
 */
@property (nonatomic, assign, readonly) CGFloat optimumCellHeight;

/**
 *  初始的高度，默认35
 */
@property (nonatomic, assign) CGFloat initialCellHeight;


/**
 *  子类重写时必须调用父类
 */
- (void)textViewDidChange:(UITextView *)textView;

@end
