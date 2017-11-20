//
//  SKWeekCollectionViewCell.h
//  myClock
//
//  Created by Macintosh on 20/11/17.
//  Copyright © 2017年 Macintosh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SKWeekCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) NSString * week;
@property (nonatomic, strong) UIColor * weekColor;
@property (nonatomic, strong) UIColor * weekBackgroundColor;
@property (nonatomic, assign) BOOL enableLine;// 开启边线, 默认YES


@end
