//
//  MyCollectChooseCarView.h
//  CSSYQuQi
//
//  Created by cssy-apple on 15/12/10.
//  Copyright © 2015年 cssy-apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyCollectChooseCarView;
@protocol MyCollectChooseCarDelegate <NSObject>

- (void)mycollectChoose:(MyCollectChooseCarView *)controller;

@end
@interface MyCollectChooseCarView : UIView<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) NSInteger integer;
@property (nonatomic, weak) id<MyCollectChooseCarDelegate> delegate;
@end
