//
//  TextCell.m
//  HealthApp
//
//  Created by dpwong on 2017/7/31.
//  Copyright © 2017年 刘瑾. All rights reserved.
//

#import "TextCell.h"
#import "Masonry.h"
#import "NSString+BaseAdditions.h"
#import "UIView+BaseAdditions.h"

@implementation TextCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.titleLabel = [[UILabel alloc] init];
//        self.titleLabel.textColor = ydtblackfont;
        self.titleLabel.numberOfLines = 0;
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.titleLabel];
        
        
        self.contentLabel = [[UILabel alloc] init];
        self.contentLabel.numberOfLines = 0;
        self.contentLabel.font = [UIFont systemFontOfSize:12];
//        self.contentLabel.textColor = ydtgrayfont;
        [self.contentView addSubview:self.contentLabel];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.contentView).offset(10);
            make.right.equalTo(self.contentView).offset(-10);
        }];
        
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(5);
            make.left.and.right.equalTo(self.titleLabel);
        }];

    }
    
    return self;
}

- (void)setContentModel:(TextModel *)contentModel{
    [super setContentModel:contentModel];
    self.titleLabel.text = contentModel.title;
    
    self.contentLabel.text = contentModel.content;
    
    [self.contentView layoutIfNeeded];

    if (![NSString isHaveValue:contentModel.content]) {
        self.contentModel.cellHeight = [self.titleLabel sizeThatFits:CGSizeMake(self.titleLabel.width, MAXFLOAT)].height + 10 * 2;

    }else{
        self.contentModel.cellHeight = [self.titleLabel sizeThatFits:CGSizeMake(self.titleLabel.width, MAXFLOAT)].height + 5 +
                                       [self.contentLabel sizeThatFits:CGSizeMake(self.contentLabel.width, MAXFLOAT)].height + 10 * 2;
    }

}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    
    if ([NSString isHaveValue:self.contentLabel.text]) {
        [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(10);
            
            if (self.rightViewWidth > 0) {
                make.right.equalTo(self.contentView).offset((- self.rightViewWidth - 10 - 10));
            }else{
                make.right.equalTo(self.contentView).offset((- 10));
            }
            
            if (self.leftViewWidth > 0) {
                make.left.equalTo(self.contentView).offset(self.leftViewWidth + 10 + 10);
            }else{
                make.left.equalTo(self.contentView).offset(10);
            }

        }];
    }else{
        [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            
            if (self.rightViewWidth > 0) {
                make.right.equalTo(self.contentView).offset((- self.rightViewWidth - 10 - 10));
            }else{
                make.right.equalTo(self.contentView).offset((- 10));
            }
            
            if (self.leftViewWidth > 0) {
                make.left.equalTo(self.contentView).offset(self.leftViewWidth + 10 + 10);
            }else{
                make.left.equalTo(self.contentView).offset(10);
            }
        }];
    }
}


- (void)setRightView:(UIView *)rightView{
    [super setRightView:rightView];
    
    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        if (self.rightViewWidth > 0) {
            make.right.equalTo(self.contentView).offset((- self.rightViewWidth - 10 - 10));
        }else{
            make.right.equalTo(self.contentView).offset((- 10));
        }
    }];
}


- (void)setLeftView:(UIView *)leftView{
    [super setLeftView:leftView];
    
    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        if (self.leftViewWidth > 0) {
            make.left.equalTo(self.contentView).offset(self.leftViewWidth + 10 + 10);
        }else{
            make.left.equalTo(self.contentView).offset(10);
        }
    }];

}

@end
