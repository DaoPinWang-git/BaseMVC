//
//  WWJInputCell.m
//  WWJIkcrm
//
//  Created by 王的 MacBook pro on 15/9/26.
//  Copyright © 2015年 王的 MacBook Pro. All rights reserved.
//

#import "InputCell.h"
#import "Masonry.h"
#import "NSString+BaseAdditions.h"
#import "UIView+BaseAdditions.h"

//@implementation NSObject
//@end



@implementation InputCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.font = [UIFont systemFontOfSize:15];
//        self.titleLabel.textColor = ydtblackfont;
        self.titleLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.titleLabel];
        
        self.contentTextView = [[UITextView alloc] initWithFrame:CGRectZero];
        self.contentTextView.editable = self.isEditable;
        self.contentTextView.delegate = self;
        self.contentTextView.scrollEnabled = NO;
        self.contentTextView.font = [UIFont systemFontOfSize:15];
//        self.contentTextView.textColor = ydtblackfont;
        self.contentTextView.backgroundColor = [UIColor clearColor];
        self.contentTextView.returnKeyType = UIReturnKeyDone;
        self.contentTextView.textContainerInset = UIEdgeInsetsMake(10, 0, 10, 0);
        [self.contentView addSubview:self.contentTextView];

        
        
        self.contentTextField = [[UITextField alloc] initWithFrame:CGRectZero];
        self.contentTextField.enabled = self.isEditable;
        self.contentTextField.delegate = self;
        self.contentTextField.font = [UIFont systemFontOfSize:15];
//        self.contentTextField.textColor = ydtblackfont;
        self.contentTextField.placeholder = @"";
        self.contentTextField.backgroundColor = [UIColor clearColor];
        self.contentTextField.returnKeyType = UIReturnKeyDone;
        [self.contentView addSubview:self.contentTextField];
        
  
        
        self.placeholderLabel = [[UILabel alloc] init];
        self.placeholderLabel.font = [UIFont systemFontOfSize:12];
        self.placeholderLabel.textColor = [UIColor lightGrayColor];
        self.placeholderLabel.userInteractionEnabled = NO;
        [self.contentView addSubview:self.placeholderLabel];

        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(self.leftViewWidth + 10);
            make.top.equalTo(self.contentView).offset(0);
        }];
        
        [self.contentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLabel.mas_right).offset(5);
            make.top.equalTo(self.contentView).offset(0);
            make.bottom.equalTo(self.contentView).offset(- 0);
            make.right.equalTo(self.contentView).offset(- self.rightViewWidth - 10);
        }];
        
        [self.contentTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.equalTo(self.contentTextView);
            make.centerY.equalTo(self.contentView);
        }];
        [self.placeholderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentTextView).offset(self.contentTextView.textContainerInset.left + 5);
            make.right.equalTo(self.contentTextView);
//            make.centerY.equalTo(self.titleLabel).offset(0);
        }];
        

        
        self.isEditable = YES;
        
        self.content = @"";
        self.title = @"";

        [self layoutIfNeeded];
        self.userInput = UserInputViewTextView;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
        
        self.initialCellHeight = 35.0;

    }
    return self;
}



- (void)setContentModel:(BaseModel *)contentModel{
    [super setContentModel:contentModel];
    if ([self.contentModel isKindOfClass:[TextModel class]]) {
        TextModel *item = (TextModel *)self.contentModel;
        self.title = item.title;
        if ([NSString isHaveValue:item.title]) {
            [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.contentView).offset(self.leftViewWidth + 10);
                make.width.mas_equalTo([self.titleLabel sizeThatFits:CGSizeMake(200, self.titleLabel.font.lineHeight)].width);
                make.height.mas_equalTo(self.titleLabel.font.lineHeight);
            }];
        }else{
            [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.contentView).offset(self.leftViewWidth + 0);
                make.width.mas_equalTo(0);
                make.height.mas_equalTo(self.titleLabel.font.lineHeight);
            }];
            
        }
        self.content = item.content;
        self.inputType = item.inputType;
        self.placeholder = item.placeHolder;
        self.isEditable = item.editable;
        if (item.arrowImage) {
            UIImageView *imageView = [[UIImageView alloc] initWithImage:item.arrowImage];
            imageView.size = item.arrowImage.size;
            self.rightView = imageView;
        }else{
            self.rightView = nil;
        }
    }
}

