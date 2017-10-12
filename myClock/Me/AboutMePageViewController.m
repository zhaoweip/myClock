//
//  AboutMePageViewController.m
//  myClock
//
//  Created by Macintosh on 11/10/17.
//  Copyright © 2017年 Macintosh. All rights reserved.
//

#import "AboutMePageViewController.h"

@interface AboutMePageViewController ()<UINavigationControllerDelegate>

@end

@implementation AboutMePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setBackImage];
    [self setAboutMeContent];
    //设置导航控制器的代理为self，在代理方法里面去隐藏导航栏
    self.navigationController.delegate = self;

}
//设置背景图片
- (void)setBackImage{
    UIImageView *backImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_base_bg.png"]];
    backImage.frame = self.view.frame;
    [self.view addSubview:backImage];
}
- (void)setAboutMeContent{
    //logo
    UIImageView *logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_bottom_bg.png"]];
    logo.frame = CGRectMake(0, 0, 100, 100);
    logo.center = CGPointMake(self.view.frame.size.width/2, 120);
    [self.view addSubview:logo];
    
    //title
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
    title.center = CGPointMake(self.view.frame.size.width/2, 200);
    title.text = @"关于我们";
    title.font = [UIFont systemFontOfSize:24];
    title.textColor = [UIColor whiteColor];
    [self.view addSubview:title];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
}

@end
