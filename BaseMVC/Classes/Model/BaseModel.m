//
//  BaseModel.m
//  QDZ
//
//  Created by dpwong on 2017/8/24.
//  Copyright © 2017年 dpwong. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

- (id)init{
    self = [super init];
    if (self) {
        self.minCellHeight = 35;
        self.cellHeight = self.minCellHeight;
    }
    return self;
}


- (void)setCellHeight:(CGFloat)cellHeight{
    if (cellHeight < self.minCellHeight) {
        _cellHeight = self.minCellHeight;
    }else{
        _cellHeight = cellHeight;
    }
}


@end
