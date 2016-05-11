//
//  SliderView.m
//  CSSYQuQi
//
//  Created by cssy-apple on 15/11/27.
//  Copyright (c) 2015年 cssy-apple. All rights reserved.
//

#import "SliderView.h"
#import "CustomChooseTableViewCell.h"
@implementation SliderView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.frame = frame;
        self.myFrame = frame;
        [self createSwipe];
    }
    return self;
}
//单利
+ (SliderView *)defaultInstanceView {
    static SliderView *sliderView = nil;
    @synchronized (self) {
        if (sliderView == nil) {
            sliderView = [[self alloc] initWithFrame:CGRectMake(100, 64, screenWidth()-99, screenHeight()-108)];
        }
    }
    return sliderView;
}
//添加滑动手势
- (void)createSwipe {
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeView:)];
    swipe.delegate = self;
    [self addGestureRecognizer:swipe];
}
//解决swipe与scrollview事件的冲突问题
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(nonnull UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}
//侧栏抽屉关闭
- (void)swipeView:(UISwipeGestureRecognizer *)recognizer {
    
    if (_isOpen) {
        if (recognizer.direction == UISwipeGestureRecognizerDirectionRight) {
            [UIView animateWithDuration:0.5 animations:^{
                self.frame = CGRectMake(screenWidth(), 64, 0, screenHeight()-108);
            } completion:^(BOOL finished) {
                _isOpen = NO;
                [self removeFromSuperview];
               
            }];
        }
    }
    
    
}
- (void)setType:(NSString *)type {
    _type = type;
    if (self.tableView != nil) {
        [_tableView.header beginRefreshing];
        [self.tableView reloadData];
    }else {
        [self initall];
    }
    [self openSliderView];
}
- (void)initall {
    
    CALayer *leftLayer = [CALayer layer];
    leftLayer.backgroundColor = [UIColor lightGrayColor].CGColor;
    leftLayer.bounds = CGRectMake(0, 0, 0.6, height(self.frame));
    leftLayer.position = CGPointMake(0, height(self.frame)/2);
    [self.layer addSublayer:leftLayer];
    
    [self createTableView];
    
}

//打开侧栏抽屉
- (void)openSliderView {
    if (!_isOpen) {
        self.frame = CGRectMake(screenWidth(), 64, 0, screenHeight()-108);
        [UIView animateWithDuration:0.5 animations:^{
            self.frame = self.myFrame;
        } completion:^(BOOL finished) {
            _isOpen = YES;
        }];
    }
    
}
//创建tableview
- (void)createTableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, width(self.frame), height(self.frame)) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self addSubview:_tableView];
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
    [MBProgressHUD showMessage:@"努力加载中..." toView:self dimBackground:NO];
    if (!isMore) {
        [_tableView.header endRefreshing];
    }else {
        [_tableView.footer endRefreshing];
    }
    [MBProgressHUD hideHUDForView:self animated:YES];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 10;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 64, width(self.frame), 50)];
//    view.backgroundColor = [UIColor whiteColor];
//    
//    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width(self.frame), 15)];
//    topView.backgroundColor = [UIColor groupTableViewBackgroundColor];
//    [view addSubview:topView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width(self.frame), 25)];
    label.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    label.text = _type;
    
    label.font = FontSystem(13);
//    [view addSubview:label];
//    
//    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, maxY(label), width(self.frame), 1)];
//    lineLabel.backgroundColor = [UIColor lightGrayColor];
//    [view addSubview:lineLabel];
    return label;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 25;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 100;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"identifier";
    CustomChooseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[CustomChooseTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    cell.name = @"雪弗兰";
    return cell;
}
//代理跳转详情界面
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (_sliderDelegate && [_sliderDelegate respondsToSelector:@selector(sliderSkip:)]) {
        [_sliderDelegate sliderSkip:self];
    }
    
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
