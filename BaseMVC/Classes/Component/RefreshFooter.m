//
//  JVRefreshFooter.m
//  OrderKing
//
//  Created by 王的 MacBook pro on 15/8/10.
//  Copyright (c) 2015年 王的 MacBook Pro. All rights reserved.
//

#import "RefreshFooter.h"

@implementation RefreshFooter

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (instancetype)footerWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock
{
    RefreshFooter *footer = [super footerWithRefreshingBlock:refreshingBlock];
    footer.stateLabel.font = [UIFont systemFontOfSize:12];
//    footer.stateLabel.textColor = UIColorFromValue(0x999999);
    [footer setTitle:@"" forState:MJRefreshStateIdle];
    [footer setTitle:NSLocalizedString(@"加载更多...", nil) forState:MJRefreshStateRefreshing];
    [footer setTitle:NSLocalizedString(@"没有更多了", nil) forState:MJRefreshStateNoMoreData];
    footer.automaticallyRefresh = NO;

    
    return footer;
}

@end
