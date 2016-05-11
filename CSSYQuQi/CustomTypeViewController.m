//
//  CustomTypeViewController.m
//  CSSYQuQi
//
//  Created by cssy-apple on 15/12/25.
//  Copyright © 2015年 cssy-apple. All rights reserved.
//

#import "CustomTypeViewController.h"
#import "ChooseCarTableViewCell.h"
#import "SliderView.h"
@interface CustomTypeViewController () <UITableViewDataSource, UITableViewDelegate, ChooseCarSkipDetailDelegate, SliderSkipDelegate> {
    
    UITableView *_tableView;
    NSArray *_sectionTitles;
    
}

@end

@implementation CustomTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = NO;
    [self initall];
}
- (void)initall {
    _sectionTitles = @[@"#",@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"];
    [self createTableView];

}
//创建tableview
- (void)createTableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, width(self.view.frame), height(self.view.frame)-108) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
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

- (void)createLabel {
    if (_flotageLabel == nil) {
        _flotageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 75, 75)];
        _flotageLabel.center = self.view.center;
        _flotageLabel.backgroundColor = ZEBRGBA(18, 29, 49, 0.8);
        _flotageLabel.textAlignment = NSTextAlignmentCenter;
        _flotageLabel.textColor = [UIColor whiteColor];
        _flotageLabel.layer.cornerRadius = 5;
        _flotageLabel.hidden = YES;
        _flotageLabel.font = FontSystem(20);
        [self.view addSubview:_flotageLabel];
    }
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
    if (section == 0) {
        return 0.1;
    }
    return 25;
}
#pragma mark -
#pragma mark 返回头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return nil;
    }
    //    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width(self.frame), 50)];
    //    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    //
    //    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width(self.frame), 15)];
    //    topView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    //    [view addSubview:topView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0,0, width(self.view.frame), 25)];
    label.backgroundColor = [UIColor groupTableViewBackgroundColor];
    label.text = _sectionTitles[section];
    label.font = Font(15);
    //    [view addSubview:label];
    //
    //    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, maxY(label), width(self.frame), 1)];
    //    lineLabel.backgroundColor = [UIColor lightGrayColor];
    //    [view addSubview:lineLabel];
    return label;
}
#pragma mark -
#pragma mark 返回分区索引
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return _sectionTitles;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        CGFloat imageWidthMajor = (width(self.view.frame) - 4*Margin)/3;
        CGFloat imageWidth = (width(self.view.frame) - 10*Margin)/5;
        return 2*imageWidth + imageWidthMajor + 15
        *Margin;
    }
    return 100;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"identifier";
    static NSString *topIdentifier = @"topIdentifier";
    
    if (indexPath.section == 0) {
        ChooseCarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:topIdentifier];
        if (cell == nil) {
            cell = [[ChooseCarTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:topIdentifier];
        }
        cell.chooseCarSkipDetaelDelegate = self;
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    cell.imageView.image = [UIImage imageNamed:@"benz.png"];
    cell.textLabel.text = _sectionTitles[indexPath.section];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
    return cell;
}
//- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
//    self.flotageLabel.hidden = NO;
//    self.flotageLabel.text = title;
//    return index;
//}

//代理跳转页面
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return;
    }
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];
    SliderView *sliderView = [SliderView defaultInstanceView];
    [self.view addSubview:sliderView];
    sliderView.type = _sectionTitles[indexPath.section];
    sliderView.sliderDelegate = self;

}
//代理跳转页面
- (void)chooseCarSkipDetail:(ChooseCarTableViewCell *)cell string:(NSString *)title {

    SliderView *sliderView = [SliderView defaultInstanceView];
    [self.view addSubview:sliderView];
    sliderView.type = title;
    sliderView.sliderDelegate = self;
}
- (void)sliderSkip:(SliderView *)view {
    if (_delegate && [_delegate respondsToSelector:@selector(customTypeController:)]) {
        [_delegate customTypeController:self];
    }
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
