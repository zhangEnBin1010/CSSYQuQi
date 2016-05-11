//
//  LookPassViewController.m
//  CSSYQuQi
//
//  Created by cssy-apple on 15/11/26.
//  Copyright (c) 2015年 cssy-apple. All rights reserved.
//

#import "LookPassViewController.h"
#import "DJRegisterView.h"
#import "SetPassViewController.h"

@interface LookPassViewController ()

@end

@implementation LookPassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initall];
}
- (void)initall {
    [self createBackButton];
    [self createLookPassView];
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
- (void)createLookPassView {
    DJRegisterView *djzcView = [[DJRegisterView alloc]
                                initwithFrame:CGRectMake(0, 64, width(self.view.frame), height(self.view.frame)-64) plTitle:@"请输入获取的验证码"
                                title:@"下一步"
                                
                                hq:^BOOL(NSString *phoneStr) {
                                    
                                    if (phoneStr.length != 11) {
                                        SHOW_ALERT(@"请输入正确的手机号！");
                                        return NO;
                                    }
                                    return YES;
                                }
                                
                                tjAction:^(NSString *phoneStr,NSString *yzmStr) {
                                    
                                    if (yzmStr.length == 0) {
                                        SHOW_ALERT(@"请输入验证码！");
                                        return;
                                    }
                                    SetPassViewController *setPassController = [SetPassViewController new];
                                    UINavigationController *navSetPass = [[UINavigationController alloc] initWithRootViewController:setPassController];
                                    setPassController.title = @"设置密码";
                                    navSetPass.modalTransitionStyle = 2;
                                    [self presentViewController:navSetPass animated:YES completion:nil];
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
