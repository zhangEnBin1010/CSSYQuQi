//
//  ChooseCarViewController.m
//  CSSYQuQi
//
//  Created by cssy-apple on 15/11/19.
//  Copyright (c) 2015年 cssy-apple. All rights reserved.
//

#import "ChooseCarViewController.h"
#import "ChooseCarTableViewCell.h"
#import "CustomChooseTableView.h"
#import "ChooseDetailViewController.h"
#import "CustomTypeViewController.h"
#import "SliderView.h"
@interface ChooseCarViewController ()<CustomChooseSkipDetailDelegate, CustomTypeControllerDelegate> {

    UITableView *_tableView;
    NSArray *_sectionTitles;
}

@end

@implementation ChooseCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBarHidden = YES;
    [self initall];
}
- (void)initall {
    
    [self createScrollView];
    
}

- (void)createScrollView {

    CustomTypeViewController *typeView = [[CustomTypeViewController alloc] init];
    typeView.delegate = self;
    
    CustomChooseTableView *chooseView = [[CustomChooseTableView alloc] initWithFrame:CGRectMake(0, 0, width(self.view.frame), height(self.view.frame))];
    chooseView.cusChooseSkipDetailDelegate = self;
    
    
    CGRect frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);//如果没有导航栏，则去掉64
    
    NSArray *views = @[typeView.view,chooseView];
    NSArray *titles = @[@"车型",@"选车"];
    
    self.scroll =[XLScrollViewer scrollWithFrame:frame withViews:views withButtonNames:titles withThreeAnimation:111];//三中动画都选择
    
    //自定义各种属性。。
    //self.scroll.xl_topBackImage =[UIImage imageNamed:@"top_background.png"];
    self.scroll.xl_topBackColor =[UIColor whiteColor];
    //self.scroll.xl_sliderColor =[UIColor orangeColor];
    self.scroll.xl_buttonColorNormal =[UIColor lightGrayColor];
    self.scroll.xl_buttonColorSelected = ZEBColor(26, 166, 255);
    self.scroll.xl_showLine = YES;
    self.scroll.xl_buttonFont =18;
    self.scroll.xl_buttonToSlider =20;
    self.scroll.xl_sliderHeight =0;
    self.scroll.xl_topHeight =64;
    self.scroll.xl_isSliderCorner =YES;
    
    //加入控制器视图
    [self.view addSubview:self.scroll];
}
//选车
- (void)customChooseSkipDetail:(CustomChooseTableView *)view {
    ChooseDetailViewController *chooseDetailController = [ChooseDetailViewController new];
    chooseDetailController.hidesBottomBarWhenPushed = YES;
    chooseDetailController.title = @"详情";
    [self.navigationController pushViewController:chooseDetailController animated:YES];
    
}
//车型
- (void)customTypeController:(CustomTypeViewController *)controller {
    ChooseDetailViewController *chooseDetailController = [ChooseDetailViewController new];
    chooseDetailController.hidesBottomBarWhenPushed = YES;
    chooseDetailController.title = @"详情";
    [self.navigationController pushViewController:chooseDetailController animated:YES];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
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
