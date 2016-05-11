//
//  PersonImageTableViewCell.m
//  CSSYQuQi
//
//  Created by cssy-apple on 15/12/7.
//  Copyright © 2015年 cssy-apple. All rights reserved.
//

#import "PersonImageTableViewCell.h"

@implementation PersonImageTableViewCell{
    UILabel *_titleLabel;
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
    
    _titleLabel = [UILabel new];
    _titleLabel.frame = CGRectMake(Margin, (height(self.frame))/2+30, 100, 30);
    _titleLabel.text = @"图像";
    _titleLabel.font = Font(15);
    [self.contentView addSubview:_titleLabel];
    
    _infoImageView = [UIButton buttonWithType:UIButtonTypeCustom];
     NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage.png"];
    _infoImageView.frame = CGRectMake(width(self.frame)-90, Margin, 80, 80);
    [_infoImageView setBackgroundImage:[UIImage imageWithData:[NSData dataWithContentsOfFile:fullPath]] forState:UIControlStateNormal];
    [_infoImageView addTarget:self action:@selector(bigImageView:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_infoImageView];
}
- (void)bigImageView:(UIButton *)button {
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage.png"];
    if (_delegate && [_delegate respondsToSelector:@selector(PersonImageForBig:url:)]) {
        [_delegate PersonImageForBig:self url:fullPath];
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
