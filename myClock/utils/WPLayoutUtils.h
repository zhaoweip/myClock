//
//  WPLayoutUtils.h
//  myClock
//
//  Created by Macintosh on 16/10/17.
//  Copyright © 2017年 Macintosh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WPLayoutUtils : NSObject

+ (CGFloat)fitSize:(CGFloat)iphone5Size iphone6Size:(CGFloat)iphone6Size iphone6PlusSize:(CGFloat)iphone6PlusSize iphoneXSize:(CGFloat)iphoneXSize;

+ (UIView*)addBottomDivider:(UIView*)parent size:(CGFloat)size color:(UIColor*)color leftEdge:(CGFloat)leftEdge rightEdge:(CGFloat)rightEdge;

@end
