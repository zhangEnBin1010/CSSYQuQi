//
//  ClassifyViewController.m
//  CSSYQuQi
//
//  Created by cssy-apple on 15/11/25.
//  Copyright (c) 2015年 cssy-apple. All rights reserved.
//

#import "ClassifyViewController.h"
#import "ClassifyDetailViewController.h"
@interface ClassifyViewController ()<UITableViewDataSource, UITableViewDelegate> {
    UITableView *_tableView;
    NSArray *_sectionTitles;
}

@end

@implementation ClassifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    [self initall];
}
- (void)initall {
    [self createBackButton];
    _sectionTitles = @[@"#",@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"];
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
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (void)createTableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, width(self.view.frame), height(self.view.frame)-64) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.sectionIndexBackgroundColor = [UIColor clearColor];
        _tableView.sectionIndexColor = ZEBColor(26, 166, 255);
        _tableView.sectionIndexTrackingBackgroundColor = [UIColor lightGrayColor];
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
    return _sectionTitles.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
#pragma mark -
#pragma mark 头视图高
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 25;
}
#pragma mark -
#pragma mark 返回头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width(self.view.frame), 50)];
//    view.backgroundColor = [UIColor whiteColor];
//    
//    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width(self.view.frame), 15)];
//    topView.backgroundColor = [UIColor groupTableViewBackgroundColor];
//    [view addSubview:topView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width(self.view.frame), 25)];
    label.backgroundColor = [UIColor groupTableViewBackgroundColor];
    if (section == 0) {
       label.text = @"热门社区";
       label.font = FontSystem(15);
    }else {
        label.text = _sectionTitles[section];
        label.font = FontSystem(13);
    }
    
//    [view addSubview:label];
//    
//    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, maxY(label), width(self.view.frame), 1)];
//    lineLabel.backgroundColor = [UIColor lightGrayColor];
//    [view addSubview:lineLabel];
    return label;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 0) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width(self.view.frame), 20)];
        label.backgroundColor = [UIColor groupTableViewBackgroundColor];
        label.text = @"车型社区";
        label.font = FontSystem(15);
        return label;
    }
    
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return 20;
    }
    return 0.1;
}
#pragma mark -
#pragma mark 返回分区索引
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return _sectionTitles;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 100;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    if (indexPath.section == 0) {
        cell.imageView.image = [UIImage imageNamed:@"benz.png"];
        cell.textLabel.text = @"宝马";
    }else {
        cell.imageView.image = [UIImage imageNamed:@"benz.png"];
        cell.textLabel.text = @"雪弗兰";
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ClassifyDetailViewController *classifyDetailController = [[ClassifyDetailViewController alloc] init];
    if (indexPath.section == 0) {
        classifyDetailController.title = @"热门社区";
    }else {
        classifyDetailController.title = @"车型社区";
    }
    [self.navigationController pushViewController:classifyDetailController animated:YES];
}
//- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
//    
//    SHOW_TABLEALERT(title);
//    return index;
//}
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
