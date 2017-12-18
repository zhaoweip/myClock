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
@property (nonatomic, strong) NSMutableArray *searchRecordArray;


/*
 * 单例
 */
+(instancetype) shareInstance;
/*
 * 保存八字信息
 */
- (void)saveMyBaziInfo:(Bazi *)myBazi;
/*
 * 保存闹钟模型
 */
- (void)saveAlarmModel:(Alarm *)alarm;
/*
 * 获得闹钟模型数组
 */
- (NSMutableArray *)getAlarmModelArray;
/*
 * 根据下标获得指定闹钟模型
 */
- (Alarm *)getOneAlarmFromIndex:(NSInteger)index;
/*
 * 删除指定闹钟模型
 */
- (void)removeObjectFromAlarmModelArrayAtIndex:(NSUInteger)index;
/*
 * 编辑指定闹钟模型
 */
- (void)editAlarmModelAtIndex:(NSInteger)index withNewModel:(Alarm *)alarm;
/*
 * 保存查询记录
 */
- (void)saveSearchRecord:(NSString *)searchText;
/*
 * 获得所有查询记录
 */
- (NSMutableArray *)getAllSearchRecord;

@end
