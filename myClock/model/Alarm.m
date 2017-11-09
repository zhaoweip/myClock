//
//  Alarm.m
//  myClock
//
//  Created by Macintosh on 31/10/17.
//  Copyright © 2017年 Macintosh. All rights reserved.
//

#import "Alarm.h"

@implementation Alarm

//解档
- (id)initWithCoder:(NSCoder *)aDecoder{
    if ([super init]) {
        self.timeStr    = [aDecoder decodeObjectForKey:@"timeStr"];
        self.ringName   = [aDecoder decodeObjectForKey:@"ringName"];
        self.remarkStr  = [aDecoder decodeObjectForKey:@"remarkStr"];
        self.soundID    = [aDecoder decodeIntForKey:@"soundID"];
    }
    return self;
}
//归档
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.timeStr forKey:@"timeStr"];
    [aCoder encodeObject:self.ringName forKey:@"ringName"];
    [aCoder encodeObject:self.remarkStr forKey:@"remarkStr"];
    [aCoder encodeInt:self.soundID forKey:@"soundID"];
}

@end
