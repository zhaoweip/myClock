//
//  BaziAlertView.h
//  myClock
//
//  Created by Macintosh on 20/10/17.
//  Copyright © 2017年 Macintosh. All rights reserved.
//

#import <UIKit/UIKit.h>

//代理
@protocol BaziAlertViewDelegate <NSObject>
@optional

@end


@interface BaziAlertView : UIView

@property (nonatomic, strong) Bazi *bazi;
@property (nonatomic, weak) id<BaziAlertViewDelegate> delegate;



@end
