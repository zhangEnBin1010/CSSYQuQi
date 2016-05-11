//
//  BigTuxiangViewController.m
//  CSSYQuQi
//
//  Created by cssy-apple on 15/12/29.
//  Copyright © 2015年 cssy-apple. All rights reserved.
//

#import "BigTuxiangViewController.h"

@interface BigTuxiangViewController () {
    UIView *_topView;
    UIView *_buttomView;
    UIButton *_backButton;
    BOOL _two;
}

@end

@implementation BigTuxiangViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self initall];
    }
- (void)initall {
    [self createTap];
    [self createTopView];
    [self createButtomView];
}
- (void)setUrl:(NSString *)url {
    _url = url;
    [self createImage];
}
- (void)createTopView {
    _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width(self.view.frame), 64)];
    _topView.backgroundColor = ZEBColor(30, 32, 40);
    _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _backButton.frame = CGRectMake(20, 20, 30, 30);
    [_backButton setTitle:@"<" forState:UIControlStateNormal];
    [_backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_backButton addTarget:self action:@selector(backButton) forControlEvents:UIControlEventTouchUpInside];
    [_topView addSubview:_backButton];
    [self.view addSubview:_topView];
}
- (void)backButton {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)createButtomView {
    _buttomView = [[UIView alloc] initWithFrame:CGRectMake(0, height(self.view.frame)-44, width(self.view.frame), 44)];
    _buttomView.backgroundColor = ZEBColor(30, 32, 40);
    [self.view addSubview:_buttomView];
}
- (void)createTap {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
    [self.view addGestureRecognizer:tap];
}
- (void)tapClick {
    if (_two) {
        [UIView animateWithDuration:0.5 animations:^{
            _topView.frame = CGRectMake(0, 0, width(self.view.frame), 64);
            _buttomView.frame = CGRectMake(0, height(self.view.frame)-44, width(self.view.frame), 44);
            _backButton.frame = CGRectMake(20, 20, 30, 30);
        } completion:^(BOOL finished) {
            _two = NO;
        }];
    }else {
        [UIView animateWithDuration:0.5 animations:^{
            _topView.frame = CGRectMake(0, 0, width(self.view.frame), 0);
            _buttomView.frame = CGRectMake(0, height(self.view.frame), width(self.view.frame), 0);
            _backButton.frame = CGRectMake(20, 0, 0, 0);
        } completion:^(BOOL finished) {
            _two = YES;
        }];
        
    }
}
- (void)createImage {
    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:_url]];
    image.frame = CGRectMake(0, 0, 200, 200);
    image.center = self.view.center;
    image.cornerRadius = 5;
    [self.view addSubview:image];
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
