//
//  MyCollectionViewController.m
//  CSSYQuQi
//
//  Created by cssy-apple on 15/12/10.
//  Copyright © 2015年 cssy-apple. All rights reserved.
//

#import "MyCollectionViewController.h"
#import "MyCollectChooseCarView.h"
#import "MyCollectNewCarView.h"
#import "NewCarDetailViewController.h"
#import "ChooseDetailViewController.h"
#import "XLScrollViewer.h"

@interface MyCollectionViewController ()<XLIndexDelegate, MyCollectChooseCarDelegate, MyCollectNewCarDelegate> {
    MyCollectNewCarView *_newCarView;
    MyCollectChooseCarView *_chooseCarView;
    UIButton *_delButton;
    int _index;
}

@property (nonatomic, strong) XLScrollViewer *scroll;
@end

@implementation MyCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    [self initall];
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}
- (void)initall {
    _index = 0;
    [self createBackButton];
    [self createBgView];
    [self createDelButton];
    [self createEditButton];
    [self createScrollView];
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
- (void)createBgView {
    UILabel *bgLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width(self.view.frame), 30)];
    bgLabel.center = self.view.center;
    bgLabel.textAlignment = NSTextAlignmentCenter;
    bgLabel.textColor = [UIColor grayColor];
    bgLabel.text = CollectStr;
    bgLabel.font = FontSystem(15);
    [self.view addSubview:bgLabel];
}
- (void)createDelButton {
    _delButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _delButton.frame = CGRectMake(width(self.view.frame)-40, height(self.view.frame)-30, 40, 40);
    [_delButton setTitle:@"删除" forState:UIControlStateNormal];
    [_delButton setTitleColor:ZEBColor(26, 166, 255) forState:UIControlStateNormal];
    _delButton.titleLabel.font = FontSystem(15);
    [_delButton addTarget:self action:@selector(delButton:) forControlEvents:UIControlEventTouchUpInside];
    _delButton.alpha = 0.0;
    [self.view addSubview:_delButton];
}
- (void)delButton:(UIButton *)button {
    //多选删除的时候
    // 1>>首先获取多选选中的行
    // 2>>获取多选选中的行之后,对数组进行排序
    // 3>>从 index 下标最大的开始删除(即排完序的数组,从后往前删) (删除数据源)
    // 4>>从表示图删除选中的行
    if (_index == 0) {
        // 获取所有选中的行
        NSArray *indexPaths = [_newCarView.tableView indexPathsForSelectedRows];
        
        ZEBLog(@"-----------%@",indexPaths);
        //对数组进行排序
        indexPaths = [indexPaths sortedArrayUsingSelector:@selector(compare:)];
        //遍历删除
        ZEBLog(@"~~~~~~~~~~~~~after sorted %@",indexPaths);
//        for (NSInteger i = indexPaths.count - 1; i >= 0; i--) {
//            
//        }
        _newCarView.integer = _newCarView.integer - indexPaths.count;
        //从表示图删除选中的行
        [_newCarView.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationLeft];
    }else {
        // 获取所有选中的行
        NSArray *indexPaths = [_chooseCarView.tableView indexPathsForSelectedRows];
        
        ZEBLog(@"-----------%@",indexPaths);
        //对数组进行排序
        indexPaths = [indexPaths sortedArrayUsingSelector:@selector(compare:)];
        //遍历删除
        ZEBLog(@"~~~~~~~~~~~~~after sorted %@",indexPaths);
        //        for (NSInteger i = indexPaths.count - 1; i >= 0; i--) {
        //
        //        }
        _chooseCarView.integer = _chooseCarView.integer - indexPaths.count;
        //从表示图删除选中的行
        [_chooseCarView.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationLeft];
    }
    
}
- (void)createEditButton {
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(muiltEditorAction:)];
    barButtonItem.tintColor = ZEBColor(26, 166, 255);
    
    //给导航右边添加按钮
    self.navigationItem.rightBarButtonItem = barButtonItem;
}
- (void)muiltEditorAction:(UIBarButtonItem *)button {
    
    if (_index == 0) {
        
        if (!_newCarView.tableView.editing && [[button title] isEqualToString:@"编辑"]) {
            [button setTitle:@"取消"];
            //当它处于编辑状态的时候是否允许多选 默认是单选的 为 NO
            _newCarView.tableView.allowsMultipleSelectionDuringEditing = YES;
            
            //设置_ tableView 的编辑状态
            [_newCarView.tableView setEditing:YES animated:YES];
            ZEBLog(@"%d",_chooseCarView.tableView.multipleTouchEnabled);
            self.scroll.scroll1.scrollEnabled = NO;
            self.scroll.scroll2.scrollEnabled = NO;
            [self moveTop];
        }else {
            [button setTitle:@"编辑"];
            //当它处于编辑状态的时候是否允许多选 默认是单选的 为 NO
            _newCarView.tableView.allowsMultipleSelectionDuringEditing = NO;
            //设置_ tableView 的编辑状态
            [_newCarView.tableView setEditing:NO animated:YES];
            self.scroll.scroll1.scrollEnabled = YES;
            self.scroll.scroll2.scrollEnabled = YES;
            [self moveDown];
        }
    }else {
        if (!_chooseCarView.tableView.editing && [[button title] isEqualToString:@"编辑"]) {
            [button setTitle:@"取消"];
            //当它处于编辑状态的时候是否允许多选 默认是单选的 为 NO
            _chooseCarView.tableView.allowsMultipleSelectionDuringEditing = YES;
            ZEBLog(@"%d",_chooseCarView.tableView.multipleTouchEnabled);
            //设置_ tableView 的编辑状态
            [_chooseCarView.tableView setEditing:YES animated:YES];
            self.scroll.scroll1.scrollEnabled = NO;
            self.scroll.scroll2.scrollEnabled = NO;
            [self moveTop];
        }else {
            [button setTitle:@"编辑"];
            //当它处于编辑状态的时候是否允许多选 默认是单选的 为 NO
            _chooseCarView.tableView.allowsMultipleSelectionDuringEditing = NO;
            //设置_ tableView 的编辑状态
            [_chooseCarView.tableView setEditing:NO animated:YES];
            self.scroll.scroll1.scrollEnabled = YES;
            self.scroll.scroll2.scrollEnabled = YES;
            [self moveDown];
    }
    
    
    }
}
- (void)createScrollView {
    
    _newCarView = [[MyCollectNewCarView alloc] initWithFrame:CGRectMake(0, 0, width(self.view.frame), height(self.view.frame))];
    _newCarView.delegate = self;
    
    _chooseCarView = [[MyCollectChooseCarView alloc] initWithFrame:CGRectMake(0, 0, width(self.view.frame), height(self.view.frame))];
    _chooseCarView.delegate = self;
    
    CGRect frame =CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64);//如果没有导航栏，则去掉64
    
    NSArray *views = @[_newCarView,_chooseCarView];
    NSArray *titles = @[@"    新车    ",@"    找车    "];
    
    self.scroll =[XLScrollViewer scrollWithFrame:frame withViews:views withButtonNames:titles withThreeAnimation:222];//三中动画都不选择
    
    //自定义各种属性。
    //self.scroll.xl_topBackImage =[UIImage imageNamed:@"top_background.png"];
    self.scroll.xl_topBackColor =[UIColor whiteColor];
    self.scroll.xl_sliderColor = ZEBColor(26, 166, 255);
    self.scroll.xl_buttonColorNormal =[UIColor lightGrayColor];
    self.scroll.xl_buttonColorSelected = ZEBColor(26, 166, 255);
    self.scroll.xl_buttonFont =18;
    self.scroll.xl_buttonToSlider =2;
    self.scroll.xl_sliderHeight =2;
    self.scroll.xl_topHeight =30;
    self.scroll.xl_isSliderCorner =YES;
    self.scroll.indexDelegate = self;
    //加入控制器视图
    [self.view addSubview:self.scroll];
}
- (void)XLGaveIndex:(XLScrollViewer *)view index:(int)index {
    _index = index;
}
- (void)moveTop {
    [UIView animateWithDuration:0.5 animations:^{
        self.scroll.frame = CGRectMake(0, 34, WIN_WIDTH, WIN_HEIGHT-64);
        _delButton.alpha = 1.0;
    } completion:^(BOOL finished) {
        
    }];
}
- (void)moveDown {
    [UIView animateWithDuration:0.5 animations:^{
        self.scroll.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64);
        _delButton.alpha = 0.0;
    } completion:^(BOOL finished) {
        
    }];
}
- (void)myCollectNewCar:(MyCollectNewCarView *)controller {
    NewCarDetailViewController *newCarDetailController = [NewCarDetailViewController new];
    newCarDetailController.hidesBottomBarWhenPushed = YES;
    newCarDetailController.fromUI = @"我的收藏";
    newCarDetailController.title = @"详情";
    [self.navigationController pushViewController:newCarDetailController animated:YES];
}
- (void)mycollectChoose:(MyCollectChooseCarView *)controller {
    ChooseDetailViewController *chooseDetailController = [ChooseDetailViewController new];
    chooseDetailController.hidesBottomBarWhenPushed = YES;
    chooseDetailController.title = @"详情";
    [self.navigationController pushViewController:chooseDetailController animated:YES];
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
