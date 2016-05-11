//
//  SliderView.h
//  CSSYQuQi
//
//  Created by cssy-apple on 15/11/27.
//  Copyright (c) 2015年 cssy-apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SliderView;
@protocol SliderSkipDelegate <NSObject>

- (void)sliderSkip:(SliderView *)view;

@end

@interface SliderView : UIView<UIGestureRecognizerDelegate,UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, copy) NSString *type;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) CGRect myFrame;
@property (nonatomic, assign) BOOL isOpen;
@property (nonatomic, weak) id<SliderSkipDelegate> sliderDelegate;
+ (id)defaultInstanceView;

@end
