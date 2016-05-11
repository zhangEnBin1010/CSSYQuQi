//
//  NickNameViewController.m
//  CSSYQuQi
//
//  Created by cssy-apple on 15/12/8.
//  Copyright © 2015年 cssy-apple. All rights reserved.
//

#import "NickNameViewController.h"

@interface NickNameViewController ()<UITextFieldDelegate> {
    UITextField *_nickNameText;
}

@end

@implementation NickNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initall];
}
- (void)initall {
    [self createRightButton];
    [self createTextField];
}
- (void)createRightButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 40, 40);
    [button setTitle:@"保存" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(replyButton:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = rightBarButton;
}
//保存信息
- (void)replyButton:(UIButton *)button {
    if (![_nickNameText.text isEqualToString:@""]) {
        [[NSUserDefaults standardUserDefaults] setObject:_nickNameText.text forKey:UserNickname];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:ChangeNickOnce];
        [[NSUserDefaults standardUserDefaults] synchronize];
        SHOW_ALERT(@"保存成功！");
    }else {
        SHOW_ALERT(@"请输入昵称！");
    }
    
}
- (void)createTextField {
    
    _nickNameText = [[UITextField alloc] initWithFrame:CGRectMake(Margin+5, 64, width(self.view.frame)-2*Margin-10, 40)];
    _nickNameText.text = [[NSUserDefaults standardUserDefaults] objectForKey:UserNickname];
    _nickNameText.delegate = self;
    _nickNameText.placeholder = @"请输入昵称";
    [_nickNameText becomeFirstResponder];
    _nickNameText.clearButtonMode = UITextFieldViewModeAlways;
    [self.view addSubview:_nickNameText];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(Margin+5, maxY(_nickNameText), width(_nickNameText.frame), 1)];
    label.backgroundColor = [UIColor brownColor];
    [self.view addSubview:label];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSString *toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (toBeString.length <= 12) {
        return YES;
    }
    
    return NO;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return YES;
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
