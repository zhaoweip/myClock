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

- (void)saveMyBaziInfo:(Bazi *)myBazi{
    if (myBazi) {
        _myBazi = myBazi;
//        [NotificationCenter postNotificationName:@"MyBaziStatusChangedNotification" object:nil];
    }
}

@end
