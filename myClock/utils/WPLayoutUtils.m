//
//  WPLayoutUtils.m
//  myClock
//
//  Created by Macintosh on 16/10/17.
//  Copyright © 2017年 Macintosh. All rights reserved.
//

#import "WPLayoutUtils.h"

@implementation WPLayoutUtils

+ (CGFloat)fitSize:(CGFloat)iphone5Size iphone6Size:(CGFloat)iphone6Size iphone6PlusSize:(CGFloat)iphone6PlusSize iphoneXSize:(CGFloat)iphoneXSize
{
    if (IS_IPHONE_6_PLUS) {
        return iphone6PlusSize;
    }
    if (IS_IPHONE_6) {
        return iphone6Size;
    }
    if (IS_IPHONE_5) {
        return iphone5Size;
    }
    return iphoneXSize;
}


+ (UIView*)addBottomDivider:(UIView*)parent size:(CGFloat)size color:(UIColor*)color leftEdge:(CGFloat)leftEdge rightEdge:(CGFloat)rightEdge
{
    UIView *divider = [[UIView alloc] init];
    divider.backgroundColor = color;
    [parent addSubview:divider];
    [divider mas_makeConstraints:^(MASConstraintMaker* make) {
        make.left.mas_equalTo(leftEdge);
        make.height.mas_equalTo(size);
        if (parent) {
            make.bottom.equalTo(parent.mas_bottom);
            make.right.equalTo(parent.mas_right).offset(-rightEdge);
        }
    }];
    return divider;
}


@end
