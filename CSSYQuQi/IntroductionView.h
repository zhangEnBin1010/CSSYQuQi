//
//  IntroductionView.h
//  CSSYQuQi
//
//  Created by cssy-apple on 15/12/19.
//  Copyright © 2015年 cssy-apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IntroductionView;
@protocol IntroductionViewDelegate <NSObject>

- (void)introductionView:(IntroductionView *)view button:(UIButton *)button;

@end
@interface IntroductionView : UIView<UIScrollViewDelegate>

@property (nonatomic, weak) UIPageControl *pageControl;

@property (nonatomic, weak) UIScrollView *scrollView;

@property (nonatomic, weak) id<IntroductionViewDelegate> delegate;
@end
