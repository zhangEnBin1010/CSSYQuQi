//
//  XunJiaInfoTableViewCell.h
//  CSSYQuQi
//
//  Created by cssy-apple on 15/12/2.
//  Copyright (c) 2015年 cssy-apple. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface XunJiaInfoTableViewCell : UITableViewCell<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *userNameText;
@property (nonatomic, strong) UITextField *phoneText;
@end
