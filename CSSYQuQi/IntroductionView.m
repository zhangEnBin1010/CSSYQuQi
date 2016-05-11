//
//  IntroductionView.m
//  CSSYQuQi
//
//  Created by cssy-apple on 15/12/19.
//  Copyright © 2015年 cssy-apple. All rights reserved.
//

#import "IntroductionView.h"

@implementation IntroductionView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self crteateScrollView];
    }
    return self;
}
- (void)crteateScrollView {
    // 1.创建一个scrollView：显示所有的新特性图片
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.bounds;
    [self addSubview:scrollView];
    self.scrollView = scrollView;
    
    // 2.添加图片到scrollView中
    CGFloat scrollW = scrollView.width;
    CGFloat scrollH = scrollView.height;
    for (int i = 0; i<ZEBIntroductionCount; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.width = scrollW;
        imageView.height = scrollH;
        imageView.y = 0;
        imageView.x = i * scrollW;
        // 显示图片
        NSString *name = [NSString stringWithFormat:@"introduction_%d", i + 1];
        NSString *imagePath = @"";
        if (i == ZEBIntroductionCount - 1) {
            imagePath = [[NSBundle mainBundle] pathForResource:name ofType:@"png"];
        }else {
            imagePath = [[NSBundle mainBundle] pathForResource:name ofType:@"jpg"];
        }
        
        //        NSString *name = @"introduction_button";
        imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfFile:imagePath]];
        [scrollView addSubview:imageView];
        //imageView.backgroundColor = [UIColor redColor];
        // 如果是最后一个imageView，就往里面添加其他内容
        if (i == ZEBIntroductionCount - 1) {
            [self setupLastImageView:imageView];
        }
    }
    
    //#warning 默认情况下，scrollView一创建出来，它里面可能就存在一些子控件了
    //#warning 就算不主动添加子控件到scrollView中，scrollView内部还是可能会有一些子控件
    
    // 3.设置scrollView的其他属性
    // 如果想要某个方向上不能滚动，那么这个方向对应的尺寸数值传0即可
    scrollView.contentSize = CGSizeMake(ZEBIntroductionCount * scrollW, 0);
    scrollView.bounces = NO; // 去除弹簧效果
    scrollView.pagingEnabled = YES;//控制控件是否整页翻动
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;
    
    // 4.添加pageControl：分页，展示目前看的是第几页
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.numberOfPages = ZEBIntroductionCount;
    pageControl.backgroundColor = [UIColor redColor];//没发现它的作用
    pageControl.currentPageIndicatorTintColor = ZEBColor(253, 98, 42);
    pageControl.pageIndicatorTintColor = ZEBColor(189, 189, 189);
    pageControl.centerX = scrollW * 0.5;
    pageControl.centerY = scrollH - 50;
    [self addSubview:pageControl];
    self.pageControl = pageControl;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    double page = scrollView.contentOffset.x / scrollView.width;
    // 四舍五入计算出页码
    self.pageControl.currentPage = (int)(page + 0.5);
    // 1.3四舍五入 1.3 + 0.5 = 1.8 强转为整数(int)1.8= 1
    // 1.5四舍五入 1.5 + 0.5 = 2.0 强转为整数(int)2.0= 2
    // 1.6四舍五入 1.6 + 0.5 = 2.1 强转为整数(int)2.1= 2
    // 0.7四舍五入 0.7 + 0.5 = 1.2 强转为整数(int)1.2= 1
}

/**
 *  初始化最后一个imageView
 *
 *  @param imageView 最后一个imageView
 */
- (void)setupLastImageView:(UIImageView *)imageView
{
    // 开启交互功能
    imageView.userInteractionEnabled = YES;
    
    
    
    // 2.开始
    UIButton *startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    startBtn.frame = CGRectMake(0, 0, 100, 40);
    [startBtn setBackgroundImage:[UIImage imageNamed:@"introduction_button.png"] forState:UIControlStateNormal];
//
//    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
//
//    startBtn.size = startBtn.currentBackgroundImage.size;
    startBtn.centerX = screenWidth()/2;
    startBtn.centerY = imageView.height * 0.80;
    
//    [startBtn setTitle:@"开始使用" forState:UIControlStateNormal];
//    [startBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [startBtn addTarget:self action:@selector(startClick:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:startBtn];
}
- (void)startClick:(UIButton *)button
{
    if (_delegate && [_delegate respondsToSelector:@selector(introductionView:button:)]) {
        [_delegate introductionView:self button:button];
    }else {
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        
    }];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
