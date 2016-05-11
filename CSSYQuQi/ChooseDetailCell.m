//
//  ChooseDetailCell.m
//  CSSYQuQi
//
//  Created by cssy-apple on 15/11/27.
//  Copyright (c) 2015年 cssy-apple. All rights reserved.
//

#import "ChooseDetailCell.h"

@implementation ChooseDetailCell {
    UIButton *_mainImageView;
    UIView *_shadeView;
    UILabel *_imageDetailLabel;
    UILabel *_imageCountLabel;
    UILabel *_titleLabel;
    UILabel *_contryLabel;
    UILabel *_rankLabel;
    UILabel *_displacementLabel;
    NSMutableArray *_scrollViewOriginalImages;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.frame = CGRectMake(0, 0, screenWidth(), 0);
        _scrollViewOriginalImages = [NSMutableArray array];
        [self customCell];
    }
    return self;
}
- (void)customCell {
    CGFloat margin = 10;
    _mainImageView = [UIButton buttonWithType:UIButtonTypeCustom];
    _mainImageView.frame = CGRectMake(margin, margin, 90, 90);
    [_mainImageView addTarget:self action:@selector(imageDetail:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_mainImageView];
    
    _shadeView = [UIView new];
    _shadeView.frame = CGRectMake( 0, height(_mainImageView.frame)-20, width(_mainImageView.frame), 20);
    _shadeView.backgroundColor = [UIColor blackColor];
    _shadeView.alpha = 0.45;
    [_mainImageView addSubview:_shadeView];
    
    _imageDetailLabel = [UILabel new];
    _imageDetailLabel.frame = CGRectMake(0, 5, 40, 15);
    _imageDetailLabel.text = @"车型图解";
    _imageDetailLabel.textColor = [UIColor whiteColor];
    _imageDetailLabel.font = FontSystem(10);
    [_shadeView addSubview:_imageDetailLabel];
    
    _imageCountLabel = [UILabel new];
    _imageCountLabel.frame = CGRectMake(width(_mainImageView.frame)-40, minY(_imageDetailLabel), 40, 15);
    _imageCountLabel.text = @"100张";
    _imageCountLabel.textAlignment = NSTextAlignmentRight;
    _imageCountLabel.font = FontSystem(10);
    _imageCountLabel.textColor = [UIColor whiteColor];
    [_shadeView addSubview:_imageCountLabel];
    
    _titleLabel = [UILabel new];
    _titleLabel.frame = CGRectMake(margin + maxX(_mainImageView), minY(_mainImageView), width(self.frame)-width(_mainImageView.frame)-3*margin, 30);
    //_titleLabel.backgroundColor = [UIColor redColor];
    _titleLabel.font = Font(15);
    [self.contentView addSubview:_titleLabel];
    
    _contryLabel = [UILabel new];
    _contryLabel.frame = CGRectMake(minX(_titleLabel), maxY(_titleLabel)+5, width(_titleLabel.frame), 15);
    //_contryLabel.backgroundColor = [UIColor blueColor];
    _contryLabel.font = FontSystem(13);
    _contryLabel.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:_contryLabel];
    
    _rankLabel = [UILabel new];
    _rankLabel.frame = CGRectMake(minX(_titleLabel), maxY(_contryLabel)+5, width(_titleLabel.frame), 15);
    //_rankLabel.backgroundColor = [UIColor orangeColor];
    _rankLabel.font = FontSystem(13);
    _rankLabel.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:_rankLabel];
    
    _displacementLabel = [UILabel new];
    _displacementLabel.frame = CGRectMake(minX(_titleLabel), maxY(_rankLabel)+5, width(_titleLabel.frame), 15);
    //_displacementLabel.backgroundColor = [UIColor redColor];
    _displacementLabel.font = FontSystem(13);
    _displacementLabel.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:_displacementLabel];
    
    
    [self reloadCell];
}
- (void)reloadCell {
    [_mainImageView setBackgroundImage:[UIImage imageNamed:@"am.jpg"] forState:UIControlStateNormal];
    _titleLabel.text = @"赛欧两厢";
    _contryLabel.text = @"国别：美国";
    _rankLabel.text = @"级别：小型车";
    _displacementLabel.text = @"排量：1.2L 1.4L";
    
    for (int i = 0 ; i < 100; i++) {
        [_scrollViewOriginalImages addObject:[UIImage imageNamed:@"am.jpg"]];
    }
    
}
- (void)imageDetail:(UIButton *)button {
    if (_delegate && [_delegate respondsToSelector:@selector(chooseDetail:scrollViewOriginalImages:)]) {
        [_delegate chooseDetail:self scrollViewOriginalImages:_scrollViewOriginalImages];
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
