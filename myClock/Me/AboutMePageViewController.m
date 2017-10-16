//
//  AboutMePageViewController.m
//  myClock
//
//  Created by Macintosh on 11/10/17.
//  Copyright © 2017年 Macintosh. All rights reserved.
//

#import "AboutMePageViewController.h"

#define LogoToTop                FitSize(45,60,65,85)
#define Margin_OF_Title_And_Logo FitSize(18,22,25,25)
#define SectionMargin            FitSize(18,20,22,22)
#define Margin                   FitSize(26,30,33,33)
#define Title_FontSize           FitSize(22,25,28,28)
#define TextFontSize             FitSize(13,14,15,15)



@interface AboutMePageViewController ()<UINavigationControllerDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

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
    
    UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    scrollView.contentSize = CGSizeMake(0, self.view.frame.size.height);
    _scrollView = scrollView;
    [self.view addSubview:_scrollView];
    
    //logo
    UIImageView *logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"me_logo_top.png"]];
    [_scrollView addSubview:logo];
    [logo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(48);
        make.top.mas_equalTo(LogoToTop);
        make.centerX.equalTo(self.view);
    }];

    //title
    UILabel *title = [[UILabel alloc] init];
    title.text = @"关于我们";
    title.textAlignment = NSTextAlignmentCenter;
    [title setFont:[UIFont fontWithName:@"Helvetica-Bold" size:Title_FontSize]];
    title.textColor = [UIColor whiteColor];
    [self.view addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(250);
        make.top.equalTo(logo.mas_bottom).offset(Margin_OF_Title_And_Logo);
        make.centerX.equalTo(logo);
    }];
    
    //label1
    UILabel *label1 = [[UILabel alloc] init];
    label1.text = @"知己知彼 百戰百勝";
    label1.font = [UIFont systemFontOfSize:TextFontSize];
    label1.textColor = [UIColor whiteColor];
    [self.view addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(Margin);
        make.right.mas_equalTo(-Margin);
        make.top.equalTo(title.mas_bottom).offset(18);
    }];
    //label2
    UILabel *label2 = [[UILabel alloc] init];
    label2.text = @"了解自己的八字五行屬性，優化自己的生活。";
    label2.font = [UIFont systemFontOfSize:TextFontSize];
    label2.textColor = [UIColor whiteColor];
    label2.numberOfLines = 0;
    [self.view addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(Margin);
        make.right.mas_equalTo(-Margin);
        make.top.equalTo(label1.mas_bottom);
    }];
    
    //label3
    UILabel *label3 = [[UILabel alloc] init];
    label3.text = @"宏揚中華傳統文化，結合科技，讓人們更容易接觸到八字五行學說，這一塊傳承幾千年文化瑰寶。";
    label3.font = [UIFont systemFontOfSize:TextFontSize];
    label3.textColor = [UIColor whiteColor];
    label3.numberOfLines = 0;
    [self.view addSubview:label3];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(Margin);
        make.right.mas_equalTo(-Margin);
        make.top.equalTo(label2.mas_bottom).offset(SectionMargin);
    }];
    
    //label4
    UILabel *label4 = [[UILabel alloc] init];
    label4.text = @"千萬年以來，人類對時間都充滿了迷思，不同民族及文化，發展出自己的時計儀，但都離不開，天體物理，氣候更迭等原素。";
    label4.font = [UIFont systemFontOfSize:TextFontSize];
    label4.textColor = [UIColor whiteColor];
    label4.numberOfLines = 0;
    [self.view addSubview:label4];
    [label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(Margin);
        make.right.mas_equalTo(-Margin);
        make.top.equalTo(label3.mas_bottom).offset(SectionMargin);
    }];
    
    //label5
    UILabel *label5 = [[UILabel alloc] init];
    label5.text = @"時間是什麼？有人說：時間，是生命流束的刻度。有人説：時間是生命的周期表。";
    label5.font = [UIFont systemFontOfSize:TextFontSize];
    label5.textColor = [UIColor whiteColor];
    label5.numberOfLines = 0;
    [self.view addSubview:label5];
    [label5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(Margin);
        make.right.mas_equalTo(-Margin);
        make.top.equalTo(label4.mas_bottom).offset(SectionMargin);
    }];
    
    //label6
    UILabel *label6 = [[UILabel alloc] init];
    label6.text = @"也有人説：時間是一個代表天地人三元的一個交集系統。";
    label6.font = [UIFont systemFontOfSize:TextFontSize];
    label6.textColor = [UIColor whiteColor];
    label6.numberOfLines = 0;
    [self.view addSubview:label6];
    [label6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(Margin);
        make.right.mas_equalTo(-Margin);
        make.top.equalTo(label5.mas_bottom);
    }];
    
    //label7
    UILabel *label7 = [[UILabel alloc] init];
    label7.text = @"八字記時系統：包含陰陽五行，天干地支，節氣更替，等等的重要信息。";
    label7.font = [UIFont systemFontOfSize:TextFontSize];
    label7.textColor = [UIColor whiteColor];
    label7.numberOfLines = 0;
    [self.view addSubview:label7];
    [label7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(Margin);
        make.right.mas_equalTo(-Margin);
        make.top.equalTo(label6.mas_bottom).offset(SectionMargin);
    }];
    
    //label8
    UILabel *label8 = [[UILabel alloc] init];
    label8.text = @"你已了解自己的時間信息密碼嗎？";
    label8.font = [UIFont systemFontOfSize:TextFontSize];
    label8.textColor = [UIColor whiteColor];
    label8.numberOfLines = 0;
    [self.view addSubview:label8];
    [label8 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(Margin);
        make.right.mas_equalTo(-Margin);
        make.top.equalTo(label7.mas_bottom).offset(SectionMargin);
    }];
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
