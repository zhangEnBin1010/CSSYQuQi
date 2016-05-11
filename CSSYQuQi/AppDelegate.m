//
//  AppDelegate.m
//  CSSYQuQi
//
//  Created by cssy-apple on 15/11/18.
//  Copyright (c) 2015年 cssy-apple. All rights reserved.
//

#import "AppDelegate.h"
#import "QuCarTabbarController.h"
#import "UIViewController+MLTransition.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    //设置友盟社会化组件appkey
    [UMSocialData setAppKey:UmengAppkey];
    //打开调试log的开关
    //[UMSocialData openLog:YES];
    //设置微信AppId，设置分享url，默认使用友盟的网址
    [UMSocialWechatHandler setWXAppId:WeiXinAppId appSecret:WeiXinAppSecret url:UMURL];
    //设置分享到QQ空间的应用Id，和分享url 链接
    [UMSocialQQHandler setQQWithAppId:QQWithAppId appKey:QQAppKey url:UMURL];
    //设置支持没有客户端情况下使用SSO授权
    [UMSocialQQHandler setSupportWebView:YES];
    
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:15],NSForegroundColorAttributeName:[UIColor blackColor]}];
    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
    //[UIColor colorWithPatternImage:[UIImage imageNamed:@"top_background.png"]]
    [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
    [[UINavigationBar appearance] setTintAdjustmentMode:UIViewTintAdjustmentModeAutomatic];
    
    [UIViewController validatePanPackWithMLTransitionGestureRecognizerType:MLTransitionGestureRecognizerTypePan];
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    
    // 上一次的使用版本（存储在沙盒中的版本号）
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:keyCFBundleVersion];
    // 当前软件的版本号（从Info.plist中获得）
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[keyCFBundleVersion];
    //判断用户是否第一次使用应用
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    if ([lastVersion isEqualToString:currentVersion]) {
        [userDefaultes setBool:YES forKey:EvenLaunched];
        [userDefaultes setBool:NO forKey:FirstLaunched];
    }else {
        [userDefaultes setBool:NO forKey:EvenLaunched];
        [userDefaultes setBool:YES forKey:FirstLaunched];
    }
    [userDefaultes setObject:currentVersion forKey:keyCFBundleVersion];
    [userDefaultes synchronize];
    
    QuCarTabbarController *quCarTabbarController = [QuCarTabbarController new];
    self.window.rootViewController = quCarTabbarController;

    [self.window makeKeyAndVisible];
    return YES;
}
/**
 这里处理新浪微博SSO授权之后跳转回来，和微信分享完成之后跳转回来
 */
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return  [UMSocialSnsService handleOpenURL:url wxApiDelegate:nil];
}

/**
 这里处理新浪微博SSO授权进入新浪微博客户端后进入后台，再返回原来应用
 */
- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [UMSocialSnsService  applicationDidBecomeActive];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
