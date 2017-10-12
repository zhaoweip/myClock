//
//  WPTabBarController.m
//  myClock
//
//  Created by Macintosh on 11/10/17.
//  Copyright © 2017年 Macintosh. All rights reserved.
//

#import "WPTabBarController.h"
#import "WPTabBar.h"
#import "HomePageViewController.h"
#import "SearchPageViewController.h"
#import "AboutMePageViewController.h"

@interface WPTabBarController ()<MyTabBarDelegate>

@property (nonatomic, strong) NSMutableArray *items;

@end

@implementation WPTabBarController
- (NSMutableArray *)items {
    if (_items == nil) {
        _items = [NSMutableArray array];
    }
    return _items;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setChildCtls];
    [self setTabBar];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //移除系统tabbarButton
    for (UIView *tabBarButton in self.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabBarButton removeFromSuperview];
        }
    }
}
- (void)setChildCtls
{
    //时钟首页
    HomePageViewController *home = [[HomePageViewController alloc] init];
    UINavigationController *homeNavCtl = [[UINavigationController alloc] initWithRootViewController:home];
    [self setUpOneChildViewController:homeNavCtl image:nil selectedImage:nil title:@"时钟"];
    
    //查询
    SearchPageViewController *search = [[SearchPageViewController alloc] init];
    UINavigationController *searchNavCtl = [[UINavigationController alloc] initWithRootViewController:search];
    [self setUpOneChildViewController:searchNavCtl image:nil selectedImage:nil title:@"查询"];
    
    //关于我们
    AboutMePageViewController *me = [[AboutMePageViewController alloc] init];
    UINavigationController *meNavCtl = [[UINavigationController alloc] initWithRootViewController:me];
    [self setUpOneChildViewController:meNavCtl image:nil selectedImage:nil title:@"关于我们"];
}
#pragma mark -添加一个子控制器
- (void)setUpOneChildViewController:(UIViewController *)vc image:(UIImage *)image selectedImage:(UIImage *)selectedImage title:(NSString *)title {
    
    //设置子控制器的标题以及图像，后面的自定义只是调整位置
    vc.title = title;
    vc.tabBarItem.image = image;
    vc.tabBarItem.selectedImage = selectedImage;
    
    //保存tabBarItem模型到数组
    [self.items addObject:vc.tabBarItem];
    
    [self addChildViewController:vc];
}

#pragma mark -设置自定义tarbar
- (void)setTabBar{
    
    WPTabBar *myTabBar = [[WPTabBar alloc] initWithFrame:self.tabBar.bounds];
    myTabBar.backgroundColor = [UIColor whiteColor];
    
    myTabBar.delegate = self;
    //给tabBar传递tabBarItem模型
    myTabBar.items = self.items;
    
    //添加自定义tabbar
    [self.tabBar addSubview:myTabBar];
    
}

#pragma mark - tabBar代理方法，点击tabBar上得按钮调用，切换控制器
- (void)tabBar:(WPTabBar *)tabBar didClickButton:(NSInteger)index {
    
    self.selectedIndex = index;
    NSLog(@"123");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
