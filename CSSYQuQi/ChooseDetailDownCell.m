//
//  ChooseDetailDownCell.m
//  CSSYQuQi
//
//  Created by cssy-apple on 15/11/27.
//  Copyright (c) 2015年 cssy-apple. All rights reserved.
//

#import "ChooseDetailDownCell.h"

@implementation ChooseDetailDownCell {
    UILabel *_titleLabel;
    UILabel *_priceLabel;
    UILabel *_desLabel;
    UIButton *_consultButton;
    UIButton *_payButton;
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
    
    CGFloat margin = 10;
    _titleLabel = [UILabel new];
    _titleLabel.frame = CGRectMake(margin, margin, width(self.frame)-2*margin, 20);
    _titleLabel.font = Font(15);
    //_titleLabel.backgroundColor = [UIColor blueColor];
    [self.contentView addSubview:_titleLabel];
    
    _priceLabel = [UILabel new];
    _priceLabel.frame = CGRectMake(minX(_titleLabel), maxY(_titleLabel)+5, width(_titleLabel.frame), 15);
    _priceLabel.font = FontSystem(13);
    _priceLabel.textColor = [UIColor lightGrayColor];
    //_priceLabel.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:_priceLabel];
    
    _desLabel = [UILabel new];
    _desLabel.frame = CGRectMake(minX(_titleLabel), maxY(_priceLabel)+5, width(_titleLabel.frame), 15);
    _desLabel.font = FontSystem(13);
    _desLabel.textColor = [UIColor lightGrayColor];
   // _desLabel.backgroundColor = [UIColor purpleColor];
    [self.contentView addSubview:_desLabel];
    
    _consultButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _consultButton.frame = CGRectMake(width(self.frame)-70, maxY(_desLabel)+10, 60, 25);
    [_consultButton setTitle:@"免费询问" forState:UIControlStateNormal];
    [_consultButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _consultButton.titleLabel.font = Font(13);
    _consultButton.layer.borderWidth = 0.8;
    _consultButton.layer.borderColor = [[UIColor orangeColor] CGColor];
    _consultButton.layer.cornerRadius = 6;
    [_consultButton addTarget:self action:@selector(consultButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_consultButton];
    
    _payButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _payButton.frame = CGRectMake(minX(_consultButton)-70, minY(_consultButton), 60, 25);
    [_payButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_payButton setTitle:@"支付订金" forState:UIControlStateNormal];
    _payButton.titleLabel.font = Font(13);
    _payButton.layer.borderWidth = 0.8;
    _payButton.layer.borderColor = [[UIColor orangeColor] CGColor];
    _payButton.layer.cornerRadius = 6;
    [_payButton addTarget:self action:@selector(payButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_payButton];
    
    [self reloadCell];
}
- (void)reloadCell {
    _titleLabel.text = @"2013新款";
    _priceLabel.text = @"11.2万";
    _desLabel.text = @"最新款";
}
- (void)payButton:(UIButton *)button {
    
}
- (void)consultButton:(UIButton *)button {
    if (_chooseDetailDownDelegate && [_chooseDetailDownDelegate respondsToSelector:@selector(chooseDetailDown:)]) {
        [_chooseDetailDownDelegate chooseDetailDown:self];
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
