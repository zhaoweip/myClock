//
//  HomePageTableViewCell.m
//  myClock
//
//  Created by Macintosh on 18/10/17.
//  Copyright © 2017年 Macintosh. All rights reserved.
//

#import "HomePageTableViewCell.h"

@implementation HomePageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    //labelTagImg
    UIImageView *clockImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_clock.png"]];
    [self addSubview:clockImg];
    [clockImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(18);
        make.height.mas_equalTo(18);
        make.left.mas_equalTo(25);
        make.top.mas_equalTo(15);
    }];

    _title = [[UILabel alloc] init];
//    title.text = @"丁酉";
    _title.textColor = [UIColor whiteColor];
    _title.font = [UIFont systemFontOfSize:23];
    [self addSubview:_title];
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(clockImg.mas_right).offset(10);
        make.centerY.equalTo(clockImg);
    }];
    
    _describe = [[UILabel alloc] init];
//    describe.text = @"今晚七点，新闻联播。";
    _describe.textColor = [UIColor whiteColor];
    _describe.font = [UIFont systemFontOfSize:12];
    [self addSubview:_describe];
    [_describe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_title.mas_left);
        make.top.equalTo(_title.mas_bottom).offset(5);
    }];

    UISwitch *switchBtn = [[UISwitch alloc]init];
    switchBtn.on = YES;
    switchBtn.onTintColor = [UIColor colorWithRed:245/255.0 green:218/255.0 blue:142/255.0 alpha:1];
    switchBtn.tintColor = [UIColor colorWithRed:30/255.0 green:56/255.0 blue:90/255.0 alpha:1];
    [self addSubview:switchBtn];
    [switchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-21);
        make.centerY.equalTo(self);
    }];
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
