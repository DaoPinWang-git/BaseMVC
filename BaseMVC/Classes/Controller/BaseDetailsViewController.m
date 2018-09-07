//
//  DetailsViewController.m
//  QDZ
//
//  Created by dpwong on 2017/8/25.
//  Copyright © 2017年 dpwong. All rights reserved.
//

#import "BaseDetailsViewController.h"
#import "Masonry.h"
#import "TextCell.h"
#import "UIView+BaseAdditions.h"

@interface BaseDetailsViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation BaseDetailsViewController


- (NSMutableArray *)listArray{
    if (_listArray == nil) {
        _listArray = [NSMutableArray array];
    }
    return _listArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableview];
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    

    [promptBGView removeFromSuperview];
    
    [self.tableview addSubview:promptBGView];
    


    
//    if available(iOS11.0, *)) {
//        self.tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//        self.tableview.contentInset = UIEdgeInsetsMake(64,0,49,0);//64和49自己看效果，是否应该改成0
//        self.tableview.scrollIndicatorInsets = self.tableview.contentInset;
//    }
    self.tableview.estimatedRowHeight = 0;
    self.tableview.estimatedSectionHeaderHeight = 0;
    self.tableview.estimatedSectionFooterHeight = 0;
    [self registerCellClass];
}

- (void)registerCellClass{
    [self.tableview registerClass:[TextCell class] forCellReuseIdentifier:NSStringFromClass([TextCell class])];
}


- (void)setBottomView:(UIView *)bottomView{
    [_bottomView removeFromSuperview];

    _bottomView = bottomView;
    
    [self.tableview mas_updateConstraints:^(MASConstraintMaker *make) {
        if (bottomView) {
            make.bottom.equalTo(self.view).offset(- bottomView.height);
        }else{
            make.bottom.equalTo(self.view).offset(0);
        }
    }];
    if (bottomView) {
        [self.view addSubview:bottomView];
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.bottom.and.right.equalTo(self.view);
            make.height.mas_equalTo(bottomView.height);
        }];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self addKeyNotification];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
    [self removeKeyNotification];
}



- (void)addKeyNotification{
    //增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)removeKeyNotification{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    
}

//当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    // 1.键盘弹出需要的时间
    CGFloat duration = [aNotification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    // 2.动画
    [UIView animateWithDuration:duration animations:^{
        // 取出键盘高度
        CGRect keyboardF = [aNotification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        CGFloat keyboardH = keyboardF.size.height;

        [self.tableview mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.view).offset(-keyboardH);
        }];
        [self.view setNeedsLayout];
//        [self.view layoutIfNeeded];
    }];
    
}

//当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification
{
    // 1.键盘弹出需要的时间
    CGFloat duration = [aNotification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    // 2.动画
    [UIView animateWithDuration:duration animations:^{
        
        [self.tableview mas_updateConstraints:^(MASConstraintMaker *make) {
            if (self.bottomView) {
                make.bottom.equalTo(self.view).offset(- self.bottomView.height);
            }else{
                make.bottom.equalTo(self.view).offset(0);
            }
        }];
        
        [self.view layoutIfNeeded];
    }];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TextCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TextCell class])];
    cell.contentModel = [self.listArray objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}

@end
