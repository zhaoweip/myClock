//
//  HomePageFootView.m
//  myClock
//
//  Created by Macintosh on 23/10/17.
//  Copyright © 2017年 Macintosh. All rights reserved.
//

#import "HomePageFootView.h"

@interface HomePageFootView()

@property (nonatomic, strong) UIImageView *addImage;

@end

@implementation HomePageFootView
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _addImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_add.png"]];
    [self addSubview:_addImage];
    [_addImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(60);
    }];
    _addImage.userInteractionEnabled = YES;

    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    
    if ([touch view] == _addImage)
    {
        NSLog(@"ccc");
        //通知控制器操作页面
        if ([_delegate respondsToSelector:@selector(footViewClickAddButton)]) {
            [_delegate footViewClickAddButton];
        }
    }
}

@end
