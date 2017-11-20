//
//  HomePageHeaderView.m
//  myClock
//
//  Created by Macintosh on 18/10/17.
//  Copyright © 2017年 Macintosh. All rights reserved.
//

#import "HomePageHeaderView.h"

#define BaziContentWidth         SCREEN_WIDTH*0.8
#define BaziContentHeight        FitSize(100,100,100,100)
#define SiZhuTitleLeftMargin     FitSize(10,10,15,20)


@interface HomePageHeaderView()

@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *dayLabel;
@property (nonatomic, strong) UIView *baziView;


@end

@implementation HomePageHeaderView
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    for(UIView *subView in [self subviews])
    {
        [subView removeFromSuperview];
    }
    
    UIImageView *backImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_header_bg.png"]];
    backImage.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*0.5-30);
    [self addSubview:backImage];
    //labelTagImg
    UIImageView *labelTagImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"label_tag.png"]];
    [self addSubview:labelTagImg];
    [labelTagImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(10);
        make.height.mas_equalTo(10);
        make.left.mas_equalTo(19);
        make.top.equalTo(backImage.mas_bottom).offset(5);
    }];
    UILabel *tag = [[UILabel alloc] init];
    tag.text = @"闹钟";
    [tag setFont:[UIFont fontWithName:@"Helvetica-Bold" size:20]];
    tag.textColor = [UIColor whiteColor];
    [self addSubview:tag];
    [tag mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(labelTagImg.mas_right).offset(6);
        make.centerY.equalTo(labelTagImg);
    }];
    
    UILabel *yijiLabel = [[UILabel alloc] init];
    yijiLabel.text = @"宜/忌";
    [yijiLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:20]];
    yijiLabel.textColor = [UIColor whiteColor];
    yijiLabel.userInteractionEnabled=YES;
    UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ad)];
    [yijiLabel addGestureRecognizer:labelTapGestureRecognizer];
    [self addSubview:yijiLabel];
    [yijiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-30);
        make.bottom.equalTo(self.mas_bottom).offset(-70);
    }];
    
    _dateLabel = [[UILabel alloc] init];
    _dateLabel.text = _dateText;
    _dateLabel.font = [UIFont systemFontOfSize:22];
    [self addSubview:_dateLabel];
    [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(35);
        make.top.mas_equalTo(40);
        make.centerX.equalTo(self);
    }];
    
    _dayLabel = [[UILabel alloc] init];
    _dayLabel.text = _day;
    _dayLabel.font = [UIFont systemFontOfSize:22];
    [self addSubview:_dayLabel];
    [_dayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(_dateLabel.mas_height);
        make.top.equalTo(_dateLabel.mas_bottom);
        make.centerX.equalTo(self);
    }];
    
    
    _baziView = [[UIView alloc] init];
    _baziView.alpha = 0.5;
    _baziView.backgroundColor = [UIColor blackColor];
    _baziView.layer.cornerRadius = 10;
    [self addSubview:_baziView];
    [_baziView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(BaziContentWidth);
        make.height.mas_equalTo(BaziContentHeight);
        make.top.mas_equalTo(130);
        make.centerX.equalTo(self);
    }];
    [self createOneSiZhuWithSequence:0 title:@"时" tianGan:_bazi.timeTianGan diZhi:_bazi.timeDiZhi];
    [self createOneSiZhuWithSequence:1 title:@"日" tianGan:_bazi.dataTianGan diZhi:_bazi.dataDiZhi];
    [self createOneSiZhuWithSequence:2 title:@"月" tianGan:_bazi.monthTianGan diZhi:_bazi.monthDiZhi];
    [self createOneSiZhuWithSequence:3 title:@"年" tianGan:_bazi.yearTianGan diZhi:_bazi.yearDiZhi];
    
}

- (void)createOneSiZhuWithSequence:(NSInteger)sequence title:(NSString *)siZhuName tianGan:(NSString *)tianGan diZhi:(NSString *)diZhi{
    
    UIView *contentView = [[UIView alloc] init];
    [_baziView addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_baziView.mas_left).offset(BaziContentWidth/4 * sequence);
        make.top.equalTo(_baziView);
        make.width.mas_equalTo(BaziContentWidth/4);
        make.height.mas_equalTo(BaziContentHeight);
    }];
    
    UILabel *siZhuTitle = [[UILabel alloc] init];
    siZhuTitle = [[UILabel alloc] init];
    siZhuTitle.text = siZhuName;
    siZhuTitle.textColor = [UIColor whiteColor];
    [contentView addSubview:siZhuTitle];
    [siZhuTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SiZhuTitleLeftMargin);
        make.top.mas_equalTo(15);
    }];
    
    UILabel *tianGanLabel = [[UILabel alloc] init];
    tianGanLabel = [[UILabel alloc] init];
    tianGanLabel.text = tianGan;
    tianGanLabel.font = [UIFont systemFontOfSize:22];
    tianGanLabel.textColor = [UIColor whiteColor];
    [contentView addSubview:tianGanLabel];
    [tianGanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(siZhuTitle.mas_right).offset(7);
        make.top.mas_equalTo(25);
    }];
    
    UILabel *diZhiLabel = [[UILabel alloc] init];
    diZhiLabel = [[UILabel alloc] init];
    diZhiLabel.text = diZhi;
    diZhiLabel.font = [UIFont systemFontOfSize:22];
    diZhiLabel.textColor = [UIColor whiteColor];
    [contentView addSubview:diZhiLabel];
    [diZhiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tianGanLabel.mas_left);
        make.top.mas_equalTo(tianGanLabel.mas_bottom).offset(5);
    }];
}
- (void)ad{
    //通知tabBarVc切换控制器
    if ([_delegate respondsToSelector:@selector(didClickYiJiLabel)]) {
        [_delegate didClickYiJiLabel];
    }
}

@end
