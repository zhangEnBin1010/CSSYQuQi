//
//  MyCollectNewCarView.h
//  CSSYQuQi
//
//  Created by cssy-apple on 15/12/10.
//  Copyright © 2015年 cssy-apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyCollectNewCarView;
@protocol MyCollectNewCarDelegate <NSObject>

- (void)myCollectNewCar:(MyCollectNewCarView *)controller;

@end
@interface MyCollectNewCarView : UIView<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) NSInteger integer;
@property (nonatomic, weak) id<MyCollectNewCarDelegate> delegate;
@end
