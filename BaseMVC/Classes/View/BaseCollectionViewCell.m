//
//  BaseCollectionViewCell.m
//  QDZ
//
//  Created by dpwong on 2017/9/4.
//  Copyright © 2017年 dpwong. All rights reserved.
//

#import "BaseCollectionViewCell.h"

@implementation BaseCollectionViewCell

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self.contentView layoutIfNeeded];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView layoutIfNeeded];
    }
    return self;
}
@end
