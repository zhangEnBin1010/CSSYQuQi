//
//  CustomChooseTableView.h
//  CSSYQuQi
//
//  Created by cssy-apple on 15/11/23.
//  Copyright (c) 2015年 cssy-apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DOPDropDownMenu.h"
@class CustomChooseTableView;
@protocol CustomChooseSkipDetailDelegate <NSObject>

- (void)customChooseSkipDetail:(CustomChooseTableView *)view;

@end
@interface CustomChooseTableView : UIView<DOPDropDownMenuDataSource, DOPDropDownMenuDelegate, UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, copy) NSArray *prices;
@property (nonatomic, copy) NSArray *carType;
@property (nonatomic, copy) NSArray *countrys;
@property (nonatomic, copy) NSArray *originalArray;
@property (nonatomic, copy) NSArray *results;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, weak) id<CustomChooseSkipDetailDelegate> cusChooseSkipDetailDelegate;
@end
