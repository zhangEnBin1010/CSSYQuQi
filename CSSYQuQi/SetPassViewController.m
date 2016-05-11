//
//  SetPassViewController.m
//  CSSYQuQi
//
//  Created by cssy-apple on 15/11/26.
//  Copyright (c) 2015年 cssy-apple. All rights reserved.
//

#import "SetPassViewController.h"
#import "DJRegisterView.h"
#import "PersonController.h"
@interface SetPassViewController ()

@end

@implementation SetPassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initall];
}
- (void)initall {
    [self createBackButton];
    [self createSetPassView];
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
    self.presentingViewController.view.alpha = 0.0;
    [self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (void)createSetPassView {
    DJRegisterView *djSetPassView = [[DJRegisterView alloc]
                                     initwithFrame:CGRectMake(0, 64, width(self.view.frame), height(self.view.frame)-64) action:^(NSString *key1, NSString *key2) {
                                         
                                         if (key1.length < 6 || key2.length < 6) {
                                             SHOW_ALERT(@"你输入的密码不足六位，请重新输入！");
                                             return;
                                         }
                                         if (![key1 isEqualToString:key2]) {
                                             SHOW_ALERT(@"两次输入不同，请重新输入！");
                                             return;
                                         }
                                         ZEBLog(@"%@%@",key1,key2);
                                         
                                     }];
    [self.view addSubview:djSetPassView];
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
