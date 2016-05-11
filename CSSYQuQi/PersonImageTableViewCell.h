//
//  PersonImageTableViewCell.h
//  CSSYQuQi
//
//  Created by cssy-apple on 15/12/7.
//  Copyright © 2015年 cssy-apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PersonImageTableViewCell;
@protocol PersonImageForBigDelegate <NSObject>

- (void)PersonImageForBig:(PersonImageTableViewCell *)cell url:(NSString *)url;

@end
@interface PersonImageTableViewCell : UITableViewCell
@property (nonatomic, strong) UIButton *infoImageView;
@property (nonatomic, weak) id<PersonImageForBigDelegate> delegate;
@end
