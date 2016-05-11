//
//  QuCarDefine.h
//  CSSYQuQi
//
//  Created by cssy-apple on 15/11/19.
//  Copyright (c) 2015年 cssy-apple. All rights reserved.
//

#ifndef CSSYQuQi_QuCarDefine_h
#define CSSYQuQi_QuCarDefine_h


#define   WIN_WIDTH  [[UIScreen mainScreen] bounds].size.width
#define   WIN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define ZEBIntroductionCount 4
//友盟分享
#define UmengAppkey @"56722c12e0f55ad21e001500"
#define WeiXinAppId @"wx2077c9cb8481dd86"
#define WeiXinAppSecret @"08006eb57d281b7f401cc642840fd415"
#define QQWithAppId @""
#define QQAppKey @""

#define NUMBERSTRING @"1234567890"
#define Company_Introduction @"  河南春申实业有限公司在“以人为本”的思想指导下，注重组织架构构建、员工职业生涯规划及管理干部梯队建设；坚持在稳健、高效、持续发展的方针下，凭借先进、科学的用人机制，打造了一支学习型、创新型、实干型和富有超强执行力的优秀团队。\n  诚信为本、信誉为天！以行鉴言！"
#define TestStr @"在直行道行驶，直行红灯后全车过线才意识到。我赶紧打方向左转，这会被判闯红灯还是不按规定车道行驶？"
#define CollectStr @"暂时没有收藏的车！！！"
//客服电话
#define PhoneNumber @"0371-2555555"
//展示tableview索引的title
#define SHOW_TABLEALERT(title) [MBProgressHUD showTableViewIndexTitle:title]
//提示信息
#define SHOW_ALERT(hint) [MBProgressHUD showHint:hint]
//获取手机版本
#define DEVICE_NUMBER [LZXHelper getCurrentIOS];
//返回行高
#define Height(text, textWidth, size) [LZXHelper textHeightFromTextString:text width:textWidth fontSize:size];
//返回Width
#define Width(text, textHeight, size) [LZXHelper textWidthFromTextString:text height:textHeight fontSize:size];
//返回字体
#define Font(font) [UIFont boldSystemFontOfSize:font]
#define FontSystem(font) [UIFont systemFontOfSize:font]
//margin
#define Margin 10

//页面类型
#define NewCar @"NewCar"
#define ChooseCar @"ChooseCar"
#define Community @"Community"
#define Person @"Person"





#define UserNamePlaceholder @"请输入手机号"
#define UserPassPlaceholder @"请输入密码"
//用户手机号和密码
#define UserName @"userName"
#define UserPassWord @"userPassWord"

//用户性别
#define UserSex @"UserSex"
//用户昵称
#define UserNickname @"UserNickname"
//判断是否修改了昵称
#define ChangeNickOnce @"ChangeNickOnce"
//用户是否登录
#define IsLogin @"IsLongin"
//程序是否第一次运行
#define FirstLaunched @"FirstLaunched"
#define EvenLaunched @"EvenLaunched"
#define keyCFBundleVersion @"CFBundleVersion"
//RGB颜色
#define ZEBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define ZEBRGBA(r,g,b,a)  [UIColor colorWithRed:(double)r/255.0f green:(double)g/255.0f blue:(double)b/255.0f alpha:a]


#endif
