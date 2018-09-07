//
//  JVRefreshHeader.m
//  OrderKing
//
//  Created by 王的 MacBook pro on 15/8/10.
//  Copyright (c) 2015年 王的 MacBook Pro. All rights reserved.
//

#import "RefreshHeader.h"

@implementation RefreshHeader

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (instancetype)headerWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock
{
    RefreshHeader *header = [super headerWithRefreshingBlock:refreshingBlock];
    if (header) {
        header.lastUpdatedTimeLabel.hidden = YES;
        header.stateLabel.font = [UIFont systemFontOfSize:12];
//        header.stateLabel.textColor = UIColorFromValue(0x999999);
        [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
        [header setTitle:@"松开后刷新" forState:MJRefreshStatePulling];
        [header setTitle:@"正在刷新..." forState:MJRefreshStateRefreshing];
    }
    return header;
}

@end
