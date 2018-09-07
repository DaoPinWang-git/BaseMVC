//
//  BaseCollectionViewCell.h
//  QDZ
//
//  Created by dpwong on 2017/9/4.
//  Copyright © 2017年 dpwong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BaseModel;

@interface BaseCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) BaseModel *contentModel;

@end
