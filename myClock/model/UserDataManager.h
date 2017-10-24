//
//  UserDataManager.h
//  myClock
//
//  Created by Macintosh on 19/10/17.
//  Copyright © 2017年 Macintosh. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Bazi;

@interface UserDataManager : NSObject

@property (nonatomic, strong) Bazi *myBazi;

+(instancetype) shareInstance;

- (void)saveMyBaziInfo:(Bazi *)myBazi;

@end