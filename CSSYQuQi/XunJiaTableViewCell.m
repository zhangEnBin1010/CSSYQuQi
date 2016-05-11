//
//  XunJiaTableViewCell.m
//  CSSYQuQi
//
//  Created by cssy-apple on 15/12/2.
//  Copyright (c) 2015年 cssy-apple. All rights reserved.
//

#import "XunJiaTableViewCell.h"

@implementation XunJiaTableViewCell {
    UIImageView *_carImageView;
    UILabel *_titleLabel;
    UILabel *_desLabel;
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
    _carImageView = [[UIImageView alloc] init];
    _carImageView.frame = CGRectMake(Margin, Margin, 80, 80);
    _carImageView.image = [UIImage imageNamed:@"am.jpg"];
    [self.contentView addSubview:_carImageView];
    
    _titleLabel = [UILabel new];
    _titleLabel.frame = CGRectMake(maxX(_carImageView)+Margin, minY(_carImageView)+Margin, width(self.frame)-width(_carImageView.frame)-3*Margin, 20);
    _titleLabel.text = @"宝马";
    _titleLabel.font = Font(15);
    [self.contentView addSubview:_titleLabel];
    
    _desLabel = [UILabel new];
    _desLabel.frame = CGRectMake(minX(_titleLabel), maxY(_titleLabel)+Margin, width(_titleLabel.frame), 20);
    _desLabel.text = @"2015款 升级版 1.5t 手动 两驱";
    _desLabel.font = Font(13);
    [self.contentView addSubview:_desLabel];
    
    
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

    [self.contentView endEditing:YES];
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
