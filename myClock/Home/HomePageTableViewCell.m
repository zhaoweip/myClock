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

    UILabel *title = [[UILabel alloc] init];
    title.text = @"丁酉";
    title.textColor = [UIColor whiteColor];
    title.font = [UIFont systemFontOfSize:23];
    [self addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(clockImg.mas_right).offset(10);
        make.centerY.equalTo(clockImg);
    }];
    
    UILabel *describe = [[UILabel alloc] init];
    describe.text = @"今晚七点，新闻联播。";
    describe.textColor = [UIColor whiteColor];
    describe.font = [UIFont systemFontOfSize:12];
    [self addSubview:describe];
    [describe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(title.mas_left);
        make.top.equalTo(title.mas_bottom).offset(5);
    }];

    UIButton *button = [[UIButton alloc] init];
    [button setImage:[UIImage imageNamed:@"home_clock_normal.png"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"home_clock_selected.png"] forState:UIControlStateSelected];
    [self addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
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
