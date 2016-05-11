//
//  CommunityTableViewCell.m
//  CSSYQuQi
//
//  Created by cssy-apple on 15/11/20.
//  Copyright (c) 2015年 cssy-apple. All rights reserved.
//

#import "CommunityTableViewCell.h"


@implementation CommunityTableViewCell {
    UIImageView *_userImageView;
    UILabel *_userNameLabel;
    UILabel *_timeLabel;
    UILabel *_contentLabel;
    UIButton *_loveButton;
    UIButton *_replyButton;
    UILabel *_loveLabel;
    UILabel *_replyLabel;
    NSMutableArray *_scrollViewOriginalImages;
    
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.frame = CGRectMake(0, 0, screenWidth(), 0);
        _scrollViewOriginalImages = [NSMutableArray array];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            for (int i=0; i < 4; i++) {
                [_scrollViewOriginalImages addObject:[UIImage imageNamed:@"am.jpg"]];
            }
        });
        
        [self customCell];
    }
    return self;
}
- (void)customCell {
    CGFloat marginLeft = 10;
    _userImageView = [UIImageView new];
    _userImageView.frame = CGRectMake(marginLeft, marginLeft, 50, 50);
    _userImageView.clipsToBounds = YES;
    _userImageView.layer.cornerRadius = 25;
    _userImageView.backgroundColor = [UIColor blueColor];
    _userImageView.image = [UIImage imageNamed:@"girl.png"];
    [self.contentView addSubview:_userImageView];
    
    _userNameLabel = [UILabel new];
    _userNameLabel.frame = CGRectMake(maxX(_userImageView)+10, marginLeft, width(self.frame) - width(_userImageView.frame) - 2*marginLeft, 20);
    _userNameLabel.text = @"11111";
    _userNameLabel.font = [UIFont boldSystemFontOfSize:15];
    [self.contentView addSubview:_userNameLabel];
    
    _timeLabel = [UILabel new];
    _timeLabel.frame = CGRectMake(minX(_userNameLabel), maxY(_userNameLabel)+marginLeft, width(_userNameLabel.frame), 10);
    _timeLabel.text = @"2小时前";
    _timeLabel.font = [UIFont boldSystemFontOfSize:13];
    [self.contentView addSubview:_timeLabel];
    
    _contentLabel = [UILabel new];
    _contentLabel.text = TestStr;
    _contentLabel.numberOfLines = 0;
    _contentLabel.font = FontSystem(13);
    [self.contentView addSubview:_contentLabel];
    
    _loveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_loveButton setBackgroundImage:[UIImage imageNamed:@"love_low.png"] forState:UIControlStateNormal];
    [_loveButton setBackgroundImage:[UIImage imageNamed:@"love_hight.png"] forState:UIControlStateHighlighted];
     [_loveButton addTarget:self action:@selector(loveButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_loveButton];
    
    _loveLabel = [UILabel new];
    _loveLabel.font = FontSystem(13);
    _loveLabel.textColor = [UIColor lightGrayColor];
    _loveLabel.textAlignment = NSTextAlignmentCenter;
    _loveLabel.text = @"10000";
    [self.contentView addSubview:_loveLabel];
   

    _replyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_replyButton setBackgroundImage:[UIImage imageNamed:@"reply.png"] forState:UIControlStateNormal];
    [_replyButton setBackgroundImage:[UIImage imageNamed:@"reply_hight.png"] forState:UIControlStateHighlighted];
    [_replyButton addTarget:self action:@selector(replyButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_replyButton];
    
    _replyLabel = [UILabel new];
    _replyLabel.font = FontSystem(13);
    _replyLabel.textColor = [UIColor lightGrayColor];
    _replyLabel.textAlignment = NSTextAlignmentCenter;
    _replyLabel.text = @"99";
    [self.contentView addSubview:_replyLabel];
    
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat heights = Height(TestStr, width(self.frame)-80, 13);
    CGFloat loveWidth = Width(_loveLabel.text, 25, 13);
    CGFloat replyWidth = Width(_replyLabel.text, 25, 13);
    _contentLabel.frame = CGRectMake(minX(_userNameLabel), maxY(_timeLabel)+5, width(_userNameLabel.frame)-5, heights);
    [self createIamgeView];
    _loveButton.frame = CGRectMake(width(self.frame)-70 - loveWidth - replyWidth, height(self.frame)-30, 25, 25);
    _loveLabel.frame = CGRectMake(maxX(_loveButton)+5, minY(_loveButton), loveWidth, 25);
    _replyButton.frame = CGRectMake(maxX(_loveLabel)+5, minY(_loveLabel), 25, 25);
    _replyLabel.frame = CGRectMake(maxX(_replyButton)+5, minY(_loveLabel), replyWidth, 25);
}
- (void)createIamgeView {
    CGFloat margin = 5;
    CGFloat imageWidth = (width(_userNameLabel.frame)-margin*3)/3;
    for (int i = 0; i < 4; i++) {
        UIButton *imageView = [[UIButton alloc] initWithFrame:CGRectMake(minX(_userNameLabel) + (margin + imageWidth)*(i%3), margin + maxY(_contentLabel) + (margin + imageWidth)*(i/3), imageWidth, imageWidth)];
        imageView.tag = 120 + i;
        [imageView setBackgroundImage:[UIImage imageNamed:@"am.jpg"] forState:UIControlStateNormal];
        [imageView addTarget:self action:@selector(tapClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:imageView];
        
        
    }
}
//点赞
- (void)loveButton:(UIButton *)button {
    if ([[NSUserDefaults standardUserDefaults] boolForKey:IsLogin]) {
        
        
    }else {
        SHOW_ALERT(@"请先登录！");
    }
}
//回复
- (void)replyButton:(UIButton *)button {
    if ([[NSUserDefaults standardUserDefaults] boolForKey:IsLogin]) {
        if (_replyDelegate && [_replyDelegate respondsToSelector:@selector(communityReply:)]) {
            [_replyDelegate communityReply:self];
        }
    }else {
        SHOW_ALERT(@"请先登录！");
    }
}
//点击图片滚动查看
- (void)tapClick:(UIButton *)buton {
    if (_delegate && [_delegate respondsToSelector:@selector(CommunityTableViewCell:scrollViewOriginalImages:index:)]) {
        [_delegate CommunityTableViewCell:self scrollViewOriginalImages:_scrollViewOriginalImages index:buton.tag - 120];
    }
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
