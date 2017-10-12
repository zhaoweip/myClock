//
//  WPTabBar.h
//  myClock
//
//  Created by Macintosh on 11/10/17.
//  Copyright © 2017年 Macintosh. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WPTabBar;
//代理
@protocol MyTabBarDelegate <NSObject>
@optional
- (void)tabBar:(WPTabBar *)tabBar didClickButton:(NSInteger)index;
@end





@interface WPTabBar : UIView

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, weak) id<MyTabBarDelegate> delegate;

@end
