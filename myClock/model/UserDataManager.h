//
//  UserDataManager.h
//  myClock
//
//  Created by Macintosh on 19/10/17.
//  Copyright © 2017年 Macintosh. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Bazi;
@class Alarm;

@interface UserDataManager : NSObject

@property (nonatomic, strong) Bazi *myBazi;
@property (nonatomic, strong) NSMutableArray *alarmModelArray;


+(instancetype) shareInstance;

- (void)saveMyBaziInfo:(Bazi *)myBazi;
- (void)saveAlarmModel:(Alarm *)alarm;
- (NSMutableArray *)getAlarmModelArray;
- (void)removeObjectFromAlarmModelArrayAtIndex:(NSUInteger)index;

@end