- (void)setUserInput:(UserInputView)userInput{
    _userInput = userInput;
    if (userInput == UserInputViewTextView) {
        self.contentTextView.hidden = NO;
        self.contentTextField.hidden = YES;
    }else{
        self.contentTextView.hidden = YES;
        self.contentTextField.hidden = NO;
    }
}

- (void)setIsEditable:(BOOL)isEditable{
    _isEditable = isEditable;
    self.contentTextView.editable = isEditable;
    self.contentTextView.userInteractionEnabled = isEditable;
    
    self.contentTextField.enabled = isEditable;
    self.contentTextField.userInteractionEnabled = isEditable;

    
    self.placeholderLabel.hidden = self.content.length > 0;

}

- (void)setRightView:(UIView *)rightView{
    [super setRightView:rightView];
    if (rightView == nil) {
        [self.contentTextView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset((- self.rightViewWidth - 10));
        }];
    }else{
        [self.contentTextView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset((- self.rightViewWidth - 10 - 10));
        }];
    }
    
}


- (void)setLeftView:(UIView *)leftView{
    [super setLeftView:leftView];

    if (self.leftView == nil) {
        [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(self.leftViewWidth + 10);
        }];
    }else{
        [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(self.leftViewWidth + 10 + 10);
        }];
    }

}

- (void)setInitialCellHeight:(CGFloat)initialCellHeight{
    _initialCellHeight = initialCellHeight;
    
    self.contentTextView.textContainerInset = UIEdgeInsetsMake((initialCellHeight - self.contentTextView.font.lineHeight) / 2, 0, (initialCellHeight - self.contentTextView.font.lineHeight) / 2, 0);
    
    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(self.contentTextView.textContainerInset.top);
    }];
    
    [self.placeholderLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentTextView).offset(self.contentTextView.textContainerInset.top);
    }];
}

//相应手势
- (void)longPress:(UILongPressGestureRecognizer *)longPress
{
    
    if (longPress.state == UIGestureRecognizerStateBegan) {
            [self becomeFirstResponder];
            
            UIMenuController *menu = [UIMenuController sharedMenuController];
            UIMenuItem *copy = [[UIMenuItem alloc] initWithTitle:@"拷贝" action:@selector(myCopy:)];
            [menu setMenuItems:@[copy]];
            [menu setTargetRect:self.contentTextView.frame inView:self.contentTextView.superview];
            [menu setMenuVisible:YES animated:YES];
    }

}

//针对于响应方法的实现
-(void)myCopy:(id)sender
{
    UIPasteboard *pboard = [UIPasteboard generalPasteboard];
    pboard.string = self.contentTextView.text;
    
}

- (void)setTitle:(NSString *)title{
    _title = title;
    self.titleLabel.text = title;
//    self.contentTextView.placeholder = title;
//    self.contentTextField.placeholder = title;
}

- (void)setContent:(NSString *)content{
    _content = content;
    self.contentTextView.text = [NSString judgmentString:content];
    self.contentTextField.text = [NSString judgmentString:content];
    self.placeholderLabel.hidden = [NSString isHaveValue:content];

    [self textHeight];
    
}

- (void)setPlaceholder:(NSString *)placeholder{
    self.placeholderLabel.text = placeholder;
    self.placeholderLabel.hidden = self.content.length > 0;
//    self.contentTextView.placeholderLockTop = !self.placeholderTextField.hidden;

}


- (CGFloat)optimumCellHeight{
    if (self.userInput == UserInputViewTextField) {
        return self.contentTextField.height;
    }
    
    return [self.contentTextView sizeThatFits:CGSizeMake(self.contentTextView.width, 500)].height;
    

}

