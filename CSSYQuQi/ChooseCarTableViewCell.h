//
//  ChooseCarTableViewCell.h
//  CSSYQuQi
//
//  Created by cssy-apple on 15/11/20.
//  Copyright (c) 2015年 cssy-apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ChooseCarTableViewCell;
@protocol ChooseCarSkipDetailDelegate <NSObject>

- (void)chooseCarSkipDetail:(ChooseCarTableViewCell *)cell string:(NSString *)title;

@end
@interface ChooseCarTableViewCell : UITableViewCell

@property (nonatomic, weak) id<ChooseCarSkipDetailDelegate> chooseCarSkipDetaelDelegate;
@end
