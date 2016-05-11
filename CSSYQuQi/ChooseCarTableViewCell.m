//
//  ChooseCarTableViewCell.m
//  CSSYQuQi
//
//  Created by cssy-apple on 15/11/20.
//  Copyright (c) 2015年 cssy-apple. All rights reserved.
//

#import "ChooseCarTableViewCell.h"

@implementation ChooseCarTableViewCell {
    UILabel *_titleLabelHot;
    UILabel *_lineLabelHot;
    CGFloat _imageWidth;
    CGFloat _marginLeft;
    UILabel *_titleLabelMajor;
    UILabel *_lineLabelMajor;
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
    
//    UIView *viewHot = [[UIView alloc] init];
//    viewHot.frame = CGRectMake(0, 0, width(self.frame), 15);
//    viewHot.backgroundColor = [UIColor groupTableViewBackgroundColor];
//    [self.contentView addSubview:viewHot];
    
    _titleLabelHot = [[UILabel alloc] init];
    _titleLabelHot.frame = CGRectMake(0, 0, width(self.frame), 29.4);
    _titleLabelHot.text = @"热门品牌";
    _titleLabelHot.font = FontSystem(15);
    [self.contentView addSubview:_titleLabelHot];
    
    _lineLabelHot = [[UILabel alloc] init];
    _lineLabelHot.frame = CGRectMake(0, maxY(_titleLabelHot), width(self.frame), 0.6);
    _lineLabelHot.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:_lineLabelHot];
    
    [self createHotImageView];
    
    UIView *viewMajor = [[UIView alloc] init];
    viewMajor.frame = CGRectMake(0, maxY(_lineLabelHot) + 2*(_imageWidth + 10 + _marginLeft), width(self.frame), 15);
    viewMajor.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.contentView addSubview:viewMajor];
    
    _titleLabelMajor = [[UILabel alloc] init];
    _titleLabelMajor.frame = CGRectMake(0, maxY(viewMajor), width(self.frame), 29.4);
    _titleLabelMajor.text = @"主打车";
    _titleLabelMajor.font = FontSystem(15);
    [self.contentView addSubview:_titleLabelMajor];
    
    _lineLabelMajor = [[UILabel alloc] init];
    _lineLabelMajor.frame = CGRectMake(0, maxY(_titleLabelMajor), width(self.frame), 0.6);
    _lineLabelMajor.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:_lineLabelMajor];
    
    [self createMajorImageView];
}
- (void)createMajorImageView {
    
    CGFloat imageWidthMajor = (width(self.frame) - 4*_marginLeft)/3;
    for (int i = 0; i < 3; i++) {
        UIButton *imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        imageButton.frame = CGRectMake(_marginLeft + (imageWidthMajor + _marginLeft)*i, 10 + maxY(_lineLabelMajor), imageWidthMajor, imageWidthMajor - 10);
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(minX(imageButton), maxY(imageButton)+5, imageWidthMajor, 10)];
        [imageButton setBackgroundImage:[UIImage imageNamed:@"benz.png"] forState:UIControlStateNormal];
        
        [imageButton addTarget:self action:@selector(clickMajorCar:) forControlEvents:UIControlEventTouchUpInside];
        label.text = @"雪弗兰";
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont boldSystemFontOfSize:13];
        [self.contentView addSubview:imageButton];
        [self.contentView addSubview:label];
    }
}

- (void)createHotImageView {
    
    _marginLeft = 10;
    _imageWidth = (width(self.frame) - 10*_marginLeft)/5;
    for (int i = 0; i < 10; i++) {
        UIButton *imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        imageButton.frame = CGRectMake(_marginLeft+(_imageWidth + 2*_marginLeft)*(i%5), maxY(_lineLabelHot) + _marginLeft +(_imageWidth + 10)*(i/5), _imageWidth, _imageWidth);
        
        [imageButton setBackgroundImage:[UIImage imageNamed:@"benz.png"] forState:UIControlStateNormal];
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(minX(imageButton), maxY(imageButton), _imageWidth, 10);
        
        [imageButton addTarget:self action:@selector(clickHotCar:) forControlEvents:UIControlEventTouchUpInside];
        label.text = @"雪弗兰";
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont boldSystemFontOfSize:10];
        [self.contentView addSubview:label];
        [self.contentView addSubview:imageButton];
    }
}
- (void)clickMajorCar:(UIButton *)button {
    if (_chooseCarSkipDetaelDelegate && [_chooseCarSkipDetaelDelegate respondsToSelector:@selector(chooseCarSkipDetail:string:)]) {
        [_chooseCarSkipDetaelDelegate chooseCarSkipDetail:self string:@"雪弗兰"];
    }
}
- (void)clickHotCar:(UIButton *)button {
    if (_chooseCarSkipDetaelDelegate && [_chooseCarSkipDetaelDelegate respondsToSelector:@selector(chooseCarSkipDetail:string:)]) {
        [_chooseCarSkipDetaelDelegate chooseCarSkipDetail:self string:@"雪弗兰"];
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
