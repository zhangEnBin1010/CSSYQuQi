//
//  LoginViewController.m
//  CSSYQuQi
//
//  Created by cssy-apple on 15/11/26.
//  Copyright (c) 2015年 cssy-apple. All rights reserved.
//

#import "LoginViewController.h"
#import "DJRegisterView.h"
#import "RegisterViewController.h"
#import "LookPassViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initall];
}
- (void)initall {
    [self createBackButton];
    [self createLoginView];
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
- (void)createLoginView {
    DJRegisterView *registerView = [[DJRegisterView alloc]
                                    initwithFrame:
                                    CGRectMake(0, 64, width(self.view.frame), height(self.view.frame)-64)
                                    djRegisterViewType:DJRegisterViewTypeNav action:^(NSString *acc, NSString *key) {
                                        //用户是否登录
                                        if ([[NSUserDefaults standardUserDefaults] boolForKey:IsLogin]) {
                                            
                                        }else {
                                            
                                            if (acc.length != 11) {
                                                SHOW_ALERT(@"请输入手机号!");
                                                return;
                                            }
                                            if (!(key.length >= 6)) {
                                                SHOW_ALERT(@"密码不正确！");
                                                return;
                                            }
                                            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:IsLogin];
                                            [[NSUserDefaults standardUserDefaults] synchronize];
                                            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
                                            // 创建一个参数字典
                                            NSMutableDictionary *params = [NSMutableDictionary dictionary];
                                            [params setObject:acc forKey:@"txtUserName"];
                                            [params setObject:MD5Hash(key) forKey:@"txtPassword"];
                                            if (![[NSUserDefaults standardUserDefaults] boolForKey:ChangeNickOnce] || ![[[NSUserDefaults standardUserDefaults] objectForKey:UserName] isEqualToString:acc]) {
                                                
                                                [[NSUserDefaults standardUserDefaults] setObject:acc forKey:UserNickname];
                                                [[NSUserDefaults standardUserDefaults] synchronize];
                                                
                                            }
                                            //账户存在沙盒
                                            [[NSUserDefaults standardUserDefaults] setObject:acc forKey:UserName];
                                            [[NSUserDefaults standardUserDefaults] synchronize];
                                            
                                            
                                            if (![[[NSUserDefaults standardUserDefaults] objectForKey:UserPassWord] isEqualToString:key]) {
                                                //密码存在沙盒
                                                [[NSUserDefaults standardUserDefaults] setObject:MD5Hash(key) forKey:UserPassWord];
                                                [[NSUserDefaults standardUserDefaults] synchronize];
                                            }
                                            //post方法
                                            [manager POST:URL_ZEBLogin parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                
                                            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                NSLog(@"网络连接失败");
                                                NSLog(@"~~~~~~~~~~~~~~%@", error);
                                            }];
                                            
                                            SHOW_ALERT(@"登录成功！");
                                            ZEBLog(@"点击了登录");
                                            ZEBLog(@"\n输入的账户%@\n密码%@",acc,key);
                                            [self dismissViewControllerAnimated:YES completion:^{
                                               
                                            }];
                                            
                                        }
                                        
                                       
                                    } zcAction:^{
                                        RegisterViewController *registerController = [RegisterViewController new];
                                        UINavigationController *navRegister = [[UINavigationController alloc] initWithRootViewController:registerController];
                                        registerController.title = @"注册";
                                        navRegister.modalTransitionStyle = 0;
                                        [self presentViewController:navRegister animated:YES completion:nil];
                                    } wjAction:^{
                                        LookPassViewController *lookPassController = [LookPassViewController new];
                                        UINavigationController *navlookPass = [[UINavigationController alloc] initWithRootViewController:lookPassController];
                                        lookPassController.title = @"找回密码";
                                        lookPassController.modalTransitionStyle = 0;
                                        [self presentViewController:navlookPass animated:YES completion:nil];
                                    }];
    
    [self.view addSubview:registerView];
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