#pragma mark --UITextViewDelegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{

    CGPoint pt;
    CGRect rc = [textView bounds];
    rc = [textView convertRect:rc toView:self.parentTableView];
    pt = rc.origin;
    pt.x = 0;
    pt.y -=  70;
    if (pt.y < 0) {
        pt.y = 0;
    }
    
    [self.parentTableView setContentOffset:pt animated:YES];
    return YES;
}



- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
//    if ([self.contentModel isKindOfClass:[TextModel class]]) {
//        TextModel *model = (TextModel *)self.contentModel;
//        if (textView.text.length == model.maxCharacters){
//            [MBProgressHUD showMessage:[NSString stringWithFormat:@"最多可以输入%zi字符哦",model.maxCharacters]];
//            return NO;
//        }
//    }
    
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView{
    
    if (textView != self.contentTextView) {
        return;
    }
    
    _content = self.contentTextView.text;
    self.placeholderLabel.hidden = _content.length > 0;

    
    [self textHeight];
    [self.parentTableView beginUpdates];
    
    [self.parentTableView endUpdates];
    TextDidChangeNotification;

}

- (void)textViewDidEndEditing:(UITextView *)textView{
    
}


#pragma mark --UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    CGPoint pt;
    CGRect rc = [textField bounds];
    rc = [textField convertRect:rc toView:self.parentTableView];
    pt = rc.origin;
    pt.x = 0;
    pt.y -=  70;
    [self.parentTableView setContentOffset:pt animated:YES];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([string isEqualToString:@"\n"]) {
        [textField resignFirstResponder];
        return NO;
    }
    return YES;
}

- (void)textFieldDidChange:(NSNotificationCenter *)not{

    _content = self.contentTextField.text;
    self.placeholderLabel.hidden = _content.length > 0;
    [self textHeight];
    TextDidChangeNotification;

}


- (void)textHeight{
    
    
//    if ([NSString isHaveValue:self.content]) {
//        self.contentTextView.placeholderYPadding = - 6;
//    }else{
//        self.contentTextView.placeholderYPadding = - 12;
//    }
//    
    
    
    self.contentTextView.scrollEnabled = NO;
    self.contentTextView.contentOffset = CGPointZero;
    
    self.contentModel.cellHeight = self.optimumCellHeight;
    
    if ([self.contentModel isKindOfClass:[TextModel class]]) {
        TextModel *item = (TextModel *)self.contentModel;
        item.content = self.content;
    }
    
}


- (void)setInputType:(BaseInputType)inputType{
    _inputType = inputType;
    switch (_inputType) {
        case InputTypeCommon:{
            self.contentTextView.keyboardType = UIKeyboardTypeDefault;
            self.contentTextField.keyboardType = UIKeyboardTypeDefault;

        }
            break;
        case InputTypeNumber:{
            self.contentTextView.keyboardType = UIKeyboardTypeNumberPad;
            self.contentTextField.keyboardType = UIKeyboardTypeNumberPad;

        }
            break;
        case InputTypeDecimalPad:{
            self.contentTextView.keyboardType = UIKeyboardTypeDecimalPad;
            self.contentTextField.keyboardType = UIKeyboardTypeDecimalPad;

        }
            break;
        case InputTypePhone:{
            self.contentTextView.keyboardType = UIKeyboardTypePhonePad;
            self.contentTextField.keyboardType = UIKeyboardTypePhonePad;

        }
            break;
        case InputTypeUrl:{
            self.contentTextView.keyboardType = UIKeyboardTypeURL;
            self.contentTextField.keyboardType = UIKeyboardTypeURL;

        }
            break;
        case InputTypeEmail:{
            self.contentTextView.keyboardType = UIKeyboardTypeEmailAddress;
            self.contentTextField.keyboardType = UIKeyboardTypeEmailAddress;

        }
            break;
        case InputTypeNumberAndPunctuation:{
            self.contentTextView.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
            self.contentTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        }
            break;
        default:{
            self.contentTextView.keyboardType = UIKeyboardTypeDefault;
            self.contentTextField.keyboardType = UIKeyboardTypeDefault;

        }
            break;
    }
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews{
    [super layoutSubviews];

    [self.contentTextView layoutSubviews];
    [self.contentTextField layoutSubviews];
}


- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
