//
//  ChooseDetailViewController.m
//  CSSYQuQi
//
//  Created by cssy-apple on 15/11/27.
//  Copyright (c) 2015年 cssy-apple. All rights reserved.
//

#import "ChooseDetailViewController.h"
#import "ChooseDetailCell.h"
#import "ChooseDetailDownCell.h"
#import "XunJiaViewController.h"
#import "PhotoBroswerVC.h"
@interface ChooseDetailViewController ()<UITableViewDataSource, UITableViewDelegate, ChooseDetailDownDelegate, UIAlertViewDelegate, ChooseDetailDelegate> {
    UITableView *_tableView;
}

@property (nonatomic, strong) NSMutableArray *scrollViewOriginalImages;
@end

@implementation ChooseDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self initall];
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
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.toolbarHidden = NO;
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.toolbarHidden = YES;
    self.navigationController.navigationBarHidden = YES;
}
- (void)initall {
    self.scrollViewOriginalImages = [NSMutableArray array];
    [self createBackButton];
    [self createToolbar];

    [self createTableView];
}
- (void)createToolbar {
    self.navigationController.toolbar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"top_background.png"]];
    
    UIButton *collectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    collectButton.frame = CGRectMake(0, 0, 100, 25);
    [collectButton addTarget:self action:@selector(collectButton:) forControlEvents:UIControlEventTouchUpInside];
    [collectButton setTitle:@"⭐️" forState:UIControlStateNormal];
    [collectButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    collectButton.layer.cornerRadius = 5;
    [collectButton setBackgroundColor:[UIColor orangeColor]];
    collectButton.titleLabel.font = Font(13);
    UIBarButtonItem *collectBarButton = [[UIBarButtonItem alloc] initWithCustomView:collectButton];
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIButton *callButton = [UIButton buttonWithType:UIButtonTypeCustom];
    callButton.frame = CGRectMake(0, 0, 150, 25);
    [callButton addTarget:self action:@selector(callButton:) forControlEvents:UIControlEventTouchUpInside];
    [callButton setTitle:[NSString stringWithFormat:@"☎️ %@",PhoneNumber] forState:UIControlStateNormal];
    [callButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    callButton.layer.cornerRadius = 5;
    [callButton setBackgroundColor:[UIColor orangeColor]];
    callButton.titleLabel.font = Font(13);
    UIBarButtonItem *callBarButton = [[UIBarButtonItem alloc] initWithCustomView:callButton];
    self.toolbarItems = @[collectBarButton,barButtonItem,callBarButton];
}
- (void)collectButton:(UIButton *)button {
    if ([[NSUserDefaults standardUserDefaults] boolForKey:IsLogin]) {
        
    }else {
        SHOW_ALERT(@"请先登录！");
    }
}
- (void)callButton:(UIButton *)button {
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:IsLogin]) {
        
        UIAlertView *callAlertView = [[UIAlertView alloc]initWithTitle:nil message:PhoneNumber delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"呼叫"  , nil];
        [callAlertView show];
        
    }else {
        SHOW_ALERT(@"请先登录！");
    }
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSString *phoneCall = [NSString stringWithFormat:@"tel://%@",PhoneNumber];
    UIWebView *callWebView = [[UIWebView alloc] init];
    [callWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:phoneCall]]];
    [self.view addSubview:callWebView];
   
}
- (void)createTableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, width(self.view.frame), height(self.view.frame)-64) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.allowsSelection = NO;
        [self.view addSubview:_tableView];
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 10;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath    {
    if (indexPath.section == 0) {
        return 110;
    }
    return 120;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.1;
    }
    return 15;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width(self.view.frame), 15)];
    label.text = @"1.2L";
    label.font = [UIFont boldSystemFontOfSize:13];
    return label;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier1 = @"identifier1";
    static NSString *identifier2 = @"identifier2";
    if (indexPath.section == 0) {
        ChooseDetailCell *cell1 = [tableView dequeueReusableCellWithIdentifier:identifier1];
        if (cell1 == nil) {
            cell1 = [[ChooseDetailCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier1];
            cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell1.delegate = self;
        return cell1;
    }
    ChooseDetailDownCell *cell2 = [tableView dequeueReusableCellWithIdentifier:identifier2];
    if (cell2 == nil) {
        cell2 = [[ChooseDetailDownCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier2];
    }
    cell2.chooseDetailDownDelegate = self;
    return cell2;
    
}
- (void)chooseDetail:(ChooseDetailCell *)cell scrollViewOriginalImages:(NSMutableArray *)scrollViewOriginalImages{
    [self networkImageShow:0 scrollViewOriginalImages:scrollViewOriginalImages];
}

- (void)chooseDetailDown:(UITableViewCell *)cell {
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:IsLogin]) {
        XunJiaViewController *xunjiaViewController = [[XunJiaViewController alloc] init];
        xunjiaViewController.title = @"免费询价";
        [self.navigationController pushViewController:xunjiaViewController animated:YES];
    }else {
        SHOW_ALERT(@"请先登录！");
    }
    
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
