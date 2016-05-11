//
//  XunJiaInfoTableViewCell.m
//  CSSYQuQi
//
//  Created by cssy-apple on 15/12/2.
//  Copyright (c) 2015年 cssy-apple. All rights reserved.
//

#import "XunJiaInfoTableViewCell.h"

@implementation XunJiaInfoTableViewCell {
    UIImageView *_userNameImageView;
    UIImageView *_phoneImageView;
    UILabel *_lineLabel;
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
    
    _userNameImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    _userNameImageView.image = [UIImage imageNamed:@"irn.png"];
    
    
    _userNameText = [[UITextField alloc] init];
    _userNameText.frame = CGRectMake(Margin, Margin, width(self.frame)-2*Margin, 30);
    _userNameText.leftView = _userNameImageView;
    _userNameText.leftViewMode = UITextFieldViewModeAlways;
    _userNameText.placeholder = @"请输入姓名...";
    _userNameText.delegate = self;
    [self.contentView addSubview:_userNameText];
    
    _lineLabel = [UILabel new];
    _lineLabel.frame = CGRectMake(0, maxY(_userNameText)+5, width(self.frame), 1);
    _lineLabel.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:_lineLabel];
    
    _phoneImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    _phoneImageView.image = [UIImage imageNamed:@"label_phone.png"];
    _phoneImageView.alpha = 0.5;
    
    _phoneText = [[UITextField alloc] init];
    _phoneText.frame = CGRectMake(Margin, maxY(_lineLabel)+Margin, width(self.frame)-2*Margin, 30);
    _phoneText.leftView = _phoneImageView;
    _phoneText.leftViewMode = UITextFieldViewModeAlways;
    _phoneText.placeholder = @"请输入手机号...";
    _phoneText.delegate = self;
    [self.contentView addSubview:_phoneText];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return YES;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
