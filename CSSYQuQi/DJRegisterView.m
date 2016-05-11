//
//  DJRegisterView.h
//  DJRegisterView
//
//  Created by cssy-apple on 15/11/19.
//  Copyright (c) 2015年 cssy-apple. All rights reserved.
//
//



#import "DJRegisterView.h"


// 登录界面颜色
#define   COLOR_LOGIN_VIEW [UIColor colorWithRed:26/255.0 green:166/255.0 blue:255/255.0 alpha:1]
// 注册界面颜色
#define   COLOR_ZC_VIEW [UIColor colorWithRed:26/255.0 green:166/255.0 blue:255/255.0 alpha:1]
// 注释的颜色
#define COLOR_BLUE_LOGIN [UIColor colorWithRed:26/255.0 green:166/255.0 blue:255/255.0 alpha:1];
#define SET_PLACE(text) [text  setValue:[UIFont boldSystemFontOfSize:(13)] forKeyPath:@"_placeholderLabel.font"];
#define   FONT(size)  ([UIFont systemFontOfSize:size])


@interface DJRegisterView () <UITextFieldDelegate>
{
    double _minHeight;
    UIButton *hqBtn;
    UIButton *zcBtn;
    
    BOOL _isTime;
    
    NSTimer *_timer;
    int timecount;
}
// 登录界面
@property (nonatomic,assign)DJRegisterViewType djRegisterViewType;
@property (nonatomic,copy) void (^action)(NSString *acc,NSString *key);
@property (nonatomic,copy) void (^zcAction)(void);
@property (nonatomic,copy) void (^wjAction)(void);

// 重置密码界面
@property (nonatomic,copy) void (^setPassAction)(NSString *key1,NSString *key2);


// 忘记密码 获取验证码界面
@property (nonatomic,copy) BOOL (^hqAction)(NSString *phoneStr);
@property (nonatomic,copy) void (^tjAction)(NSString *phoneStr,NSString *yzmStr);
@property (nonatomic,copy) void (^tjReAction)(NSString *userName,NSString *phoneStr,NSString *yzmStr,NSString *key1,NSString *key2);
@end


@implementation DJRegisterView

