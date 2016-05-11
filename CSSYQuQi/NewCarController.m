//
//  NewCarController.m
//  CSSYQuQi
//
//  Created by cssy-apple on 15/11/19.
//  Copyright (c) 2015年 cssy-apple. All rights reserved.
//

#import "NewCarController.h"
#import "SDCycleScrollView.h"
#import "NewCarTableViewCell.h"
#import "TopDetailViewController.h"
#import "NewCarDetailViewController.h"
@interface NewCarController ()<UITableViewDataSource, UITableViewDelegate,SDCycleScrollViewDelegate> {

    UITableView *_tableView;
    SDCycleScrollView *_sdScroller;
}
@property (nonatomic, strong) NSMutableArray *imageUrlArray;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation NewCarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self initall];
    
}
- (void)initall {
    
    _imageUrlArray = (NSMutableArray *)@[@"http://s6.mogujie.cn/b7/bao/131011/y3pli_kqywwtc2kfbfitdwgfjeg5sckzsew_289x409.jpg_200x999.jpg",@"http://s6.mogujie.cn/b7/bao/131011/y3pli_kqywwtc2kfbfitdwgfjeg5sckzsew_289x409.jpg_200x999.jpg",@"http://s6.mogujie.cn/b7/bao/131011/y3pli_kqywwtc2kfbfitdwgfjeg5sckzsew_289x409.jpg_200x999.jpg",@"http://s6.mogujie.cn/b7/bao/131011/y3pli_kqywwtc2kfbfitdwgfjeg5sckzsew_289x409.jpg_200x999.jpg"];
    [self createScroller];
    [self createTableView];
}
-(NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (NSMutableArray *)imageUrlArray {
    if (_imageUrlArray == nil) {
        _imageUrlArray = [NSMutableArray array];
    }
    return _imageUrlArray;
}
#pragma mark - 
#pragma mark 创建头视图滚动视图
- (void)createScroller {
    _sdScroller = [[SDCycleScrollView alloc] initWithFrame:CGRectMake(0, 60, width(self.view.frame), 200)];
    _sdScroller.imageURLStringsGroup = _imageUrlArray;
    _sdScroller.showPageControl = YES;
    _sdScroller.delegate = self;
    
}
#pragma mark -
#pragma mark 滚动视图跳转
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    TopDetailViewController *topDetailController = [TopDetailViewController new];
    topDetailController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:topDetailController animated:YES];
}
#pragma mark -
#pragma mark 创建tableView
- (void)createTableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, width(self.view.frame), height(self.view.frame)-64) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = _sdScroller;
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
    
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"identifier";
    NewCarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[NewCarTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NewCarDetailViewController *newCarDetailController = [NewCarDetailViewController new];
    newCarDetailController.title = @"详情";
    UINavigationController *newCarDetailControllerNav = [[UINavigationController alloc] initWithRootViewController:newCarDetailController];
    newCarDetailController.modalTransitionStyle = 2;
    [self presentViewController:newCarDetailControllerNav animated:YES completion:^{
        
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
