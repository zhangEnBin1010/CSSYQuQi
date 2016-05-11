//
//  MyOrderTableViewCell.m
//  CSSYQuQi
//
//  Created by cssy-apple on 15/12/12.
//  Copyright © 2015年 cssy-apple. All rights reserved.
//

#import "MyOrderTableViewCell.h"

@implementation MyOrderTableViewCell {
    UILabel *_titleLabel;
    UILabel *_lineLabel1;
    UIImageView *_CarImageView;
    UILabel *_timeLabel;
    UILabel *_priceLabel;
    UILabel *_lineLabel2;
    UIButton *_cancelOrderButton;
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
    _titleLabel.frame = CGRectMake(Margin, Margin, width(self.frame)-2*Margin, 30);
    _titleLabel.font = Font(15);
    [self.contentView addSubview:_titleLabel];
    
    _lineLabel1 = [UILabel new];
    _lineLabel1.frame = CGRectMake(0, maxY(_titleLabel)+Margin, width(self.frame), 0.2);
    _lineLabel1.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:_lineLabel1];
    
    _CarImageView = [UIImageView new];
    _CarImageView.frame = CGRectMake(Margin, maxY(_lineLabel1)+Margin, 60, 60);
    [self.contentView addSubview:_CarImageView];
    
    _timeLabel = [UILabel new];
    _timeLabel.frame = CGRectMake(maxX(_CarImageView)+Margin, minY(_CarImageView), width(self.frame)-width(_CarImageView.frame)-3*Margin, 20);
    _timeLabel.font = Font(13);
    _timeLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:_timeLabel];
    
    _priceLabel = [UILabel new];
    _priceLabel.frame = CGRectMake(minX(_timeLabel), maxY(_CarImageView)-20, width(_timeLabel.frame), 20);
    _priceLabel.font = Font(13);
    _priceLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:_priceLabel];
    
    _lineLabel2 = [UILabel new];
    _lineLabel2.frame = CGRectMake(0, maxY(_CarImageView)+Margin, width(self.frame), 0.2);
    _lineLabel2.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:_lineLabel2];
    
    _cancelOrderButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancelOrderButton.frame = CGRectMake(width(self.frame)-2*Margin-60, maxY(_lineLabel2)+5, 60, 35);
    [_cancelOrderButton setBackgroundColor:ZEBColor(26, 166, 255)];
    [_cancelOrderButton setTitle:@"退款" forState:UIControlStateNormal];
    [_cancelOrderButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _cancelOrderButton.titleLabel.font = Font(12);
    [_cancelOrderButton addTarget:self action:@selector(cancalOrder:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_cancelOrderButton];
    [self reloadCell];
}
- (void)reloadCell {
    _titleLabel.text = @"福特野马2015";
    _CarImageView.image = [UIImage imageNamed:@"biyadiS1.jpg"];
    _timeLabel.text = @"下单时间：2015-12-11 17:44";
    _priceLabel.text = @"金额5 0000.0";
}
- (void)cancalOrder:(UIButton *)button {
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
