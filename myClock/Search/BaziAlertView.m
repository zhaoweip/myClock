//
//  BaziAlertView.m
//  myClock
//
//  Created by Macintosh on 20/10/17.
//  Copyright © 2017年 Macintosh. All rights reserved.
//

#import "BaziAlertView.h"
#import "Bazi.h"

#define BaziContentWidth         SCREEN_WIDTH*0.85
#define BaziContentHeight        FitSize(250,250,250,250)
#define CharacterLeftMargin      FitSize(20,20,30,20)
#define SiZhuTitleLeftMargin     FitSize(10,10,20,20)
#define CharacterWidth           FitSize(240,280,300,290)

@interface BaziAlertView()

@property (nonatomic, strong) UIVisualEffectView *baziAlertView;
@property (nonatomic, strong) UIView *baziContent;

@property (nonatomic, strong) UIView *timeView;
@property (nonatomic, strong) UIView *baziView;
@property (nonatomic, strong) UIView *characterView;

@property (nonatomic, strong) UILabel *timeTag;
@property (nonatomic, strong) UILabel *character;

@end

@implementation BaziAlertView

- (void)layoutSubviews{
    [super layoutSubviews];
    
    //八字模版
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    _baziAlertView = [[UIVisualEffectView alloc] initWithEffect:effect];
    _baziAlertView.alpha = 0.8;
    _baziAlertView.frame = self.frame;
    [self addSubview:_baziAlertView];
    
    _baziContent = [[UIView alloc] init];
    _baziContent.alpha = 0.5;
    _baziContent.backgroundColor = [UIColor blackColor];
    _baziContent.layer.cornerRadius = 10;
    [self addSubview:_baziContent];
    [_baziContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(BaziContentWidth);
        make.height.mas_equalTo(BaziContentHeight);
        make.center.equalTo(self);
    }];
    
    _timeView = [[UIView alloc] init];
    [_baziContent addSubview:_timeView];
    [_timeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(50);
    }];
    
    _timeTag = [[UILabel alloc] init];
    _timeTag.text = _bazi.detailTime;
    _timeTag.textColor = [UIColor whiteColor];
    [_timeView addSubview:_timeTag];
    [_timeTag mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(15);
    }];
    
    [self createOneSiZhuWithSequence:0 title:@"时" tianGan:_bazi.timeTianGan diZhi:_bazi.timeDiZhi];
    [self createOneSiZhuWithSequence:1 title:@"日" tianGan:_bazi.dataTianGan diZhi:_bazi.dataDiZhi];
    [self createOneSiZhuWithSequence:2 title:@"月" tianGan:_bazi.monthTianGan diZhi:_bazi.monthDiZhi];
    [self createOneSiZhuWithSequence:3 title:@"年" tianGan:_bazi.yearTianGan diZhi:_bazi.yearDiZhi];


    _character = [[UILabel alloc] init];
    _character.text = _bazi.character;
    _character.numberOfLines = 0;
    _character.textColor = [UIColor whiteColor];
    [_baziContent addSubview:_character];
    [_character mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(CharacterWidth);
        make.left.mas_equalTo(CharacterLeftMargin);
        make.top.equalTo(_baziView.mas_bottom).offset(15);
    }];
    
    [WPLayoutUtils addBottomDivider:_timeView size:0.5 color:[UIColor whiteColor] leftEdge:0 rightEdge:0];
    [WPLayoutUtils addBottomDivider:_baziView size:0.5 color:[UIColor whiteColor] leftEdge:0 rightEdge:0];
    
}
- (void)createOneSiZhuWithSequence:(NSInteger)sequence title:(NSString *)siZhuName tianGan:(NSString *)tianGan diZhi:(NSString *)diZhi{
    
    _baziView = [[UIView alloc] init];
//    _baziView.backgroundColor = [UIColor greenColor];
    [_baziContent addSubview:_baziView];
    [_baziView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_timeView.mas_bottom);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(100);
    }];
    
    UIView *contentView = [[UIView alloc] init];
//    contentView.backgroundColor = randomColor;
    [_baziView addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_baziView.mas_left).offset(BaziContentWidth/4 * sequence);
        make.top.equalTo(_timeView.mas_bottom);
        make.width.mas_equalTo(BaziContentWidth/4);
        make.height.mas_equalTo(100);
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

@end
