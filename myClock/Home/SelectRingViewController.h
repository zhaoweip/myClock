//
//  SelectRingViewController.h
//  myClock
//
//  Created by Macintosh on 30/10/17.
//  Copyright © 2017年 Macintosh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>


//代理
@protocol SelectRingDelegate <NSObject>
@optional
- (void)selectRing:(NSInteger)index withSoundName:(NSString *)soundName andSoundKey:(NSString *)soundKey;
@end


@interface SelectRingViewController : UIViewController

@property(nonatomic,assign) SystemSoundID soundID;
//@property(nonatomic,assign) NSInteger ringIndex;
@property(nonatomic,copy) NSString *ringKey;
@property (nonatomic, weak) id<SelectRingDelegate> delegate;

@end
