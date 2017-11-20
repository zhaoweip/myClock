//
//  SKConstant.h
//  myClock
//
//  Created by Macintosh on 20/11/17.
//  Copyright © 2017年 Macintosh. All rights reserved.
//

#ifndef SKConstant_h
#define SKConstant_h

#import "SKDateSecurity.h"
#import "SKCalendarView.h"
#import "SKCalendarAnimationManage.h"
#import <Masonry/Masonry.h>

#define isEmpty(x)  [SKDateSecurity isNilOrEmpty:x]
#define getNoneNil(object)  [SKDateSecurity getNoneNilString:object]

#endif /* SKConstant_h */
