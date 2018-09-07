//
//  DetailsViewController.h
//  QDZ
//
//  Created by dpwong on 2017/8/25.
//  Copyright © 2017年 dpwong. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseDetailsViewController : BaseViewController

@property (nonatomic, strong) UITableView *tableview;


/**
 使用时，设置好高度直接赋值，默认nil
 */
@property (nonatomic, strong) UIView *bottomView;
/**
 列表数据
 */
@property (nonatomic, strong) NSMutableArray *listArray;


/**
 注册cell
 */
- (void)registerCellClass;

- (void)keyboardWillShow:(NSNotification *)aNotification;

- (void)keyboardWillHide:(NSNotification *)aNotification;

////swift专用
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
//
////swift专用
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;

@end
