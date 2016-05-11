//
//  CommunityTableViewCell.h
//  CSSYQuQi
//
//  Created by cssy-apple on 15/11/20.
//  Copyright (c) 2015年 cssy-apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CommunityTableViewCell;
@protocol CommunityTableViewCellDelegate <NSObject>

- (void)CommunityTableViewCell:(CommunityTableViewCell *)cell scrollViewOriginalImages:(NSMutableArray *)scrollViewOriginalImages index:(NSInteger)index;

@end

@protocol CommunityCellReplyDelegate <NSObject>

- (void)communityReply:(CommunityTableViewCell *)cell;

@end
@interface CommunityTableViewCell : UITableViewCell
@property (nonatomic, weak) id<CommunityTableViewCellDelegate> delegate;
@property (nonatomic, weak) id<CommunityCellReplyDelegate> replyDelegate;
@end
