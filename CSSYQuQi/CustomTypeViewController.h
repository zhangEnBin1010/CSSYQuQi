//
//  CustomTypeViewController.h
//  CSSYQuQi
//
//  Created by cssy-apple on 15/12/25.
//  Copyright © 2015年 cssy-apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CustomTypeViewController;
@protocol CustomTypeControllerDelegate <NSObject>

- (void)customTypeController:(CustomTypeViewController *)controller ;

@end
@interface CustomTypeViewController : UIViewController
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) UILabel *flotageLabel;
@property (nonatomic, weak) id<CustomTypeControllerDelegate> delegate;
@end
