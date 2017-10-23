//
//  HomePageFootView.h
//  myClock
//
//  Created by Macintosh on 23/10/17.
//  Copyright © 2017年 Macintosh. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HomePageFootView;
//代理
@protocol MyHomePageFootViewDelegate <NSObject>
@optional
- (void)footViewClickAddButton;
@end


@interface HomePageFootView : UIView

@property (nonatomic, weak) id<MyHomePageFootViewDelegate> delegate;

@end
