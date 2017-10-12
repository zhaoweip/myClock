//
//  WPTabBar.m
//  myClock
//
//  Created by Macintosh on 11/10/17.
//  Copyright © 2017年 Macintosh. All rights reserved.
//

#import "WPTabBar.h"
#import "WPTabBarButton.h"

@interface WPTabBar()

@property (nonatomic, strong) NSMutableArray *buttons;
@property (nonatomic, weak) UIButton *selectedButton;

@end

@implementation WPTabBar
- (NSMutableArray *)buttons {
    if (_buttons == nil) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

- (void)setItems:(NSArray *)items {
    
    _items = items;
    
    //遍历模型数组，创建对应的tabBarButton
    for (UITabBarItem *item in _items) {
        
        WPTabBarButton *btn = [WPTabBarButton buttonWithType:UIButtonTypeCustom];
        
        //给按钮赋值模型，按钮的内容由模型决定
        btn.item = item;
        
        //设置监听
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
        
        btn.tag = self.buttons.count;
        
        //默认选择首页
        if (btn.tag == 0) {
            [self btnClick:btn];
        }
        
        [self addSubview:btn];
        
        //把按钮添加到按钮数组，方便统计按钮的数量，给tag赋值以及对按钮位置大小的设定
        [self.buttons addObject:btn];
    }
}

//点击tabBarButton调用
- (void)btnClick:(UIButton *)button {
    
    _selectedButton.selected = NO;
    button.selected = YES;
    _selectedButton = button;
    
    //通知tabBarVc切换控制器
    if ([_delegate respondsToSelector:@selector(tabBar:didClickButton:)]) {
        [_delegate tabBar:self didClickButton:button.tag];
    }
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    //设置tabbar背景图片
    UIImageView *tabbarBackImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_bottom_bg.png"]];
    tabbarBackImage.frame = self.frame;
    [self addSubview:tabbarBackImage];
    
    CGFloat w = self.bounds.size.width;
    CGFloat h = self.bounds.size.height;
    
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    CGFloat btnW = w / (self.items.count);
    CGFloat btnH = h;
    
    int i = 0;
    
    
    //设置tabBarButton的frame
    for (UIView *tabBarButton in self.buttons) {
        
//        if (i == 2) {
//            i = 3;
//        }
        btnX = i * btnW;
        tabBarButton.frame = CGRectMake(btnX, btnY, btnW, btnH);
        i++;
        [self addSubview:tabBarButton] ;
    }
    //设计加号按钮的位置
//    self.addButton.center = CGPointMake(w * 0.5, h * 0.5);
    
}

@end
