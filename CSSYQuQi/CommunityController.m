//
//  CommunityController.m
//  CSSYQuQi
//
//  Created by cssy-apple on 15/11/19.
//  Copyright (c) 2015年 cssy-apple. All rights reserved.
//

#import "CommunityController.h"
#import "CommunityTableViewCell.h"
#import "CommunityDetailViewController.h"
#import "ClassifyViewController.h"
#import "MineCommentViewController.h"
#import "LoginViewController.h"
#import "PhotoBroswerVC.h"
@interface CommunityController ()<UITableViewDataSource, UITableViewDelegate, CommunityTableViewCellDelegate, CommunityCellReplyDelegate> {
    UITableView *_tableView;
}

@end

@implementation CommunityController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self initall];
}
- (void)initall {
    [self createBarButton];
    [self createTableView];
}
//创建分类和发表内容按钮
- (void)createBarButton {
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 40, 40);
    [leftButton addTarget:self action:@selector(leftButton:) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [leftButton setTitle:@"分类" forState:UIControlStateNormal];
    leftButton.titleLabel.font = FontSystem(15);
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 35, 35);
    [rightButton addTarget:self action:@selector(rightButton:) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setTitleColor:ZEBColor(26, 166, 255) forState:UIControlStateNormal];
    [rightButton setTitle:@"发表" forState:UIControlStateNormal];
    rightButton.titleLabel.font = FontSystem(15);
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    self.navigationItem.leftBarButtonItem = leftBarButton;
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
}
#pragma mark -
#pragma mark 分类
- (void)leftButton:(UIButton *)button {
    ClassifyViewController *classifyController = [ClassifyViewController new];
    classifyController.title = @"分类";
    UINavigationController *classifyNav = [[UINavigationController alloc] initWithRootViewController:classifyController];
    
    [self presentViewController:classifyNav animated:YES completion:^{
        
    }];
}

#pragma mark -
#pragma mark 发表
- (void)rightButton:(UIButton *)button {
    NSLog(@"%d",[[NSUserDefaults standardUserDefaults] boolForKey:IsLogin]);
    if ([[NSUserDefaults standardUserDefaults] boolForKey:IsLogin]) {
        MineCommentViewController *commentController = [MineCommentViewController new];
        UINavigationController *commentNav = [[UINavigationController alloc] initWithRootViewController:commentController];
        commentController.fromUI = @"社区";
        commentController.viewTitle = @"我要发表";
        
        [self presentViewController:commentNav animated:YES completion:^{
            
        }];
    }else {
        SHOW_ALERT(@"请先登录！");
//        LoginViewController *loginViewController = [LoginViewController new];
//        loginViewController.title = @"登录";
//        UINavigationController *loginNav = [[UINavigationController alloc] initWithRootViewController:loginViewController];
//        [self presentViewController:loginNav animated:YES completion:^{
//            
//        }];
    }
    
}
#pragma mark -
#pragma mark 创建tableView
- (void)createTableView {
    if (_tableView == nil) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, width(self.view.frame), height(self.view.frame)-64) style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.showsVerticalScrollIndicator = NO;
        [self.view addSubview:_tableView];
        
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self prepareLoadData:NO];
        }];
        MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [self prepareLoadData:YES];
        }];
        _tableView.header = header;
        _tableView.footer = footer;
    }
    [_tableView.header beginRefreshing];
}
//准备加载数据
- (void)prepareLoadData:(BOOL)isMore {
    NSString *url = @"";
    
    NSInteger page = 1;
    if (isMore) {
        page = page+1;
    }
    [self loadingData:url isMore:isMore];
}
//开始加载数据
- (void)loadingData:(NSString *)url isMore:(BOOL)isMore {
    [MBProgressHUD showMessage:@"努力加载中..." toView:self.view dimBackground:NO];
    if (isMore) {
        [_tableView.footer endRefreshing];
    }else {
        [_tableView.header endRefreshing];
    }
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 10;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = Height(TestStr, width(self.view.frame)-80, 15);
    return height + 265;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"identifier";
    CommunityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[CommunityTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    cell.replyDelegate = self;
    cell.delegate = self;
    return cell;
}
- (void)communityReply:(CommunityTableViewCell *)cell {
    MineCommentViewController *commentController = [MineCommentViewController new];
    
    UINavigationController *commentNav = [[UINavigationController alloc] initWithRootViewController:commentController];
    commentController.fromUI = @"评论";
    commentController.viewTitle = @"我要点评";
    
    [self presentViewController:commentNav animated:YES completion:^{
        
    }];
    
}
//跳转评论详情界面
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CommunityDetailViewController *communityDetailController = [CommunityDetailViewController new];
    UINavigationController *communityDetailNav = [[UINavigationController alloc] initWithRootViewController:communityDetailController];
    communityDetailController.title = @"评论详情";
    communityDetailNav.modalTransitionStyle = 2;
    
    [self presentViewController:communityDetailNav animated:YES completion:^{
        
    }];
}
//跳转滚动相册浏览图片
- (void)CommunityTableViewCell:(CommunityTableViewCell *)cell scrollViewOriginalImages:(NSMutableArray *)scrollViewOriginalImages index:(NSInteger)index{
    [self networkImageShow:index scrollViewOriginalImages:scrollViewOriginalImages];
}
/*
 *  展示网络图片
 */
-(void)networkImageShow:(NSUInteger)index scrollViewOriginalImages:(NSMutableArray *)scrollViewOriginalImages{
    
    [PhotoBroswerVC show:self type:PhotoBroswerVCTypePush index:index photoModelBlock:^NSArray *{
        
        
        NSMutableArray *modelsM = [NSMutableArray arrayWithCapacity:scrollViewOriginalImages.count];
        for (NSUInteger i = 0; i< scrollViewOriginalImages.count; i++) {
            
            PhotoModel *pbModel=[[PhotoModel alloc] init];
            pbModel.mid = i + 1;
            
            //pbModel.image_HD_U = self.scrollViewOriginalImages[i];
            pbModel.image = scrollViewOriginalImages[i];
            
            [modelsM addObject:pbModel];
        }
        
        return modelsM;
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
