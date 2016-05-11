//
//  PersonInfoTableViewCell.m
//  CSSYQuQi
//
//  Created by cssy-apple on 15/12/7.
//  Copyright © 2015年 cssy-apple. All rights reserved.
//

#import "PersonInfoTableViewCell.h"

@implementation PersonInfoTableViewCell {
    UILabel *_titleLabel;
    UILabel *_infoLabel;
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
    _titleLabel.frame = CGRectMake(Margin, Margin/2, 100, 30);
    _titleLabel.font = Font(15);
    [self.contentView addSubview:_titleLabel];
    
    _infoLabel = [UILabel new];
    _infoLabel.frame = CGRectMake(width(self.frame)-150-Margin, Margin, 150, 30);
    
    _infoLabel.textAlignment = NSTextAlignmentRight;
    _infoLabel.font = Font(15);
    [self.contentView addSubview:_infoLabel];
}
- (void)setNameStr:(NSString *)nameStr {
    _nameStr = nameStr;
    [self reloadCell];
}
- (void)reloadCell {
    _titleLabel.text = _nameStr;
    
    if ([_nameStr isEqualToString:@"昵称"]) {
      _infoLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:UserNickname];
    }else {
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:UserSex] isEqualToString:@" "]) {
            _infoLabel.text = @"请设置";
        }else {
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:UserSex] isEqualToString:@""]) {
                _infoLabel.text = @"未知";
                
            }else {
                _infoLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:UserSex];
            } 
        }
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