- (instancetype)init
{
    if(self = [super init]) {
    }
    return self;
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super initWithCoder:aDecoder]) {
        
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]) {
        
    }
    return self;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self endEditing:YES];
}
#pragma mark - 注册界面
- (instancetype )initwithFrame:(CGRect)frame
                    plUserName:(NSString *)plName
                       plTitle:(NSString *)plTitle  // 填写验证码 的提示文字
                         title:(NSString *)title    // 填写验证码 的提示文字
                        plKey1:(NSString *)plKey1
                        plKey2:(NSString *)plKey2
                            hq:(BOOL (^)(NSString *phoneStr))hqAction // 获取验证码的 回调block（返回是否获取成功,phoneStr:输入的手机号）
                      tjAction:(void (^)(NSString *userName,NSString *phoneStr,NSString *yzmStr,NSString *key1, NSString *key2))tjAction; {
    if ([self initWithFrame:frame]) {
        [self createRegisterUI:plName plTitle:plTitle title:title plKey1:plKey1 plKey2:plKey2];
        self.hqAction = hqAction;
        self.tjReAction = tjAction;
    }
    return self;
}
- (void)createRegisterUI:(NSString *)plName plTitle:(NSString *)plTitle title:(NSString *)title plKey1:(NSString *)plKey1 plKey2:(NSString *)plKey2 {
    
    // 昵称
    UITextField *userText = [[UITextField alloc] initWithFrame:CGRectMake(30, 30, WIN_WIDTH-60, 30)];
    [self addSubview:userText];
    userText.delegate = self;
    userText.placeholder = plName;
    SET_PLACE(userText);
    userText.tag = 5000;
    
    //icon
    UIImageView *userIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    userIcon.image = [UIImage imageNamed:@"irn.png"];
    userText.leftView = userIcon;
    userText.leftViewMode = UITextFieldViewModeAlways;
    
    
    // 线
    UIImageView *userImage = [[UIImageView alloc] initWithFrame:CGRectMake(28, maxY(userText), WIN_WIDTH-56, 2)];
    [self addSubview:userImage];
    userImage.image = [UIImage imageNamed:@"textfield_default_holo_light.9.png"];
    
    // 手机号码
    UITextField *accText = [[UITextField alloc] initWithFrame:CGRectMake(30, maxY(userImage)+2*Margin, WIN_WIDTH-60, 30)];
    [self addSubview:accText];
    accText.placeholder = @"请输入你的常用手机号";
    accText.delegate = self;
    SET_PLACE(accText);
    accText.tag = 5001;
    
    //icon
    UIImageView *accIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    accIcon.image = [UIImage imageNamed:@"label_phone.png"];
    accText.leftView = accIcon;
    accIcon.alpha = 0.5;
    accText.leftViewMode = UITextFieldViewModeAlways;
    
    
    // 线
    UIImageView *accImage = [[UIImageView alloc] initWithFrame:CGRectMake(28, maxY(accText), WIN_WIDTH-56, 2)];
    [self addSubview:accImage];
    accImage.image = [UIImage imageNamed:@"textfield_default_holo_light.9.png"];
    
    NSArray *descTitles = [NSArray arrayWithObjects:plKey1,plKey2, nil];
    double H = maxY(accImage)+2*Margin;
    for (int i=0; i<2; i++) {
        UITextField *text = [[UITextField alloc]
                             initWithFrame:CGRectMake(30, H+i*(30+20), WIN_WIDTH-40, 30)];
        text.placeholder = descTitles[i];
        text.delegate = self;
        SET_PLACE(text);
        [self addSubview:text];
        text.tag = 5002+i;
        
        
        UIImageView *passIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        passIcon.image = [UIImage imageNamed:@"irv.png"];
        text.leftView = passIcon;
        text.leftViewMode = UITextFieldViewModeAlways;
        
        // 线
        UIImageView *passImage = [[UIImageView alloc] initWithFrame:CGRectMake(28, maxY(text), WIN_WIDTH-56, 2)];
        [self addSubview:passImage];
        passImage.image = [UIImage imageNamed:@"textfield_default_holo_light.9.png"];
    }
    
    // 验证码
    UITextField *codeText = [[UITextField alloc] initWithFrame:CGRectMake(30, maxY(accImage)+104+2*Margin, WIN_WIDTH-180, 30)];
    [self addSubview:codeText];
    codeText.placeholder = plTitle;
    SET_PLACE(codeText);
    codeText.tag = 5004;
    
    
    // 线
    UIImageView *codeImage = [[UIImageView alloc] initWithFrame:CGRectMake(28, maxY(codeText), WIN_WIDTH-56, 2)];
    [self addSubview:codeImage];
    codeImage.image = [UIImage imageNamed:@"textfield_default_holo_light.9.png"];
    
    
    hqBtn = [UIButton buttonWithType:0];
    hqBtn.frame = CGRectMake(maxX(codeText)+20, minY(codeText), 100, 25);
    [hqBtn setTitle:@"获取验证码" forState:0];
    hqBtn.backgroundColor = COLOR_BLUE_LOGIN;
    [self addSubview:hqBtn];
    hqBtn.clipsToBounds = YES;
    hqBtn.layer.cornerRadius = 5.0f;
    [hqBtn addTarget:self action:@selector(hqBtnClick) forControlEvents:7];
    hqBtn.titleLabel.font = FONT(13);
    
    zcBtn = [UIButton buttonWithType:0];
    zcBtn.frame = CGRectMake(30, maxY(codeImage)+30, WIN_WIDTH-60, 35);
    [zcBtn setTitle:title forState:0];
    zcBtn.backgroundColor = COLOR_BLUE_LOGIN;
    [self addSubview:zcBtn];
    zcBtn.clipsToBounds = YES;
    zcBtn.layer.cornerRadius = 5.0f;
    [zcBtn addTarget:self action:@selector(tjReBtnClick) forControlEvents:7];
    
}
- (void)tjReBtnClick {
    ZEBLog(@"注册");
    if (self.tjReAction) {
        UITextField *text1 = (UITextField *)[self viewWithTag:5000];
        UITextField *text2 = (UITextField *)[self viewWithTag:5001];
        UITextField *text3 = (UITextField *)[self viewWithTag:5002];
        UITextField *text4 = (UITextField *)[self viewWithTag:5003];
        UITextField *text5 = (UITextField *)[self viewWithTag:5004];
        
        
        self.tjReAction(text1.text,text2.text,text5.text,text3.text,text4.text);
    }
}
#pragma mark - 登录界面
- (instancetype )initwithFrame:(CGRect)frame
            djRegisterViewType:(DJRegisterViewType)djRegisterViewType
                        action:(void (^)(NSString *acc,NSString *key))action
                      zcAction:(void (^)(void))zcAction
                      wjAction:(void (^)(void))wjAction
{
    if ([self  initWithFrame:frame]) {
        [self creatUI:djRegisterViewType];
        self.action = action;
        self.zcAction = zcAction;
        self.wjAction = wjAction;
    }
    return self;
}
- (void)creatUI:(DJRegisterViewType ) djRegisterViewType
{
    self.djRegisterViewType = djRegisterViewType;
    
    // 头像
    UIImageView *headIcon = [[UIImageView alloc]
                             initWithFrame:CGRectMake((WIN_WIDTH-100)/2.0, 60, 100, 100)];
    headIcon.image = [UIImage imageNamed:@"girl.png"];
    headIcon.userInteractionEnabled = YES;
    headIcon.clipsToBounds = YES;
    headIcon.layer.cornerRadius = 50.0f;
    [self addSubview:headIcon];
    
    // 账户
    UITextField *accText = [[UITextField alloc] initWithFrame:CGRectMake(30, 190, WIN_WIDTH-60, 30)];
    accText.placeholder = UserNamePlaceholder;
    accText.clearButtonMode = UITextFieldViewModeAlways;
    accText.text = [[NSUserDefaults standardUserDefaults] objectForKey:UserName];
    [self addSubview:accText];
    accText.delegate = self;
    
        //icon
    UIImageView *accIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    accIcon.image = [UIImage imageNamed:@"irn.png"];
    accText.leftView = accIcon;
    accText.leftViewMode = UITextFieldViewModeAlways;
        // 线
    UIImageView *accImage = [[UIImageView alloc] initWithFrame:CGRectMake(28, 225, WIN_WIDTH-56, 2)];
    [self addSubview:accImage];
    accImage.image = [UIImage imageNamed:@"textfield_default_holo_light.9.png"];
    
    // 密码
    UITextField *passText = [[UITextField alloc] initWithFrame:CGRectMake(30, 240, WIN_WIDTH-60, 30)];
    passText.placeholder = UserPassPlaceholder;
    passText.clearButtonMode = UITextFieldViewModeAlways;
    passText.secureTextEntry = YES;
    passText.text = [[NSUserDefaults standardUserDefaults] objectForKey:UserPassWord];
    [self addSubview:passText];
    passText.delegate = self;
        //icon
    UIImageView *passIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    passIcon.image = [UIImage imageNamed:@"irv.png"];
    passText.leftView = passIcon;
    passText.leftViewMode = UITextFieldViewModeAlways;
        // 线
    UIImageView *passImage = [[UIImageView alloc] initWithFrame:CGRectMake(28, 275, WIN_WIDTH-56, 2)];
    [self addSubview:passImage];
    passImage.image = [UIImage imageNamed:@"textfield_default_holo_light.9.png"];
    
    
    
    // 登录
    UIButton *loginBtn = [UIButton buttonWithType:0];
    loginBtn.frame = CGRectMake(30, 300, WIN_WIDTH-60, 40);
    [loginBtn setTitle:@"登录" forState:0];
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"login_button_image_normal"] forState:UIControlStateNormal];
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"login_button_image_clicked"] forState:UIControlStateHighlighted];
    //loginBtn.backgroundColor = COLOR_LOGIN_VIEW;
    [self addSubview:loginBtn];
    loginBtn.clipsToBounds = YES;
    loginBtn.layer.cornerRadius = 5.0f;
    [loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    // 注册 忘记密码
    UIButton *dlzcBtn = [UIButton buttonWithType:0];
    dlzcBtn.frame = CGRectMake(30, 350, 30, 20);
    [dlzcBtn setTitle:@"注册" forState:0];
    dlzcBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [dlzcBtn setTitleColor:COLOR_LOGIN_VIEW forState:0];
    [self addSubview:dlzcBtn];
    [dlzcBtn addTarget:self action:@selector(zcBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *wjBtn = [UIButton buttonWithType:0];
    wjBtn.frame = CGRectMake(WIN_WIDTH-30-60, 350, 60, 20);
    [wjBtn setTitle:@"忘记密码" forState:0];
    wjBtn.titleLabel.font = FONT(13);
    [wjBtn setTitleColor:COLOR_LOGIN_VIEW forState:0];
    [self addSubview:wjBtn];
    [wjBtn addTarget:self action:@selector(wjBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    accText.tag = 201;
    accImage.tag = 301;
    
    passText.tag = 202;
    passImage.tag = 302;
    _minHeight = 340;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSString *toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
   // ZEBLog(@"%ld",toBeString.length);
    if (textField.tag == 202 && toBeString.length > 12) {
        return NO;
    }else if ((textField.tag == 201 && toBeString.length >11) || (textField.tag == 201 && [NUMBERSTRING rangeOfString:string].location == NSNotFound)){
        return NO;
    }else if ((textField.tag == 5001 && toBeString.length >11) || (textField.tag == 201 && [NUMBERSTRING rangeOfString:string].location == NSNotFound)) {
        return NO;
    }else if (textField.tag == 5000 && toBeString.length > 12) {
        return NO;
    }else if ((textField.tag == 5002 && toBeString.length > 12) || (textField.tag == 5003 && toBeString.length > 12)) {
        return NO;
    }
        return YES;

}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGSize size = [[UIScreen mainScreen] bounds].size;
    if (size.width<321) {
        ZEBLog(@"4 4s 5 5s"); // 216
        if (_minHeight>WIN_HEIGHT-216-30 && self.djRegisterViewType==0) {
            [self setViewY:WIN_HEIGHT-216-30 - _minHeight animation:YES];
        }
        else if (_minHeight>WIN_HEIGHT-64-216-30 && self.djRegisterViewType==1) {
            [self setViewY:WIN_HEIGHT-64-216-30 - _minHeight animation:YES];
        }
    }
    else if (size.width<377){
        ZEBLog(@"6");  // 258
        if (_minHeight>WIN_HEIGHT-64-258 && self.djRegisterViewType==0) {
            [self setViewY:WIN_HEIGHT-64-258 - _minHeight animation:YES];
        }
        else if (_minHeight>WIN_HEIGHT-258 && self.djRegisterViewType==1){
            [self setViewY:WIN_HEIGHT-258 - _minHeight animation:YES];
        }
    }
    else if (size.width>410){
        ZEBLog(@"6p"); // 271
        if (_minHeight>WIN_HEIGHT-64-271 && self.djRegisterViewType==0) {
            [self setViewY:WIN_HEIGHT-64-271 - _minHeight animation:YES];
        }
        else if (_minHeight>WIN_HEIGHT-271 && self.djRegisterViewType==1){
            [self setViewY:WIN_HEIGHT-271 - _minHeight animation:YES];
        }
    }
    UIImageView *im = (UIImageView *)[self viewWithTag:textField.tag+100];
    im.image = [UIImage imageNamed:@"textfield_activated_holo_light.9.png"];
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self setViewY:64 animation:YES];
    UIImageView *im = (UIImageView *)[self viewWithTag:textField.tag+100];
    im.image = [UIImage imageNamed:@"textfield_default_holo_light.9.png"];
}
- (void)setViewY:(double)viewY animation:(BOOL)animation
{
    CGRect frame = self.frame;
    frame.origin.y = viewY;
    if (animation) {
        [UIView animateWithDuration:0.3 animations:^{
            self.frame = frame;
        }];
    }
    else{
        self.frame = frame;
    }
}
- (void)loginBtnClick
{
    [self endEditing:YES];
    if (self.action) {
        UITextField *acc = (UITextField *)[self viewWithTag:201];
        UITextField *key = (UITextField *)[self viewWithTag:202];
        self.action(acc.text,key.text);
    }
}
- (void)zcBtnClick
{
    [self endEditing:YES];
    if (self.zcAction) {
        self.zcAction();
    }
}
- (void)wjBtnClick
{
    [self endEditing:YES];
    if (self.wjAction) {
        self.wjAction();
    }
}





#pragma mark - 置密码界面
- (instancetype )initwithFrame:(CGRect)frame
                        action:(void (^)(NSString *key1,NSString *key2))action
{
    if ([self  initWithFrame:frame]) {
        [self creatSetPass];
        self.setPassAction = action;
    }
    return self;
}
- (void)creatSetPass
{
    NSArray *descTitles = @[@"请输入密码",@"请再次输入密码"];
    double H = 40;
    for (int i=0; i<2; i++) {
        UITextField *text = [[UITextField alloc]
                             initWithFrame:CGRectMake(20, H+i*(30+20), WIN_WIDTH-40, 30)];
        text.placeholder = descTitles[i];
        SET_PLACE(text);
        text.layer.cornerRadius = 5.0;
        text.layer.borderColor = [UIColor grayColor].CGColor;
        text.layer.borderWidth = 0.3;
        text.clipsToBounds = YES;
        [self addSubview:text];
        text.tag = 301+i;
        
        
        UIImageView *passIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        passIcon.image = [UIImage imageNamed:@"irv.png"];
        text.leftView = passIcon;
        text.leftViewMode = 3;
    }
    UIButton *submitButton = [UIButton buttonWithType:0];
    submitButton.frame = CGRectMake(20, 130 , WIN_WIDTH-40, 30);
    [submitButton setTitle:@"提交" forState:0];
    submitButton.backgroundColor = COLOR_ZC_VIEW;
    [submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    submitButton.layer.cornerRadius = 5.0;
    submitButton.clipsToBounds = YES;
    [submitButton addTarget:self action:@selector(setPassBtnClick) forControlEvents:7];
    [self addSubview:submitButton];
}
- (void)setPassBtnClick
{
    if (self.setPassAction) {
        UITextField *text1 = (UITextField *)[self viewWithTag:301];
        UITextField *text2 = (UITextField *)[self viewWithTag:302];
        self.setPassAction(text1.text,text2.text);
    }
}

#pragma mark - 1.找回密码 (界面)  2.输入手机号获取验证码界面
- (instancetype )initwithFrame:(CGRect)frame
                       plTitle:(NSString *)plTitle
                         title:(NSString *)title
                            hq:(BOOL (^)(NSString *phoneStr))hqAction
                      tjAction:(void (^)(NSString *phoneStr,NSString *yzmStr))tjAction
{
    if ([self  initWithFrame:frame]) {
        [self creatZhaoHePassWithTitle:title plTitle:plTitle];
        self.hqAction = hqAction;
        self.tjAction = tjAction;
    }
    return self;
}
- (void)creatZhaoHePassWithTitle:(NSString *)title
                         plTitle:(NSString *)plTitle

{
        
        // 手机号码
        UITextField *accText = [[UITextField alloc] initWithFrame:CGRectMake(30, 30, WIN_WIDTH-60, 30)];
        [self addSubview:accText];
        accText.placeholder = @"请输入你的手机号码";
        SET_PLACE(accText);
        accText.tag = 5001;
        
        //icon
        UIImageView *accIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
        accIcon.image = [UIImage imageNamed:@"label_phone.png"];
        accText.leftView = accIcon;
        accText.leftViewMode = UITextFieldViewModeAlways;
        
        
        // 线
        UIImageView *accImage = [[UIImageView alloc] initWithFrame:CGRectMake(28, 65, WIN_WIDTH-56, 2)];
        [self addSubview:accImage];
        accImage.image = [UIImage imageNamed:@"textfield_default_holo_light.9.png"];
        
        
        // 验证码
        UITextField *codeText = [[UITextField alloc] initWithFrame:CGRectMake(30, maxY(accImage)+2*Margin, WIN_WIDTH-180, 30)];
        [self addSubview:codeText];
        codeText.placeholder = plTitle;
        SET_PLACE(codeText);
        codeText.tag = 201;
        
        
        // 线
        UIImageView *codeImage = [[UIImageView alloc] initWithFrame:CGRectMake(28, maxY(codeText), WIN_WIDTH-56, 2)];
        [self addSubview:codeImage];
        codeImage.image = [UIImage imageNamed:@"textfield_default_holo_light.9.png"];
        
        
        hqBtn = [UIButton buttonWithType:0];
        hqBtn.frame = CGRectMake(maxX(codeText)+20, minY(codeText), 100, 25);
        [hqBtn setTitle:@"获取验证码" forState:0];
        hqBtn.backgroundColor = COLOR_BLUE_LOGIN;
        [self addSubview:hqBtn];
        hqBtn.clipsToBounds = YES;
        hqBtn.layer.cornerRadius = 5.0f;
        [hqBtn addTarget:self action:@selector(hqBtnClick) forControlEvents:7];
        hqBtn.titleLabel.font = FONT(13);
        
        zcBtn = [UIButton buttonWithType:0];
        zcBtn.frame = CGRectMake(30, maxY(codeImage)+30, WIN_WIDTH-60, 35);
        [zcBtn setTitle:title forState:0];
        zcBtn.backgroundColor = COLOR_BLUE_LOGIN;
        [self addSubview:zcBtn];
        zcBtn.clipsToBounds = YES;
        zcBtn.layer.cornerRadius = 5.0f;
        [zcBtn addTarget:self action:@selector(tjBtnClick) forControlEvents:7];
    }


- (void)hqBtnClick
{
    if (self.hqAction) {
        UITextField *tex = (UITextField *)[self viewWithTag:5001];
        if (self.hqAction(tex.text)) {
            ZEBLog(@"获取成功");
            timecount = 60;
            _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFired) userInfo:nil repeats:YES];
            [[NSRunLoop currentRunLoop] addTimer:_timer forMode:@"NSDefaultRunLoopMode"];
            [NSTimer scheduledTimerWithTimeInterval:60.0 target:self selector:@selector(time) userInfo:nil repeats:NO];
            
            hqBtn.backgroundColor = [UIColor grayColor];
            hqBtn.userInteractionEnabled = NO;
            _isTime = YES;
            [NSTimer scheduledTimerWithTimeInterval:5*60.0 target:self selector:@selector(endTime) userInfo:nil repeats:NO];
        }
    }
    
    else if (self.hqAction)
    {
        if (self.hqAction(nil)) {
            timecount = 60;
            _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFired) userInfo:nil repeats:YES];
            [NSTimer scheduledTimerWithTimeInterval:60.0 target:self selector:@selector(time) userInfo:nil repeats:NO];
            
            hqBtn.backgroundColor = [UIColor grayColor];
            hqBtn.userInteractionEnabled = NO;
            _isTime = YES;
            [NSTimer scheduledTimerWithTimeInterval:5*60.0 target:self selector:@selector(endTime) userInfo:nil repeats:NO];
        }
    }
}

- (void)tjBtnClick
{
    ZEBLog(@"下一步");
    if (self.tjAction) {
        UITextField *text1 = (UITextField *)[self viewWithTag:5001];
        UITextField *text2 = (UITextField *)[self viewWithTag:201];
        
        self.tjAction(text1.text,text2.text);
    }
}
- (void)timerFired
{
    [hqBtn setTitle:[NSString stringWithFormat:@"(%ds)重新获取",timecount--] forState:0];
    if (timecount==1||timecount<1) {
        [_timer invalidate];
        _timer = nil;
        [hqBtn setTitle:@"获取验证码" forState:0];
    }
}
- (void)time
{
    hqBtn.backgroundColor = COLOR_BLUE_LOGIN;
    hqBtn.userInteractionEnabled = YES;
}
- (void)endTime
{
    _isTime = NO;
}
@end
