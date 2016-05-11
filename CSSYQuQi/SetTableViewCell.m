//
//  SetTableViewCell.m
//  CSSYQuQi
//
//  Created by cssy-apple on 15/12/8.
//  Copyright © 2015年 cssy-apple. All rights reserved.
//

#import "SetTableViewCell.h"

@implementation SetTableViewCell {

    UILabel *_quitLabel;
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
    _quitLabel = [UILabel new];
    _quitLabel.frame = CGRectMake(0, 0, 100, 30);
    _quitLabel.center = CGPointMake(width(self.frame)/2, 25);
    _quitLabel.text = @"退出登录";
    _quitLabel.textColor = [UIColor redColor];
    _quitLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_quitLabel];
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
