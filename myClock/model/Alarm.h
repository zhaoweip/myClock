//
//  Alarm.h
//  myClock
//
//  Created by Macintosh on 31/10/17.
//  Copyright © 2017年 Macintosh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>


@interface Alarm : NSObject<NSCoding>

@property (nonatomic, copy) NSString *timeStr;
@property (nonatomic, copy) NSString *ringName;
@property (nonatomic, copy) NSString *remarkStr;
@property (nonatomic, assign) SystemSoundID soundID;

@end
