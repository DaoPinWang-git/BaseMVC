//
//  BaseTableViewCell.m
//  HealthApp
//
//  Created by dpwong on 2017/7/31.
//  Copyright © 2017年 刘瑾. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "BaseConfig.h"
#import "Masonry.h"

@implementation BaseTableViewCell

@synthesize leftViewWidth = _leftViewWidth;
@synthesize rightViewWidth = _rightViewWidth;


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.width = SCREEN_WIDTH;
        
        self.line = [[UIView alloc] init];
        self.line.backgroundColor = [[BaseConfig sharedConfig] cellLineColor];
        [self.contentView addSubview:self.line];

        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(10);
            make.right.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView);
            make.height.mas_equalTo(1);
        }];
        [self layoutIfNeeded];
        [self.contentView layoutIfNeeded];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setContentModel:(BaseModel *)contentModel{
    _contentModel = contentModel;
}

- (void)setRightImage:(UIImage *)rightImage{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:rightImage];
    imageView.size = CGSizeMake(rightImage.size.width, rightImage.size.height);
    UIView *view = [[UIView alloc] init];
    [view addSubview:imageView];
    view.width = (rightImage.size.width + 10);
    view.height = (rightImage.size.height + 10);
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(view);
    }];
    
    self.rightView = view;
}

- (void)setRightView:(UIView *)rightView{
    [_rightView removeFromSuperview];
    _rightView = rightView;
    _rightViewWidth = rightView.width;
    
    if (rightView) {
        [self.contentView addSubview:rightView];
        
        [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right).offset(- 10);
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.size.mas_equalTo(rightView.size);
        }];
    }

}

- (void)setLeftImage:(UIImage *)leftImage{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:leftImage];
    imageView.size = CGSizeMake(leftImage.size.width, leftImage.size.height);
    UIView *view = [[UIView alloc] init];
    [view addSubview:imageView];
    view.width = (leftImage.size.width + 10);
    view.height = (leftImage.size.height + 10);
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(view);
    }];
    
    self.leftView = view;
}

- (void)setLeftView:(UIView *)leftView{
    [_leftView removeFromSuperview];
    _leftView = leftView;
    _leftViewWidth = leftView.width;
    
    if (leftView) {
        [self.contentView addSubview:leftView];
        
        [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(10);
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.size.mas_equalTo(leftView.size);
        }];
    }

    
}


@end
