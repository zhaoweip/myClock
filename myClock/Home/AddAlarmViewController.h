//
//  AddAlarmViewController.h
//  myClock
//
//  Created by Macintosh on 23/10/17.
//  Copyright © 2017年 Macintosh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>

@interface AddAlarmViewController : UIViewController

@property(nonatomic) BOOL isEditing;
@property(nonatomic,strong) Alarm *alarmModel;
@property(nonatomic,assign) NSInteger indexOfModelArray;

@end
