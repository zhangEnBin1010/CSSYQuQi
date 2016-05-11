//
//  IdeaViewController.m
//  CSSYQuQi
//
//  Created by cssy-apple on 15/12/8.
//  Copyright © 2015年 cssy-apple. All rights reserved.
//

#import "IdeaViewController.h"


#define DefaultStr @"请留下你的宝贵意见"
#define DefaultFieldStr @"请留下你的手机号或QQ"
@interface IdeaViewController ()<UITextFieldDelegate, UITextViewDelegate> {
    UITextField *_textField;
    UITextView *_textView;
    CGRect _viewRect;
}

@end

@implementation IdeaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initall];
}
- (void)initall {
    [self createBackButton];
    [self createRightButton];
    [self createView];
    
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
- (void)createRightButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 40, 40);
    [button setTitle:@"提交" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(replyButton:) forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = FontSystem(15);
    [button setTitleColor:ZEBColor(26, 166, 255) forState:UIControlStateNormal];
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    self.navigationItem.rightBarButtonItem = rightBarButton;
}
//提交信息
- (void)replyButton:(UIButton *)button {
    
}
- (void)createView {
    
    UILabel *label = [UILabel new];
    label.frame = CGRectMake(0, 64, width(self.view.frame), 35);
    label.text = @" 反馈内容:";
    label.backgroundColor = [UIColor groupTableViewBackgroundColor];
    label.font = Font(15);
    [self.view addSubview:label];
    
    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, maxY(label), width(self.view.frame), 1)];
    lineLabel.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:lineLabel];
    
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(Margin, maxY(lineLabel), width(self.view.frame)-2*Margin, 200)];
    _textView.delegate = self;
    _textView.text = DefaultStr;
    _textView.textColor = [UIColor lightGrayColor];
    _textView.font = Font(13);
    [self.view addSubview:_textView];
    
    UILabel *downLineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, maxY(_textView), width(self.view.frame), 1)];
    downLineLabel.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:downLineLabel];
    
    UILabel *linkLabel = [UILabel new];
    linkLabel.frame = CGRectMake(0, maxY(downLineLabel), width(self.view.frame), 35);
    linkLabel.text = @" 联系方式:";
    linkLabel.backgroundColor = [UIColor groupTableViewBackgroundColor];
    linkLabel.font = Font(15);
    [self.view addSubview:linkLabel];
    
    UILabel *downLineLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0, maxY(linkLabel), width(self.view.frame), 1)];
    downLineLabel1.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:downLineLabel1];
    
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(Margin, maxY(downLineLabel1)+Margin, width(self.view.frame)-2*Margin, 30)];
    _textField.delegate = self;
    _textField.placeholder = DefaultFieldStr;
    _textField.font = Font(13);
    [self.view addSubview:_textField];
    
    UILabel *downLineLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(0, maxY(_textField), width(self.view.frame), 1)];
    downLineLabel2.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:downLineLabel2];
    
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    CGSize size = [[UIScreen mainScreen] bounds].size;
    NSLog(@"%lf",WIN_HEIGHT);
    if (size.width<321) {
        ZEBLog(@"4s 5 5s"); // 253
        if (367 + 253 >= WIN_HEIGHT) {
            [self setViewY:WIN_HEIGHT - 367 - 253 - 64 animation:YES];
        }
    }
    else if (size.width<377){
        ZEBLog(@"6 6s");  // 258
        
    }
    else if (size.width>410){
        ZEBLog(@"6p 6sp"); // 271
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    CGSize size = [[UIScreen mainScreen] bounds].size;
    if (size.width<321) {
        ZEBLog(@"4s 5 5s"); // 253
        if (367 + 253 >= WIN_HEIGHT) {
            [self setViewY:0 animation:YES];
        }
    }
    else if (size.width<377){
        ZEBLog(@"6 6s");  // 258
        
    }
    else if (size.width>410){
        ZEBLog(@"6p 6sp"); // 271
    }
    
}
- (void)setViewY:(double)viewY animation:(BOOL)animation
{
    CGRect frame = self.view.frame;
    frame.origin.y = viewY;
    if (animation) {
        [UIView animateWithDuration:0.3 animations:^{
            self.view.frame = frame;
        }];
    }
    else{
        self.view.frame = frame;
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [_textField resignFirstResponder];
    return YES;
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    textView.textColor = [UIColor blackColor];
    if ([textView.text isEqualToString:DefaultStr]) {
        textView.text = @"";
    }
    return YES;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:@""]) {
        textView.text = DefaultStr;
        textView.textColor = [UIColor lightGrayColor];
    }
    return YES;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
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
