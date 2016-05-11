//
//  AboutViewController.m
//  CSSYQuQi
//
//  Created by cssy-apple on 15/12/9.
//  Copyright © 2015年 cssy-apple. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController () {
    UILabel *_logoLabel;
}

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self initall];
}
- (void)initall {
    [self createBackButton];
    [self createLogoView];
    [self createAboutUsView];
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
- (void)createLogoView {
    
    UIImageView *logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    logoImageView.center = CGPointMake(width(self.view.frame)/2, 164-30);
    logoImageView.image = [UIImage imageNamed:@"logo.png"];
    [self.view addSubview:logoImageView];
    
    _logoLabel = [[UILabel alloc] initWithFrame:CGRectMake(minX(logoImageView), maxY(logoImageView)+Margin/2, width(logoImageView.frame), 20)];
    _logoLabel.text = @"娶车网";
    _logoLabel.font = FontSystem(13);
    _logoLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_logoLabel];
}
- (void)createAboutUsView {

    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, maxY(_logoLabel)+30, width(self.view.frame), height(self.view.frame)-365-80)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    UILabel *aboutUsLabel = [[UILabel alloc] initWithFrame:CGRectMake(Margin, Margin, 100, 20)];
    aboutUsLabel.text = @"公司简介：";
    aboutUsLabel.font = FontSystem(12);
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(Margin, maxY(aboutUsLabel), width(self.view.frame)-2*Margin, height(view.frame)-3*Margin-20)];
    textView.text = Company_Introduction;
    textView.font = Font(13);
    textView.textColor = [UIColor lightGrayColor];
    textView.editable = NO;
    [view addSubview:aboutUsLabel];
    [view addSubview:textView];
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
