//
//  NewCarTableViewCell.m
//  CSSYQuQi
//
//  Created by cssy-apple on 15/11/19.
//  Copyright (c) 2015年 cssy-apple. All rights reserved.
//

#import "NewCarTableViewCell.h"

@implementation NewCarTableViewCell {

    UIImageView *_mainImageView;
    UILabel *_titleLabel;
    UILabel *_timeLabel;
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
    _mainImageView = [[UIImageView alloc] init];
    _mainImageView.frame = CGRectMake(marginLeft, marginLeft, 100, 80);
    _mainImageView.backgroundColor = [UIColor redColor];
    _mainImageView.image = [UIImage imageNamed:@"ex.jpg"];
    [self.contentView addSubview:_mainImageView];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.frame = CGRectMake(maxX(_mainImageView)+marginLeft, minY(_mainImageView), width(self.frame)-width(_mainImageView.frame)-3*marginLeft, 60);
    
    _titleLabel.text = @"12月初上市 红标哈弗h1更多信息曝光";
    _titleLabel.numberOfLines = 0;
    _titleLabel.font = FontSystem(15);
    [self.contentView addSubview:_titleLabel];
    
    _timeLabel = [[UILabel alloc] init];
    _timeLabel.frame = CGRectMake(minX(_titleLabel), maxY(_titleLabel)+marginLeft, 80, 10);
    
    _timeLabel.text = @"雪弗兰";
    _timeLabel.font = FontSystem(13);
    [self.contentView addSubview:_timeLabel];
}
- (void)reloadCell {
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
