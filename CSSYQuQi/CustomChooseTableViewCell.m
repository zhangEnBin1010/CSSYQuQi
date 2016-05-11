//
//  CustomChooseTableViewCell.m
//  CSSYQuQi
//
//  Created by cssy-apple on 15/11/23.
//  Copyright (c) 2015年 cssy-apple. All rights reserved.
//

#import "CustomChooseTableViewCell.h"

@implementation CustomChooseTableViewCell {
    UIImageView *_mainImageView;
    UILabel *_titleLabel;
    UILabel *_priceLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.frame = CGRectMake(0, 0, screenWidth(), 0);
        [self createCell];
    }
    return self;
}
- (void)createCell {
    CGFloat marginLeft = 10;
    _mainImageView = [UIImageView new];
    _mainImageView.frame = CGRectMake(marginLeft, marginLeft, 80, 80);
    _mainImageView.backgroundColor = [UIColor redColor];
    _mainImageView.image = [UIImage imageNamed:@"ex.jpg"];
    [self.contentView addSubview:_mainImageView];
    
    _titleLabel = [UILabel new];
    _titleLabel.frame = CGRectMake(maxX(_mainImageView)+marginLeft, minY(_mainImageView), width(self.frame)-width(_mainImageView.frame)-3*marginLeft, 40);
    
    _titleLabel.font = FontSystem(15);
    [self.contentView addSubview:_titleLabel];
    
    _priceLabel = [UILabel new];
    _priceLabel.frame = CGRectMake(minX(_titleLabel), maxY(_titleLabel)+marginLeft, width(_titleLabel.frame), 20);
    _priceLabel.text = @"12.3～20.14万";
    _priceLabel.font = FontSystem(13);
    [self.contentView addSubview:_priceLabel];
}
- (void)setName:(NSString *)name {
    _name = name;
    [self reloadCell];
}
- (void)reloadCell {
    _titleLabel.text = _name;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
