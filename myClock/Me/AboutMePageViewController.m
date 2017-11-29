//
//  AboutMePageViewController.m
//  myClock
//
//  Created by Macintosh on 11/10/17.
//  Copyright © 2017年 Macintosh. All rights reserved.
//

#import "AboutMePageViewController.h"
#import "WJScrollerMenuView.h"

#define LogoToTop                FitSize(45,60,65,85)
#define Margin_OF_Title_And_Logo FitSize(18,22,25,25)
#define SectionMargin            FitSize(18,20,22,22)
#define Margin                   FitSize(26,30,33,33)
#define Title_FontSize           FitSize(22,25,28,28)
#define TextFontSize             FitSize(13,14,15,15)



@interface AboutMePageViewController ()<UINavigationControllerDelegate,WJScrollerMenuDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic,strong) WJScrollerMenuView *menuVc;
@property (nonatomic,strong) UIView *leftView;
@property (nonatomic,strong) UIView *rightView;


@end

@implementation AboutMePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setBackImage];
    //设置导航控制器的代理为self，在代理方法里面去隐藏导航栏
    self.navigationController.delegate = self;
    
    //logo
    UIImageView *logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"me_logo.png"]];
    [self.view addSubview:logo];
    [logo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(70);
        make.top.mas_equalTo(LogoToTop);
        make.centerX.equalTo(self.view);
    }];
    
    _menuVc=[[WJScrollerMenuView alloc]initWithFrame:CGRectMake(0, 140, SCREEN_WIDTH, 50) showArrayButton:NO];
    _menuVc.delegate=self;
    _menuVc.LineColor = [UIColor whiteColor];
    _menuVc.selectedColor=[UIColor whiteColor];
    _menuVc.noSlectedColor=[UIColor blackColor];
    _menuVc.myTitleArray=@[@"关于我们",@"免责声明"];
    _menuVc.currentIndex=0;
    [self.view addSubview:_menuVc];
    
    [self setUpLeftView];
    [self setUpRightView:YES];

}
//设置背景图片
- (void)setBackImage{
    UIImageView *backImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_base_bg.png"]];
    backImage.frame = self.view.frame;
    [self.view addSubview:backImage];
}
- (void)setUpLeftView{
    _leftView = [[UIView alloc] init];
    _leftView.backgroundColor = [UIColor colorWithRed:31/255.0 green:46/255.0 blue:67/255.0 alpha:1.0];
    [self.view addSubview:_leftView];
    [_leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.equalTo(_menuVc.mas_bottom);
        make.bottom.equalTo(self.view);
    }];
    //title
    UILabel *title = [[UILabel alloc] init];
    title.text = @"关于我们";
    title.textAlignment = NSTextAlignmentCenter;
    [title setFont:[UIFont fontWithName:@"Helvetica-Bold" size:Title_FontSize]];
    title.textColor = [UIColor whiteColor];
    [_leftView addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(250);
        make.top.equalTo(_menuVc.mas_bottom).offset(Margin_OF_Title_And_Logo);
        make.centerX.equalTo(_leftView);
    }];
    
    //label1
    UILabel *label1 = [[UILabel alloc] init];
    label1.text = @"知己知彼 百戰百勝";
    label1.font = [UIFont systemFontOfSize:TextFontSize];
    label1.textColor = [UIColor whiteColor];
    [_leftView addSubview:label1];
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
    [_leftView addSubview:label2];
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
    [_leftView addSubview:label3];
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
    [_leftView addSubview:label4];
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
    [_leftView addSubview:label5];
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
    [_leftView addSubview:label6];
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
    [_leftView addSubview:label7];
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
    [_leftView addSubview:label8];
    [label8 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(Margin);
        make.right.mas_equalTo(-Margin);
        make.top.equalTo(label7.mas_bottom).offset(SectionMargin);
    }];
    
    
}
- (void)setUpRightView:(BOOL)isHidden{
    _rightView = [[UIView alloc] init];
    _rightView.backgroundColor = [UIColor colorWithRed:31/255.0 green:46/255.0 blue:67/255.0 alpha:1.0];
    [self.view addSubview:_rightView];
    [_rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.equalTo(_menuVc.mas_bottom);
        make.bottom.equalTo(self.view);
    }];
    //title
    UILabel *title = [[UILabel alloc] init];
    title.text = @"免责声明";
    title.textAlignment = NSTextAlignmentCenter;
    [title setFont:[UIFont fontWithName:@"Helvetica-Bold" size:Title_FontSize]];
    title.textColor = [UIColor whiteColor];
    [_rightView addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(250);
        make.top.equalTo(_menuVc.mas_bottom).offset(Margin_OF_Title_And_Logo);
        make.centerX.equalTo(_leftView);
    }];
    
    NSMutableParagraphStyle  *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle  setLineSpacing:8];
    
    
    //label1
    UILabel *label1 = [[UILabel alloc] init];
    label1.font = [UIFont systemFontOfSize:TextFontSize];
    label1.textColor = [UIColor whiteColor];
    label1.numberOfLines = 0;
    NSString  *testString = @"        八字玄學屬非精密科學，本應用程式所提供之所有資料只作參考之用。如因使用、誤用或依據此程式的資訊而導致的損失或破壞，本公司概不負責";
    NSMutableAttributedString  *setString = [[NSMutableAttributedString alloc] initWithString:testString];
    [setString  addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [testString length])];
    [label1  setAttributedText:setString];
    [_rightView addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(Margin);
        make.right.mas_equalTo(-Margin);
        make.top.equalTo(title.mas_bottom).offset(18);
    }];

    
    //label2
    UILabel *label2 = [[UILabel alloc] init];
    label2.font = [UIFont systemFontOfSize:TextFontSize];
    label2.textColor = [UIColor whiteColor];
    label2.numberOfLines = 0;
    NSString  *testString2 = @"        本應用程式所載的所有資料、商標、標誌、圖像、短片、聲音檔案、連結及其他資料等（以下簡稱「資料」），只供參考之用，圓方文化科技有限公司（以下簡稱「本 公司」）將會盡力確保本應用程式的資料準確性，唯本公司無須事先通知而可隨時修改本應用程式的內容和任何部分。如因使用、誤用或依據此程式的資訊而導致的損失或破壞，本公司概不負責。";
    NSMutableAttributedString  *setString2 = [[NSMutableAttributedString alloc] initWithString:testString2];
    [setString2  addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [testString2 length])];
    [label2  setAttributedText:setString2];
    [_rightView addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(Margin);
        make.right.mas_equalTo(-Margin);
        make.top.equalTo(label1.mas_bottom).offset(30);
    }];

    _rightView.hidden = isHidden;
}
#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
}
#pragma mark - WJScrollerMenuDelegate
- (void)itemDidSelectedWithIndex:(NSInteger)index
{
    if (index == 1) {
        _leftView.hidden = YES;
        _rightView.hidden = NO;
    }else if (index == 0){
        _rightView.hidden = YES;
        _leftView.hidden = NO;
    }
}

@end
