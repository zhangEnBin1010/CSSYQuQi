//
//  PersonController.m
//  CSSYQuQi
//
//  Created by cssy-apple on 15/11/19.
//  Copyright (c) 2015年 cssy-apple. All rights reserved.
//

#import "PersonController.h"
#import "LoginViewController.h"
#import "PersonInfoViewController.h"
#import "SetViewController.h"
#import "MyCollectionViewController.h"
#import "MyOrderViewController.h"

@interface PersonController ()<UITableViewDataSource, UITableViewDelegate> {
    UITableView *_tableView;
    UIImageView *_userImageView;
   
}

@end

@implementation PersonController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self initall];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (_tableView != nil) {
        [_tableView reloadData];
    }
}
- (void)initall {
    [self createTableView];
}
//创建tableview
- (void)createTableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, width(self.view.frame), height(self.view.frame)-64) style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.scrollEnabled = NO;
        [self.view addSubview:_tableView];
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 200;
    }
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5;
}
//头视图用户图像
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width(self.view.frame), 200)];
        imageView.userInteractionEnabled = YES;
        imageView.image = [UIImage imageNamed:@"my_background.png"];
        
        if ([[NSUserDefaults standardUserDefaults] boolForKey:IsLogin]) {
             NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage.png"];
            
            _userImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
            _userImageView.clipsToBounds = YES;
            _userImageView.layer.cornerRadius = 40;
            if ([UIImage imageWithData:[NSData dataWithContentsOfFile:fullPath]] == nil) {
                _userImageView.image = [UIImage imageNamed:@"girl.png"];
            }else {
                _userImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfFile:fullPath]];
            }
            _userImageView.center = imageView.center;
            _userImageView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
            [_userImageView addGestureRecognizer:tap];
            [imageView addSubview:_userImageView];
            
            
            UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(minX(_userImageView), maxY(_userImageView), 80, 20)];
            nameLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:UserNickname];
            nameLabel.textAlignment = NSTextAlignmentCenter;
            nameLabel.adjustsFontSizeToFitWidth = YES;
            nameLabel.textColor = [UIColor blackColor];
            nameLabel.font = Font(15);
            nameLabel.alpha = 0.6;
            [imageView addSubview:nameLabel];
        
        }else {
            UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
            bgView.center = imageView.center;
            bgView.backgroundColor = [UIColor blackColor];
            bgView.alpha = 0.2;
            bgView.layer.borderWidth = 1;
            bgView.layer.cornerRadius = 5;
            [imageView addSubview:bgView];
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(0, 0, 100, 30);
            button.center = imageView.center;
            [button setTitle:@"立即登录" forState:UIControlStateNormal];
            [button addTarget:self action:@selector(LoginBtton:) forControlEvents:UIControlEventTouchUpInside];
            button.layer.borderWidth = 1;
            button.layer.borderColor = [[UIColor whiteColor] CGColor];
            button.layer.cornerRadius = 5;
            button.titleLabel.font = FontSystem(18);
            [imageView addSubview:button];
        }
        return imageView;
    }
    return nil;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    cell.textLabel.font = FontSystem(15);
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.section == 0) {
        cell.textLabel.text = @"我的收藏";
        
        cell.imageView.image = [UIImage imageNamed:@"collect.png"];
    }else if (indexPath.section == 1) {
        cell.textLabel.text = @"我的订单";
        cell.imageView.image = [UIImage imageNamed:@"order.png"];
    }else {
        cell.textLabel.text = @"设置";
        cell.imageView.image = [UIImage imageNamed:@"set.png"];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        
            MyCollectionViewController *mycollectController = [[MyCollectionViewController alloc] init];
            mycollectController.hidesBottomBarWhenPushed = YES;
            mycollectController.title = @"我的收藏";
            [self.navigationController pushViewController:mycollectController animated:YES];
       
    }else if (indexPath.section == 1) {
        MyOrderViewController *myOrderController = [MyOrderViewController new];
        myOrderController.title = @"我的订单";
        myOrderController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:myOrderController animated:YES];
    }else if (indexPath.section == 2) {
        SetViewController *setController = [SetViewController new];
        setController.title = @"设置";
        UINavigationController *setControllerNav = [[UINavigationController alloc] initWithRootViewController:setController];
        [self presentViewController:setControllerNav animated:YES completion:^{
            
        }];
    }
}
- (void)LoginBtton:(UIButton *)button {
    LoginViewController *loginController = [LoginViewController new];
    UINavigationController *navLogin = [[UINavigationController alloc] initWithRootViewController:loginController];
    loginController.title = @"登录";
    navLogin.modalTransitionStyle = 1;
    [self presentViewController:navLogin animated:YES completion:^{
        
    }];
}

- (void)tapClick:(UITapGestureRecognizer *)recognizer {
    PersonInfoViewController *personInfoController = [PersonInfoViewController new];
    UINavigationController *infoNav = [[UINavigationController alloc] initWithRootViewController:personInfoController];
    infoNav.modalTransitionStyle = 0;
    personInfoController.title = @"个人资料";
    [self presentViewController:infoNav animated:YES completion:^{
        
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
