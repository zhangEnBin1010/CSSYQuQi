//
//  MineCommentViewController.h
//  
//
//  Created by cssy-apple on 15/11/17.
//  Copyright © 2015年 cssy-apple. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MineCommentViewController : UIViewController

//用户ID，用来向服务器请求数据
@property (nonatomic, assign) NSInteger userID;
@property (nonatomic, copy) NSString *viewTitle;
@property (nonatomic, copy) NSString *fromUI;
@end
