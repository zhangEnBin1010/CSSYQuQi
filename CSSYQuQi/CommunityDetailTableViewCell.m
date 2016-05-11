//
//  CommunityDetailTableViewCell.m
//  CSSYQuQi
//
//  Created by cssy-apple on 15/11/25.
//  Copyright (c) 2015年 cssy-apple. All rights reserved.
//

#import "CommunityDetailTableViewCell.h"

@implementation CommunityDetailTableViewCell {
    UIImageView *_userImageView;
    UILabel *_userNameLabel;
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
    CGFloat marginLeft = 10;
    _userImageView = [UIImageView new];
    _userImageView.frame = CGRectMake(marginLeft, marginLeft, 50, 50);
    _userImageView.clipsToBounds = YES;
    _userImageView.layer.cornerRadius = 25;
    _userImageView.image = [UIImage imageNamed:@"girl.png"];
    [self.contentView addSubview:_userImageView];
    
    _userNameLabel = [UILabel new];
    _userNameLabel.frame = CGRectMake(maxX(_userImageView)+10, marginLeft, width(self.frame) - width(_userImageView.frame) - 2*marginLeft, 20);
    _userNameLabel.text = @"1111";
    _userNameLabel.font = Font(15);
    [self.contentView addSubview:_userNameLabel];
    
    _timeLabel = [UILabel new];
    _timeLabel.frame = CGRectMake(minX(_userNameLabel), maxY(_userNameLabel)+marginLeft, width(_userNameLabel.frame), 10);
    _timeLabel.text = @"2小时前";
    _timeLabel.font = Font(13);
    [self.contentView addSubview:_timeLabel];
    
    _contentLabel = [UILabel new];
    _contentLabel.font = FontSystem(13);
    _contentLabel.numberOfLines = 0;
    _contentLabel.text = TestStr;
    [self.contentView addSubview:_contentLabel];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat height = Height(TestStr, width(self.frame)-80, 15);
    _contentLabel.frame = CGRectMake(minX(_userNameLabel), maxY(_timeLabel)+5, width(_userNameLabel.frame)-5, height);
    [self createIamgeView];
    
}
- (void)createIamgeView {
    
    CGFloat margin = 10;
    for (int i = 0; i < 4; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(minX(_contentLabel), (maxY(_contentLabel)+margin)+(100+2*margin)*i, width(self.frame)-100, 100)];
        
        imageView.image = [UIImage imageNamed:@"am.jpg"];
        [self.contentView addSubview:imageView];
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
