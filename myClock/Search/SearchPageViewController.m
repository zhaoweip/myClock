//
//  SearchPageViewController.m
//  myClock
//
//  Created by Macintosh on 11/10/17.
//  Copyright © 2017年 Macintosh. All rights reserved.
//

#import "SearchPageViewController.h"

@interface SearchPageViewController ()<UINavigationControllerDelegate>

@property (nonatomic, weak) UIButton *maleSelectedButton;
@property (nonatomic, weak) UIButton *dataSelectedButton;


@end

@implementation SearchPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setBackImage];
    [self setSearceContent];
//    [self setDatePick];
    //设置导航控制器的代理为self，在代理方法里面去隐藏导航栏
    self.navigationController.delegate = self;

}
//设置背景图片
- (void)setBackImage{
    UIImageView *backImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_base_bg.png"]];
    backImage.frame = self.view.frame;
    [self.view addSubview:backImage];
}
//设置查询内容页
- (void)setSearceContent{
    //labelTagImg
    UIImageView *labelTagImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"label_tag.png"]];
    [self.view addSubview:labelTagImg];
    [labelTagImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(12);
        make.height.mas_equalTo(12);
        make.left.mas_equalTo(42);
        make.top.mas_equalTo(70);
    }];
    //labeltagText
    UILabel *labelTagText = [[UILabel alloc] init];
    labelTagText.text = @"请输入要查询的日期，‘小天’可以快速查询你想要的八字哦！";
    labelTagText.font = [UIFont systemFontOfSize:20];
    labelTagText.textColor = [UIColor whiteColor];
//    labelTagText.backgroundColor = [UIColor blueColor];
    labelTagText.numberOfLines = 0;
    [self.view addSubview:labelTagText];
    [labelTagText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(labelTagImg.mas_right).offset(14);
        make.right.mas_equalTo(-45);
        make.top.equalTo(labelTagImg.mas_top).offset(-7);
    }];
    
    UIButton *manBtn = [[UIButton alloc] init];
    [manBtn setTitle:@"男" forState:UIControlStateNormal];
    [manBtn setImage:[UIImage imageNamed:@"Inquire_normal.png"] forState:UIControlStateNormal];
    [manBtn setImage:[UIImage imageNamed:@"Inquire_selected.png"] forState:UIControlStateSelected];
    [self.view addSubview:manBtn];
    [manBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(labelTagText.mas_bottom).offset(25);
        make.left.mas_equalTo(90);
    }];
    [manBtn addTarget:self action:@selector(maleBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    
    UIButton *womanBtn = [[UIButton alloc] init];
    [womanBtn setTitle:@"女" forState:UIControlStateNormal];
    [womanBtn setImage:[UIImage imageNamed:@"Inquire_normal.png"] forState:UIControlStateNormal];
    [womanBtn setImage:[UIImage imageNamed:@"Inquire_selected.png"] forState:UIControlStateSelected];
    [self.view addSubview:womanBtn];
    [womanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(labelTagText.mas_bottom).offset(25);
        make.left.equalTo(manBtn.mas_left).offset(150);
    }];
    [womanBtn addTarget:self action:@selector(maleBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    
    UIButton *oldDataBtn = [[UIButton alloc] init];
    [oldDataBtn setTitle:@"农历" forState:UIControlStateNormal];
    [oldDataBtn setImage:[UIImage imageNamed:@"Inquire_normal.png"] forState:UIControlStateNormal];
    [oldDataBtn setImage:[UIImage imageNamed:@"Inquire_selected.png"] forState:UIControlStateSelected];
    [self.view addSubview:oldDataBtn];
    [oldDataBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(womanBtn.mas_bottom).offset(21);
        make.left.mas_equalTo(90);
    }];
    [oldDataBtn addTarget:self action:@selector(dataBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    UIButton *newDataBtn = [[UIButton alloc] init];
    [newDataBtn setTitle:@"阳历" forState:UIControlStateNormal];
    [newDataBtn setImage:[UIImage imageNamed:@"Inquire_normal.png"] forState:UIControlStateNormal];
    [newDataBtn setImage:[UIImage imageNamed:@"Inquire_selected.png"] forState:UIControlStateSelected];
    [self.view addSubview:newDataBtn];
    [newDataBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(womanBtn.mas_bottom).offset(21);
        make.left.equalTo(oldDataBtn.mas_left).offset(150);
    }];
    [newDataBtn addTarget:self action:@selector(dataBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //日期输入框
    UITextField *date = [[UITextField alloc] init];
    date.backgroundColor = [UIColor whiteColor];
    date.enabled = NO;
    date.layer.cornerRadius = 10;
    [self.view addSubview:date];
    [date mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(oldDataBtn.mas_bottom).offset(20);
        make.left.mas_equalTo(38);
        make.right.mas_equalTo(-38);
        make.height.mas_equalTo(45);
    }];
    
    UIImageView *dateTag = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"date_tag.png"]];
    [date addSubview:dateTag];
    [dateTag mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
        make.right.mas_equalTo(-10);
        make.centerY.equalTo(date);
        
    }];
    
    UITextField *time = [[UITextField alloc] init];
    time.backgroundColor = [UIColor whiteColor];
    time.enabled = NO;
    time.layer.cornerRadius = 10;
    [self.view addSubview:time];
    [time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(date.mas_bottom).offset(10);
        make.left.mas_equalTo(38);
        make.right.mas_equalTo(-38);
        make.height.mas_equalTo(45);
    }];
    
    UIImageView *timeTag = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"date_tag.png"]];
    [time addSubview:timeTag];
    [timeTag mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
        make.right.mas_equalTo(-10);
        make.centerY.equalTo(time);
        
    }];
    
    //查询按钮
    UIButton *searchBtn = [[UIButton alloc] init];
    [searchBtn setImage:[UIImage imageNamed:@"search_btn.png"] forState:UIControlStateNormal];
    [self.view addSubview:searchBtn];
    [searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(100);
        make.top.equalTo(time.mas_bottom).offset(130);
        make.centerX.equalTo(self.view);
    }];
    [searchBtn addTarget:self action:@selector(searchBtnClick) forControlEvents:UIControlEventTouchDown];
    

}
- (void)searchBtnClick{
    NSLog(@"www");
}
////日期选择器
//- (void)setDatePick{
//    //日期时间选择器
//    UIDatePicker *datePicker = [ [ UIDatePicker alloc] initWithFrame:CGRectMake(0,500,SCREEN_WIDTH,SCREEN_HEIGHT*0.3)];
//    datePicker.backgroundColor = [UIColor yellowColor];
//    datePicker.datePickerMode = UIDatePickerModeDate;
//    datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
//    [self.view addSubview: datePicker];
//    [datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
////    datePicker.hidden = YES;
//
//}

//- (void)dateChanged:(UIDatePicker *)datePicker
//{
//    NSDate *theDate = datePicker.date;
//    NSLog(@"%@",[theDate descriptionWithLocale:[NSLocale currentLocale]]);
//
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    dateFormatter.dateFormat = @"YYYY-MM-dd";
//    NSLog(@"%@",[dateFormatter stringFromDate:theDate]);
//}
//点击调用
- (void)maleBtnClick:(UIButton *)button {
    _maleSelectedButton.selected = NO;
    button.selected = YES;
    _maleSelectedButton = button;
}
- (void)dataBtnClick:(UIButton *)button {
    _dataSelectedButton.selected = NO;
    button.selected = YES;
    _dataSelectedButton = button;
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
