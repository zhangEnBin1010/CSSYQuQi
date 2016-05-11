//
//  NewCarDetailViewController.m
//  CSSYQuQi
//
//  Created by cssy-apple on 15/11/23.
//  Copyright (c) 2015年 cssy-apple. All rights reserved.
//

#import "NewCarDetailViewController.h"
@interface NewCarDetailViewController ()<UMSocialUIDelegate, UMSocialDataDelegate>

@end

@implementation NewCarDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self initall];
}
- (void)initall {
    [self createBackButton];
    [self createRightButton];
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
    if ([_fromUI isEqualToString:@"我的收藏"]) {
    [self.navigationController popViewControllerAnimated:YES];
    }else {
        
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    }
}
- (void)createRightButton {
    
    UIButton *collectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    collectButton.frame = CGRectMake(0, 0, 30, 30);
    [collectButton setBackgroundImage:[UIImage imageNamed:@"collect.png"] forState:UIControlStateNormal];
    [collectButton setBackgroundImage:[UIImage imageNamed:@"collect_hight.png"] forState:UIControlStateHighlighted];
    [collectButton addTarget:self action:@selector(collectButton:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    shareButton.frame = CGRectMake(30, 30, 30, 30);
    [shareButton setBackgroundImage:[UIImage imageNamed:@"share_low.png"] forState:UIControlStateNormal];
    [shareButton setBackgroundImage:[UIImage imageNamed:@"share_hight.png"] forState:UIControlStateHighlighted];
    [shareButton addTarget:self action:@selector(shareButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:shareButton];
    UIBarButtonItem *collectBarButton = [[UIBarButtonItem alloc] initWithCustomView:collectButton];
    UIBarButtonItem *shareBarButton = [[UIBarButtonItem alloc] initWithCustomView:shareButton];
    self.navigationItem.rightBarButtonItems = @[shareBarButton,collectBarButton];
}
//收藏
- (void)collectButton:(UIButton *)button {

}
//分享
- (void)shareButton:(UIButton *)button {
    NSString *shareText = @"友盟社会化组件可以让移动应用快速具备社会化分享、登录、评论、喜欢等功能，并提供实时、全面的社会化数据统计分析服务。 http://www.csjtw.com.cn/";             //分享内嵌文字
    UIImage *shareImage = [UIImage imageNamed:@"UMS_social_demo"];          //分享内嵌图片
    
    //调用快速分享接口
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:UmengAppkey
                                      shareText:shareText
                                     shareImage:shareImage
                                shareToSnsNames:@[UMShareToSina,UMShareToQzone,UMShareToWechatTimeline]
                                       delegate:self];

}
- (void)didFinishGetUMSocialDataResponse:(UMSocialResponseEntity *)response {
    ZEBLog(@"didFinishGetUMSocialDataResponse----%@",response);
}
//下面得到分享完成的回调
- (void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    NSLog(@"didFinishGetUMSocialDataInViewController with response is %@",response);
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        SHOW_ALERT(@"分享成功！");
        //得到分享到的微博平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }else {
        SHOW_ALERT(@"分享失败！");
    }
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
