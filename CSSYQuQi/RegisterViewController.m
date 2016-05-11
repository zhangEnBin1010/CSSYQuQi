//
//  RegisterViewController.m
//  CSSYQuQi
//
//  Created by cssy-apple on 15/11/26.
//  Copyright (c) 2015年 cssy-apple. All rights reserved.
//

#import "RegisterViewController.h"
#import "DJRegisterView.h"
#import "SetPassViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initall];
}
- (void)initall {
    [self createBackButton];
    [self createRegisterView];
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
- (void)createRegisterView {
    DJRegisterView *djzcView = [[DJRegisterView alloc] initwithFrame:CGRectMake(0, 64, width(self.view.frame), height(self.view.frame)-64) plUserName:@"请输入昵称" plTitle:@"请输入获取的验证码" title:@"注册" plKey1:@"请输入密码" plKey2:@"请再次输入密码" hq:^BOOL(NSString *phoneStr) {
        if (phoneStr.length != 11) {
            SHOW_ALERT(@"请输入正确的手机号！");
            return NO;
        }
        return YES;
    } tjAction:^(NSString *userName, NSString *phoneStr, NSString *yzmStr, NSString *key1, NSString *key2) {
        
        ZEBLog(@"%@---%@---%@---%@---%@",userName,phoneStr,yzmStr,key1,key2);
        if (![userName isEqualToString:@""]) {
            [[NSUserDefaults standardUserDefaults] setObject:userName forKey:UserNickname];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:ChangeNickOnce];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }else {
            SHOW_ALERT(@"请输入昵称！");
            return;
        }
        
        if (key1.length < 6 || key2.length < 6) {
            SHOW_ALERT(@"你输入的密码不足六位，请重新输入！");
            return;
        }
        if (![key1 isEqualToString:key2]) {
            SHOW_ALERT(@"两次输入密码不同，请重新输入！");
            return;
        }
        if (yzmStr.length == 0) {
            SHOW_ALERT(@"请输入验证码！");
            return;
        }
        
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }];
    [self.view addSubview:djzcView];
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
