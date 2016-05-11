//
//  SetViewController.m
//  CSSYQuQi
//
//  Created by cssy-apple on 15/12/8.
//  Copyright © 2015年 cssy-apple. All rights reserved.
//

#import "SetViewController.h"
#import "SetTableViewCell.h"
#import "IdeaViewController.h"
#import "AboutViewController.h"
#import "IntroductionView.h"

@interface SetViewController ()<UITableViewDataSource, UITableViewDelegate, IntroductionViewDelegate> {
    UITableView *_tableView;
}

@end

@implementation SetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self initall];
}
- (void)initall {
    [self createBackButton];
    [self createTabelView];
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
- (void)createTabelView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, width(self.view.frame), height(self.view.frame)-64) style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.scrollEnabled = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        [self.view addSubview:_tableView];
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([[NSUserDefaults standardUserDefaults] boolForKey:IsLogin]) {
       return 4;
    }
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0 || section == 2) {
        return 2;
    }
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if ([[NSUserDefaults standardUserDefaults] boolForKey:IsLogin]) {
        if (section == 3) {
            return 15;
        }
    }
    
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"identifier";
    static NSString *quit = @"quit";
    if ([[NSUserDefaults standardUserDefaults] boolForKey:IsLogin]) {
        if (indexPath.section == 3) {
            SetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:quit];
            if (cell == nil) {
                cell = [[SetTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:quit];
            }
            return cell;
        }
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    //cell
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    NSArray *nameArray = @[@"推荐给好友",@"欢迎页",@"清除缓存",@"意见反馈",@"关于"];
    if (indexPath.section == 0 && indexPath.row == 0) {
        cell.textLabel.text = nameArray[0];
    }else if (indexPath.section == 0 && indexPath.row == 1) {
        cell.textLabel.text = nameArray[1];
    }else if (indexPath.section == 1 && indexPath.row == 0) {
        cell.textLabel.text = nameArray[2];
    }else if (indexPath.section == 2 && indexPath.row == 0) {
        cell.textLabel.text = nameArray[3];
    }else if (indexPath.section == 2 && indexPath.row == 1) {
        cell.textLabel.text = nameArray[4];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0 && indexPath.row == 0) {
        NSString *shareText = @"友盟社会化组件可以让移动应用快速具备社会化分享、登录、评论、喜欢等功能，并提供实时、全面的社会化数据统计分析服务。 http://www.csjtw.com.cn/";             //分享内嵌文字
        UIImage *shareImage = [UIImage imageNamed:@"UMS_social_demo"];          //分享内嵌图片
        
        //调用快速分享接口
        [UMSocialSnsService presentSnsIconSheetView:self
                                             appKey:UmengAppkey
                                          shareText:shareText
                                         shareImage:shareImage
                                    shareToSnsNames:@[UMShareToSina,UMShareToQzone,UMShareToWechatTimeline]
                                           delegate:nil];

    }else if (indexPath.section == 0 && indexPath.row == 1) {
        self.navigationController.navigationBarHidden = YES;
        IntroductionView *introductionView = [[IntroductionView alloc] initWithFrame:self.view.bounds];
        introductionView.delegate = self;
        introductionView.alpha = 0.0;
        [self.view addSubview:introductionView];
        [UIView animateWithDuration:0.5 animations:^{
            introductionView.alpha = 1.0;
        } completion:^(BOOL finished) {
            
        }];
        
    }else if (indexPath.section == 1 && indexPath.row == 0) {
        
    }else if (indexPath.section == 2 && indexPath.row == 0) {
        //跳转意见反馈界面
        IdeaViewController *ideaController = [IdeaViewController new];
        ideaController.title = @"意见反馈";
        [self.navigationController pushViewController:ideaController animated:YES];
    }else if (indexPath.section == 2 && indexPath.row == 1) {
        //跳转关于界面
        AboutViewController *aboutController = [[AboutViewController alloc] init];
        aboutController.title = @"关于";
        [self.navigationController pushViewController:aboutController animated:YES];
    }else if (indexPath.section == 3 && indexPath.row == 0) {
        //创建弹出控制图
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"确定退出登录？" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *alertYes = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:IsLogin];
            [[NSUserDefaults standardUserDefaults] synchronize];
            SHOW_ALERT(@"退出成功！");
            [_tableView reloadData];
            
        }];
        UIAlertAction *alertNo = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"没有退出！");
        }];
        [alertController addAction:alertYes];
        [alertController addAction:alertNo];
        
        [self presentViewController:alertController animated:YES completion:^{
            
        }];
    }
}
- (void)introductionView:(IntroductionView *)view button:(UIButton *)button{
    [UIView animateWithDuration:0.5 animations:^{
        view.alpha = 0.0;
    } completion:^(BOOL finished) {
        self.navigationController.navigationBarHidden = NO;
        
        [view removeFromSuperview];
        
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
