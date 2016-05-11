//
//  CommunityDetailDownCell.m
//  CSSYQuQi
//
//  Created by cssy-apple on 15/11/25.
//  Copyright (c) 2015年 cssy-apple. All rights reserved.
//

#import "CommunityDetailDownCell.h"

@implementation CommunityDetailDownCell {
    UIImageView *_userImageView;
    UILabel *_userName;
    UILabel *_timeLabel;
    UILabel *_contentLabel;
   
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.frame = CGRectMake(0, 0, screenWidth(), 0);
        [self customCell];
    }
    return self;
}
- (void)customCell {
    
    CGFloat margin = 10;
    _userImageView = [UIImageView new];
    _userImageView.frame = CGRectMake(margin, margin, 60, 60);
    _userImageView.clipsToBounds = YES;
    _userImageView.layer.cornerRadius = 30;
    _userImageView.image = [UIImage imageNamed:@"girl.png"];
    [self.contentView addSubview:_userImageView];
    
    _userName = [UILabel new];
    _userName.frame = CGRectMake(maxX(_userImageView)+margin, minY(_userImageView), width(self.frame)-width(_userImageView.frame)-3*margin, 30);
    _userName.text = @"222";
    _userName.font = Font(15);
    [self.contentView addSubview:_userName];
    
    _timeLabel = [UILabel new];
    _timeLabel.frame = CGRectMake(maxX(_userImageView)+margin, maxY(_userName)+5, width(_userName.frame), 15);
    _timeLabel.text = @"一小时前";
    _timeLabel.font = Font(13);
    [self.contentView addSubview:_timeLabel];
    
    _contentLabel = [UILabel new];
    _contentLabel.text = TestStr;
    _contentLabel.font = FontSystem(15);
    _contentLabel.numberOfLines = 0;
    [self.contentView addSubview:_contentLabel];
    
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat height = Height(TestStr, width(_userName.frame), 15);
    CGFloat margin = 10;
    _contentLabel.frame = CGRectMake(maxX(_userImageView)+margin, maxY(_timeLabel)+margin, width(_userName.frame), height);
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
