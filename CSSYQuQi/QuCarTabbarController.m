//
//  QuCarTabbarController.m
//  CSSYQuQi
//
//  Created by cssy-apple on 15/11/19.
//  Copyright (c) 2015年 cssy-apple. All rights reserved.
//

#import "QuCarTabbarController.h"
#import "RootViewController.h"
#import "IntroductionView.h"
@interface QuCarTabbarController ()

@end

@implementation QuCarTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([[NSUserDefaults standardUserDefaults] boolForKey:FirstLaunched]) {
        IntroductionView *introductionView = [[IntroductionView alloc] initWithFrame:self.view.bounds];
        introductionView.alpha = 1.0;
        [self.view addSubview:introductionView];
    }
    [self createViewController];
}

- (void)createViewController {

    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Controllers" ofType:@"plist"];
    NSArray *vcArray = [[NSArray alloc] initWithContentsOfFile:plistPath];
    NSMutableArray *tabArray = [NSMutableArray array];
    NSArray *typeArray = @[NewCar,ChooseCar,Community,Person];
    int i = 0;
    for (NSDictionary *vcDict in vcArray) {
        Class class = NSClassFromString(vcDict[@"className"]);
        RootViewController *rootVC = [[class alloc] init];
        UINavigationController *rootNav = [[UINavigationController alloc] initWithRootViewController:rootVC];
        rootVC.type = typeArray[i];
        rootVC.title = vcDict[@"title"];
        rootVC.tabBarItem.image = [[UIImage imageNamed:vcDict[@"iconName"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        rootVC.tabBarItem.selectedImage = [[UIImage imageNamed:vcDict[@"iconClickName"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [tabArray addObject:rootNav];
        i++;
    }
    self.viewControllers = tabArray;
    
    [self.tabBar setTintColor:ZEBColor(26, 166, 255)];
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
