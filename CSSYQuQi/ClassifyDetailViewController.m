//
//  ClassifyDetailViewController.m
//  CSSYQuQi
//
//  Created by cssy-apple on 15/12/1.
//  Copyright (c) 2015年 cssy-apple. All rights reserved.
//

#import "ClassifyDetailViewController.h"
#import "CommunityTableViewCell.h"
#import "MineCommentViewController.h"
#import "CommunityDetailViewController.h"
#import "LoginViewController.h"
#import "PhotoBroswerVC.h"
@interface ClassifyDetailViewController ()<UITableViewDataSource, UITableViewDelegate> {
    UITableView *_tableView;
}

@end

@implementation ClassifyDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self initall];
}
- (void)initall {
    [self createBackButton];
    [self createRightButton];
    [self createTableView];
}
- (void)createBackButton {
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 15, 20);
    
    [backButton addTarget:self action:@selector(backButton:) forControlEvents:UIControlEventTouchUpInside];
    [backButton setBackgroundImage:[UIImage imageNamed:@"back_button_normal.png"] forState:UIControlStateNormal];
    [backButton setBackgroundImage:[UIImage imageNamed:@"back_button_clicked.png"] forState:UIControlStateHighlighted];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = barButtonItem;
}
- (void)backButton:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)createRightButton {
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 40, 40);
    [rightButton addTarget:self action:@selector(rightButton:) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rightButton setTitle:@"发表" forState:UIControlStateNormal];
    rightButton.titleLabel.font = FontSystem(15);
    [rightButton setTitleColor:ZEBColor(26, 166, 255) forState:UIControlStateNormal];
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    self.navigationItem.rightBarButtonItem = rightBarButton;
}
#pragma mark -
#pragma mark 发表
- (void)rightButton:(UIButton *)button {
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:IsLogin]) {
        MineCommentViewController *commentController = [MineCommentViewController new];
        UINavigationController *commentNav = [[UINavigationController alloc] initWithRootViewController:commentController];
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
//创建tableview
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
    if (!isMore) {
        [_tableView.header endRefreshing];
    }else {
        [_tableView.footer endRefreshing];
    }
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width(self.view.frame), 120)];
    bgView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 80, 80)];
    bgImageView.image = [UIImage imageNamed:@"am.jpg"];
    [bgView addSubview:bgImageView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(maxX(bgImageView)+Margin, minY(bgImageView), 100, 20)];
    titleLabel.text = @"宝马";
    titleLabel.font = Font(15);
    [bgView addSubview:titleLabel];
    
    UILabel *countyLabel = [[UILabel alloc] initWithFrame:CGRectMake(minX(titleLabel), maxY(titleLabel)+Margin, 100, 20)];
    countyLabel.text = @"中国";
    countyLabel.font = Font(15);
    [bgView addSubview:countyLabel];
    
    return bgView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 120;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath     {
    
    CGFloat height = Height(TestStr, width(self.view.frame)-80, 15);
    return height + 260;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"identifier";
    CommunityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[CommunityTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}
//跳转详情页面
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CommunityDetailViewController *communityDetailController = [CommunityDetailViewController new];
    UINavigationController *communityDetailNav = [[UINavigationController alloc] initWithRootViewController:communityDetailController];
    communityDetailController.title = @"详情";
    communityDetailNav.modalTransitionStyle = 2;
    [self  presentViewController:communityDetailNav animated:YES completion:^{
        
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
