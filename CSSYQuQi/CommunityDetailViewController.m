//
//  CommunityDetailViewController.m
//  CSSYQuQi
//
//  Created by cssy-apple on 15/11/25.
//  Copyright (c) 2015年 cssy-apple. All rights reserved.
//

#import "CommunityDetailViewController.h"
#import "CommunityDetailTableViewCell.h"
#import "CommunityDetailDownCell.h"
#import "MineCommentViewController.h"
#import "LoginViewController.h"

@interface CommunityDetailViewController ()<UITableViewDelegate, UITableViewDataSource, UMSocialDataDelegate, UMSocialUIDelegate> {
    UITableView *_tableView;
}

@end

@implementation CommunityDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initall];
}
- (void)initall {
    [self createBackButton];
    [self createTableView];
    [self createButtomBar];
    [self createShareButton];
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
//分享
- (void)createShareButton {
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    shareButton.frame = CGRectMake(0, 0, 30, 30);
    [shareButton setBackgroundImage:[UIImage imageNamed:@"share_low.png"] forState:UIControlStateNormal];
    [shareButton setBackgroundImage:[UIImage imageNamed:@"share_hight.png"] forState:UIControlStateHighlighted];
    [shareButton addTarget:self action:@selector(shareButton:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:shareButton];
    self.navigationItem.rightBarButtonItem = barButtonItem;
}

//创建下方的点赞和发表评论按钮
- (void)createButtomBar {
    CGFloat margin = 10;
    UIView *buttomView = [[UIView alloc] initWithFrame:CGRectMake(0, height(self.view.frame)-50, width(self.view.frame), 50)];
    [self.view addSubview:buttomView];
    
    UIButton *loveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    loveButton.frame = CGRectMake(margin, 5+margin, 30, 30);
    [loveButton addTarget:self action:@selector(loveButton:) forControlEvents:UIControlEventTouchUpInside];
    [loveButton setBackgroundImage:[UIImage imageNamed:@"love_low.png"] forState:UIControlStateNormal];
    [loveButton setBackgroundImage:[UIImage imageNamed:@"love_hight.png"] forState:UIControlStateHighlighted];
    [buttomView addSubview:loveButton];
    
    UIButton *replyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    replyButton.frame = CGRectMake(2*margin+maxX(loveButton),5+margin, width(buttomView.frame)-40-4*margin, 25);
    [replyButton addTarget:self action:@selector(replyButton:) forControlEvents:UIControlEventTouchUpInside];
    [replyButton setTitle:@"我要说两句..." forState:UIControlStateNormal];
    replyButton.titleLabel.font = Font(13);
    [replyButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    replyButton.layer.borderWidth = 0.8;
    replyButton.layer.borderColor = [[UIColor brownColor] CGColor];
    replyButton.layer.cornerRadius = 6;
    [buttomView addSubview:replyButton];
    
}
#pragma mark
#pragma mark - 分享
- (void)shareButton:(UIButton *)button {
    if ([[NSUserDefaults standardUserDefaults] boolForKey:IsLogin]) {
        NSString *shareText = @"友盟社会化组件可以让移动应用快速具备社会化分享、登录、评论、喜欢等功能，并提供实时、全面的社会化数据统计分析服务。 http://www.csjtw.com.cn/";             //分享内嵌文字
        UIImage *shareImage = [UIImage imageNamed:@"UMS_social_demo"];          //分享内嵌图片
        
        //调用快速分享接口
        [UMSocialSnsService presentSnsIconSheetView:self
                                             appKey:UmengAppkey
                                          shareText:shareText
                                         shareImage:shareImage
                                    shareToSnsNames:@[UMShareToSina,UMShareToQzone,UMShareToWechatTimeline]
                                           delegate:self];
       
    }else {
        SHOW_ALERT(@"请先登录！");
    }
}
- (void)didFinishGetUMSocialDataResponse:(UMSocialResponseEntity *)response {
    ZEBLog(@"%@",response);
}
//下面得到分享完成的回调
- (void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    NSLog(@"didFinishGetUMSocialDataInViewController with response is %@",response);
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        SHOW_ALERT(@"分享成功！");
        //得到分享到的微博平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }else {
        SHOW_ALERT(@"分享失败！");
    }
}

#pragma mark
#pragma mark - 评论
- (void)replyButton:(UIButton *)button {
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:IsLogin]) {
        
        MineCommentViewController *commentController = [MineCommentViewController new];
        
        UINavigationController *commentNav = [[UINavigationController alloc] initWithRootViewController:commentController];
        commentController.fromUI = @"评论";
         commentController.viewTitle = @"我要点评";
        
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

#pragma mark
#pragma mark - 点赞
- (void)loveButton:(UIButton *)button {
    if ([[NSUserDefaults standardUserDefaults] boolForKey:IsLogin]) {
        
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
- (void)createTableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, width(self.view.frame), height(self.view.frame)-44) style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.showsVerticalScrollIndicator =NO;
        _tableView.allowsSelection = NO;
        [self.view addSubview:_tableView];
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 600;
    }
    return 200;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else {
        return 5;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"identifier";
    static NSString *identifier1 = @"identifier1";
    if (indexPath.section == 0) {
        CommunityDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[CommunityDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        }
        return cell;
    }
    CommunityDetailDownCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
    if (cell == nil) {
        cell = [[CommunityDetailDownCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier1];
    }
    return cell;
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
