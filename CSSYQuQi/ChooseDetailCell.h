//
//  ChooseDetailCell.h
//  CSSYQuQi
//
//  Created by cssy-apple on 15/11/27.
//  Copyright (c) 2015年 cssy-apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ChooseDetailCell;
@protocol ChooseDetailDelegate <NSObject>

- (void)chooseDetail:(ChooseDetailCell *)cell scrollViewOriginalImages:(NSMutableArray *)scrollViewOriginalImages;

@end
@interface ChooseDetailCell : UITableViewCell
@property (nonatomic, weak) id<ChooseDetailDelegate> delegate;
@end
