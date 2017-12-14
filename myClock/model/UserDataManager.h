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
- (Alarm *)getOneAlarmFromIndex:(NSInteger)index;
- (void)removeObjectFromAlarmModelArrayAtIndex:(NSUInteger)index;
- (void)editAlarmModelAtIndex:(NSInteger)index withNewModel:(Alarm *)alarm;

@end
