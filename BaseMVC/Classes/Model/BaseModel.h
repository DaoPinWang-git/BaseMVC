//
//  BaseModel.h
//  QDZ
//
//  Created by dpwong on 2017/8/24.
//  Copyright © 2017年 dpwong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject
/**
    id
 */
@property (nonatomic, copy) NSString *id;


/**
 用于计算cell高度
 */
@property (nonatomic, assign) CGFloat cellHeight;

/**
 用于最小cell高度(默认35)
 */
@property (nonatomic, assign) CGFloat minCellHeight;

@end
