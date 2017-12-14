//
//  HomePageTableViewCell.h
//  myClock
//
//  Created by Macintosh on 18/10/17.
//  Copyright © 2017年 Macintosh. All rights reserved.
//

#import <UIKit/UIKit.h>

//代理
@protocol HomePageTableViewCellDelegate <NSObject>
@optional
- (void)clickSwitchButton:(UISwitch *)switchBtn;
@end

@interface HomePageTableViewCell : UITableViewCell

@property(nonatomic,strong) UILabel *title;
@property(nonatomic,strong) UILabel *describe;
@property(nonatomic,strong) UISwitch *switchBtn;
@property(nonatomic, weak)  id<HomePageTableViewCellDelegate> delegate;


@end
