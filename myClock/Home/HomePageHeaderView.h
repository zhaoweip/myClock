//
//  HomePageHeaderView.h
//  myClock
//
//  Created by Macintosh on 18/10/17.
//  Copyright © 2017年 Macintosh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Bazi.h"

//代理
@protocol HomePageHeaderViewDelegate <NSObject>
@optional
- (void)didClickYiJiLabel;
@end

@interface HomePageHeaderView : UIView

@property (nonatomic, strong) Bazi *bazi;
@property (nonatomic, copy) NSString *dateText;
@property (nonatomic, copy) NSString *day;
@property (nonatomic, weak) id<HomePageHeaderViewDelegate> delegate;


@end
