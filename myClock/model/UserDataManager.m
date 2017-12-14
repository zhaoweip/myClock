//
//  UserDataManager.m
//  myClock
//
//  Created by Macintosh on 19/10/17.
//  Copyright © 2017年 Macintosh. All rights reserved.
//

#import "UserDataManager.h"
#import "Alarm.h"
#import <UserNotifications/UserNotifications.h>

@interface UserDataManager()
//@property (nonatomic, strong) dispatch_source_t time;
@end

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
    }
}
#pragma mark - 将闹钟模型数组归档保存
- (void)saveAlarmModel:(Alarm *)alarm
{
    if (alarm) {
        [self.alarmModelArray addObject:alarm];
        NSString *alarmModelArrayfile = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"alarmModelArray.data"];
        [NSKeyedArchiver archiveRootObject:self.alarmModelArray toFile:alarmModelArrayfile];
    }
    [self setAlarmOpen];
}
#pragma mark - 解档获得闹钟模型数组
- (NSMutableArray *)getAlarmModelArray
{
    NSString *alarmModelArrayfile = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"alarmModelArray.data"];
    NSMutableArray *alarmModelArray = [NSKeyedUnarchiver unarchiveObjectWithFile:alarmModelArrayfile];
    if (alarmModelArray) {
        self.alarmModelArray = alarmModelArray;
    }
    return self.alarmModelArray;
}
#pragma mark - 根据下标获得闹钟数组对用闹钟模型
- (Alarm *)getOneAlarmFromIndex:(NSInteger)index
{
    Alarm *alarm = [[self getAlarmModelArray] objectAtIndex:index];
    return alarm;
}
#pragma mark - 从闹钟模型数组删除一个闹钟模型
- (void)removeObjectFromAlarmModelArrayAtIndex:(NSUInteger)index
{
    NSMutableArray *newAlarmModelArray = [self getAlarmModelArray];
    [newAlarmModelArray removeObjectAtIndex:index];
    self.alarmModelArray = newAlarmModelArray;
    //将新的数组重新归档保存替代原来的数据
    NSString *alarmModelArrayfile = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"alarmModelArray.data"];
    [NSKeyedArchiver archiveRootObject:self.alarmModelArray toFile:alarmModelArrayfile];
    
    [self setAlarmOpen];
}
#pragma mark - 根据下标编辑一个闹钟模型，替换原来数组
- (void)editAlarmModelAtIndex:(NSInteger)index withNewModel:(Alarm *)alarm
{
    NSMutableArray *newAlarmModelArray = [self getAlarmModelArray];
    [newAlarmModelArray replaceObjectAtIndex:index withObject:alarm];
    self.alarmModelArray = newAlarmModelArray;
    //将新的数组重新归档保存替代原来的数据
    NSString *alarmModelArrayfile = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"alarmModelArray.data"];
    [NSKeyedArchiver archiveRootObject:self.alarmModelArray toFile:alarmModelArrayfile];

    [self setAlarmOpen];
}
#pragma mark - 设置闹钟响铃
- (void)setAlarmOpen
{
    for (int i = 0; i<_alarmModelArray.count; i++) {
        //设置闹钟之前先移除所有的本地通知
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
        Alarm *alarm    = [_alarmModelArray objectAtIndex:i];
        NSString *year  = [alarm.timeStr substringToIndex:4];
        NSString *month = [alarm.timeStr substringWithRange:NSMakeRange(5, 2)];
        NSString *date  = [alarm.timeStr substringWithRange:NSMakeRange(8, 2)];
        NSString *time  = [alarm.timeStr substringFromIndex:18];
        if (alarm.isOpen == YES) {
            NSString *alarmTime = [NSString stringWithFormat:@"%@-%@-%@ %@",year,month,date,time];
            NSString *now       = [WPDateTimeUtils getCurrentTimeWithFormatter:@"YYYY-MM-dd HH:mm"];
            int countdown       = [WPDateTimeUtils getTimeIntervalFrom:now to:alarmTime];
            NSLog(@"%d-------%d",i,countdown);
            [self startTimerWithTime:countdown-60 withAlarmModel:alarm];
        }
    }
    
}
#pragma mark - 倒计时任务
- (void)startTimerWithTime:(int)countdown withAlarmModel:(Alarm *) alarm{
    //获得队列
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    //创建一个定时器
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    //设置开始时间
    dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(countdown * NSEC_PER_SEC));
    //设置时间间隔
    uint64_t interval = (uint64_t)(0.0* NSEC_PER_SEC);
    //设置定时器
    dispatch_source_set_timer(timer, start, interval, 0);
    //设置回调
    dispatch_source_set_event_handler(timer, ^{
        [self postMyNotificationwithAlarmModel:alarm];
        dispatch_cancel(timer);
    });
    //由于定时器默认是暂停的所以我们启动一下
    dispatch_resume(timer);
}
#pragma mark - 发出本地闹钟通知
- (void)postMyNotificationwithAlarmModel:(Alarm *)alarm{
    //通知中心
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    //1，设置推送内容
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title    = alarm.timeStr;
    content.subtitle = alarm.remarkStr;
    content.body     = @"注意别忘了重要事情哦，如果要暂停闹钟情打开通知～";
    content.sound    = [UNNotificationSound soundNamed:[NSString stringWithFormat:@"%@.aif",alarm.soundName]];
    content.badge    = @1;
    //2，设置推送时间
    UNTimeIntervalNotificationTrigger *trigger1 = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:60 repeats:YES];
    //3，设置推送请求
    NSString *requestIdentifier = @"sampleRequest";
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:requestIdentifier
                                                                        content:content
                                                                          trigger:trigger1];
    //4，推送请求添加到推送管理中心
    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        if (!error) {
            NSLog(@"推送已添加成功 %@", requestIdentifier);
        }
    }];
}

@end
