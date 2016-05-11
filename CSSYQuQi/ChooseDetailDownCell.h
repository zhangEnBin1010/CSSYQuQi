//
//  ChooseDetailDownCell.h
//  CSSYQuQi
//
//  Created by cssy-apple on 15/11/27.
//  Copyright (c) 2015年 cssy-apple. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol ChooseDetailDownDelegate <NSObject>

- (void)chooseDetailDown:(UITableViewCell *)cell;

@end
@interface ChooseDetailDownCell : UITableViewCell
@property (nonatomic, weak) id<ChooseDetailDownDelegate> chooseDetailDownDelegate;
@end
