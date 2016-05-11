//
//  DJRegisterView.h
//  DJRegisterView
//
//  Created by cssy-apple on 15/11/19.
//  Copyright (c) 2015年 cssy-apple. All rights reserved.
//
//


#import <UIKit/UIKit.h>


typedef enum : NSUInteger {
    DJRegisterViewTypeNoNav,   // 登录界面(没导航条)
    DJRegisterViewTypeNav,     // 登录界面(有导航条)
} DJRegisterViewType;

typedef enum : NSUInteger {
    DJRegisterViewTypeScanfPhoneSMS, // 输入手机号 获取验证码
    DJRegisterViewTypeNoScanfSMS,    // 找回密码 ()
} DJRegisterViewTypeSMS;



@interface DJRegisterView : UIView

// 登录界面
- (instancetype )initwithFrame:(CGRect)frame
            djRegisterViewType:(DJRegisterViewType)djRegisterViewType      //类型
                        action:(void (^)(NSString *acc,NSString *key))action  // 点击登录的回调block
                      zcAction:(void (^)(void))zcAction   // 点击注册的回调block
                      wjAction:(void (^)(void))wjAction;  // 点击忘记的回调block


// 1.找回密码 (界面)  2.输入手机号获取验证码界面
- (instancetype )initwithFrame:(CGRect)frame
                       plTitle:(NSString *)plTitle  // 填写验证码 的提示文字
                         title:(NSString *)title    // 填写验证码 的提示文字
                            hq:(BOOL (^)(NSString *phoneStr))hqAction // 获取验证码的 回调block（返回是否获取成功,phoneStr:输入的手机号）
                      tjAction:(void (^)(NSString *phoneStr,NSString *yzmStr))tjAction; // 点击提交的回调block


// 1. 注册(界面)  2.输入手机号获取验证码界面
- (instancetype )initwithFrame:(CGRect)frame
                        plUserName:(NSString *)plName
                        plTitle:(NSString *)plTitle  // 填写验证码 的提示文字
                        title:(NSString *)title    // 填写验证码 的提示文字
                        plKey1:(NSString *)plKey1
                        plKey2:(NSString *)plKey2
                        hq:(BOOL (^)(NSString *phoneStr))hqAction // 获取验证码的 回调block（返回是否获取成功,phoneStr:输入的手机号）
                        tjAction:(void (^)(NSString *userName,NSString *phoneStr,NSString *yzmStr,NSString *key1, NSString *key2))tjAction; // 点击提交的回调block
// (设置密码界面)
- (instancetype )initwithFrame:(CGRect)frame
                        action:(void (^)(NSString *key1,NSString *key2))action;


@end
