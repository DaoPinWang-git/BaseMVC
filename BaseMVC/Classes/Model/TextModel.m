//
//  TextModel.m
//  HealthApp
//
//  Created by dpwong on 2017/7/31.
//  Copyright © 2017年 刘瑾. All rights reserved.
//

#import "TextModel.h"

@implementation TextModel

- (id)init{
    self = [super init];
    
    if (self) {
        self.maxCharacters = NSUIntegerMax;
        self.editable = YES;
        self.allowHeightChange = YES;
        self.content = @"";
    }
    
    return self;
}




@end
