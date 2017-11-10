//
//  UserDataManager.m
//  myClock
//
//  Created by Macintosh on 19/10/17.
//  Copyright © 2017年 Macintosh. All rights reserved.
//

#import "UserDataManager.h"

@implementation UserDataManager

static UserDataManager * _instance = nil;

+(instancetype) shareInstance
{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init] ;
    }) ;
    
    return _instance ;
}
- (NSMutableArray *)alarmModelArray {
    if (_alarmModelArray == nil) {
        _alarmModelArray = [NSMutableArray array];
    }
    return _alarmModelArray;
}

- (void)saveMyBaziInfo:(Bazi *)myBazi{
    if (myBazi) {
        _myBazi = myBazi;
//        [NotificationCenter postNotificationName:@"MyBaziStatusChangedNotification" object:nil];
    }
}
//将闹钟模型数组归档保存
- (void)saveAlarmModel:(Alarm *)alarm{
    if (alarm) {
        [self.alarmModelArray addObject:alarm];
        NSString *alarmModelArrayfile = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"alarmModelArray.data"];
        [NSKeyedArchiver archiveRootObject:self.alarmModelArray toFile:alarmModelArrayfile];
        //发出闹钟数量改变的通知
//        [NotificationCenter postNotificationName:@"MyAlarmsChangedNotification" object:nil];
    }
}
//解档获得闹钟模型数组
- (NSMutableArray *)getAlarmModelArray{
    NSString *alarmModelArrayfile = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"alarmModelArray.data"];
    NSMutableArray *alarmModelArray = [NSKeyedUnarchiver unarchiveObjectWithFile:alarmModelArrayfile];
    if (alarmModelArray) {
        self.alarmModelArray = alarmModelArray;
    }
    return self.alarmModelArray;
}
//从闹钟模型数组删除一个闹钟模型
- (void)removeObjectFromAlarmModelArrayAtIndex:(NSUInteger)index{
    NSMutableArray *newAlarmModelArray = [self getAlarmModelArray];
    [newAlarmModelArray removeObjectAtIndex:index];
    self.alarmModelArray = newAlarmModelArray;
    //将新的数组重新归档保存替代原来的数据
    NSString *alarmModelArrayfile = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"alarmModelArray.data"];
    [NSKeyedArchiver archiveRootObject:self.alarmModelArray toFile:alarmModelArrayfile];
}
//编辑一个闹钟模型
- (void)editAlarmModelAtIndex:(NSInteger)index withNewModel:(Alarm *)alarm{
    NSMutableArray *newAlarmModelArray = [self getAlarmModelArray];
    [newAlarmModelArray replaceObjectAtIndex:index withObject:alarm];
    self.alarmModelArray = newAlarmModelArray;
    //将新的数组重新归档保存替代原来的数据
    NSString *alarmModelArrayfile = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"alarmModelArray.data"];
    [NSKeyedArchiver archiveRootObject:self.alarmModelArray toFile:alarmModelArrayfile];

}

@end
