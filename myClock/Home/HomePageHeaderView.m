//
//  HomePageHeaderView.m
//  myClock
//
//  Created by Macintosh on 18/10/17.
//  Copyright © 2017年 Macintosh. All rights reserved.
//

#import "HomePageHeaderView.h"

@implementation HomePageHeaderView


- (void)layoutSubviews
{
    [super layoutSubviews];
    
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
    tag.text = @"闹钟提醒";
    [tag setFont:[UIFont fontWithName:@"Helvetica-Bold" size:20]];
    tag.textColor = [UIColor whiteColor];
    [self addSubview:tag];
    [tag mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(labelTagImg.mas_right).offset(6);
        make.centerY.equalTo(labelTagImg);
    }];
    
    
//    UIView *baziContent = [[UIView alloc] init];
//    [self addSubview:baziContent];
//    baziContent.backgroundColor = [UIColor whiteColor];
//    [baziContent mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.mas_equalTo(130);
//        make.height.mas_equalTo(70);
//        make.top.mas_equalTo(90);
//        make.centerX.equalTo(self);
//    }];
    
//    [NotificationCenter addObserver:self
//                           selector:@selector(setBazi)
//                               name:@"MyBaziStatusChangedNotification"
//                             object:nil];
    
}
//- (void)dealloc{
//    [NotificationCenter removeObserver:self];
//}
//- (void)setBazi{
//    if ( [UserDataManager shareInstance].myBazi) {
//        NSLog(@"----++++++-------%@",[UserDataManager shareInstance].myBazi);
//    }
//}
@end
