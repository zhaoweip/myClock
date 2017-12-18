//
//  SearchPageViewController.m
//  myClock
//
//  Created by Macintosh on 11/10/17.
//  Copyright © 2017年 Macintosh. All rights reserved.
//

#import "SearchPageViewController.h"
#import "Bazi.h"
#import "BaziAlertView.h"
#import "CalendarHeader.h"
#import "SearchRecordViewController.h"

#define LabelTagToTop            FitSize(50,70,70,90)
#define LabelTagEdgeMargin       FitSize(30,42,42,42)
#define LabelTagAndImgOffset     FitSize(5,7,7,7)
#define LabelTagImgWidth         FitSize(10,10,12,12)
#define LabelTagFontSize         FitSize(16,18,20,20)

#define SelectedButtonEdgeMargin FitSize(60,90,90,90)
#define SelectedButtonToLeft     FitSize(120,150,150,150)

#define TextFieldTopMargin       FitSize(10,16,20,18)
#define TextFieldHeight          FitSize(40,42,45,45)
#define SearchButtonMarginToTop  FitSize(120,140,160,160)

#define DatePickHeight           SCREEN_HEIGHT*0.3
#define DatePickContentHeight    SCREEN_HEIGHT*0.3+60
#define DatePickContentY         SCREEN_HEIGHT*0.7-60


@interface SearchPageViewController ()<UINavigationControllerDelegate,UITextFieldDelegate,BaziAlertViewDelegate>

@property (nonatomic, weak) UIButton *maleSelectedButton;
@property (nonatomic, weak) UIButton *dataSelectedButton;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UIButton *confirmBtn;

@property (nonatomic, strong) UIButton *manBtn;
@property (nonatomic, strong) UIButton *womanBtn;
@property (nonatomic, strong) UIButton *oldDateBtn;
@property (nonatomic, strong) UIButton *internationalDateBtn;

@property (nonatomic, strong) UITextField *date;
@property (nonatomic, strong) UITextField *time;
@property (nonatomic, strong) UITextField *remark;

@property (nonatomic, strong) BaziAlertView *baziAlertView;

@end

@implementation SearchPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setBackImage];
    [self setSearceContent];
    //设置导航控制器的代理为self，在代理方法里面去隐藏导航栏
    self.navigationController.delegate = self;
    
    
    //按钮设置默认
    _manBtn.selected = YES;
    _internationalDateBtn.selected = YES;
    _maleSelectedButton = _manBtn;
    _dataSelectedButton = _internationalDateBtn;
    
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
        make.width.mas_equalTo(LabelTagImgWidth);
        make.height.mas_equalTo(LabelTagImgWidth);
        make.left.mas_equalTo(LabelTagEdgeMargin);
        make.top.mas_equalTo(LabelTagToTop);
    }];
    //labeltagText
    UILabel *labelTagText = [[UILabel alloc] init];
    labelTagText.text = @"请输入要查询的日期，‘小天’可以快速查询你想要的八字哦！";
    labelTagText.font = [UIFont systemFontOfSize:LabelTagFontSize];
    labelTagText.textColor = [UIColor whiteColor];
    labelTagText.numberOfLines = 0;
    [self.view addSubview:labelTagText];
    [labelTagText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(labelTagImg.mas_right).offset(14);
        make.right.mas_equalTo(-LabelTagEdgeMargin);
        make.top.equalTo(labelTagImg.mas_top).offset(-LabelTagAndImgOffset);
    }];
    
    
    _manBtn = [self createButtonWithTitle:@"男"];
    [_manBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(labelTagText.mas_bottom).offset(25);
        make.left.mas_equalTo(SelectedButtonEdgeMargin);
    }];
    [_manBtn addTarget:self action:@selector(maleBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    
    _womanBtn = [self createButtonWithTitle:@"女"];
    [_womanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(labelTagText.mas_bottom).offset(25);
        make.left.equalTo(_manBtn.mas_left).offset(150);
    }];
    [_womanBtn addTarget:self action:@selector(maleBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    _oldDateBtn = [self createButtonWithTitle:@"农历"];
    [_oldDateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_womanBtn.mas_bottom).offset(21);
        make.left.mas_equalTo(SelectedButtonEdgeMargin);
    }];
    [_oldDateBtn addTarget:self action:@selector(dataBtnClick:) forControlEvents:UIControlEventTouchUpInside];


    _internationalDateBtn = [self createButtonWithTitle:@"阳历"];
    [_internationalDateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_womanBtn.mas_bottom).offset(21);
        make.left.equalTo(_oldDateBtn.mas_left).offset(150);
    }];
    [_internationalDateBtn addTarget:self action:@selector(dataBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    _date = [self createTextFieldWithTag:1 andLastView:_oldDateBtn andPlaceholder:@"日期"];
    _time = [self createTextFieldWithTag:2 andLastView:_date andPlaceholder:@"时间"];
    
    _remark                 = [[UITextField alloc] init];
    _remark.backgroundColor = [UIColor whiteColor];
    _remark.textColor       = [UIColor blackColor];
    _remark.leftView        = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 0)];
    _remark.leftViewMode    = UITextFieldViewModeAlways;
    _remark.placeholder     = @"备注信息";
    _remark.layer.cornerRadius = 10;
    [self.view addSubview:_remark];
    [_remark mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_time.mas_bottom).offset(TextFieldTopMargin);
        make.left.mas_equalTo(38);
        make.right.mas_equalTo(-38);
        make.height.mas_equalTo(TextFieldHeight);
    }];

    //查询记录
    UIButton *searchRecordBtn          = [[UIButton alloc] init];
    searchRecordBtn.backgroundColor    = [UIColor whiteColor];
    searchRecordBtn.layer.cornerRadius = 10;
    [searchRecordBtn setTitle:@"查询记录" forState:UIControlStateNormal];
    [searchRecordBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [searchRecordBtn addTarget:self action:@selector(searchRecordBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchRecordBtn];
    [searchRecordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_remark.mas_bottom).offset(TextFieldTopMargin);
        make.left.mas_equalTo(38);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(40);
    }];
    
    //查询按钮
    UIButton *searchBtn = [[UIButton alloc] init];
    [searchBtn setImage:[UIImage imageNamed:@"search_btn.png"] forState:UIControlStateNormal];
    [self.view addSubview:searchBtn];
    [searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(100);
        make.top.equalTo(_time.mas_bottom).offset(SearchButtonMarginToTop);
        make.centerX.equalTo(self.view);
    }];
    [searchBtn addTarget:self action:@selector(searchBtnClick) forControlEvents:UIControlEventTouchDown];

}
//创建单选按钮
- (UIButton *)createButtonWithTitle:(NSString *)title
{
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:title forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"Inquire_normal.png"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"Inquire_selected.png"] forState:UIControlStateSelected];
    [self.view addSubview:button];
    return button;
}
//创建textfield
- (UITextField *)createTextFieldWithTag:(NSInteger)tag andLastView:(UIView *)lastView andPlaceholder:(NSString *)placeholder
{
    UITextField *textField       = [[UITextField alloc] init];
    textField.backgroundColor    = [UIColor whiteColor];
    textField.textColor          = [UIColor grayColor];
    textField.layer.cornerRadius = 10;
    textField.leftView           = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 0)];
    textField.leftViewMode       = UITextFieldViewModeAlways;
    textField.placeholder        = placeholder;
    [self.view addSubview:textField];
    
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lastView.mas_bottom).offset(TextFieldTopMargin);
        make.left.mas_equalTo(38);
        make.right.mas_equalTo(-38);
        make.height.mas_equalTo(TextFieldHeight);
    }];

    textField.delegate = self;
    textField.tag      = tag;
    [textField addTarget:self action:@selector(showDatePick:) forControlEvents:UIControlEventTouchDown];
    
    UIImageView *textFieldTag = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"date_tag.png"]];
    [textField addSubview:textFieldTag];
    [textFieldTag mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(25);
        make.height.mas_equalTo(25);
        make.right.mas_equalTo(-10);
        make.centerY.equalTo(textField);
    }];
    return textField;
}
#pragma mark - 查询记录按钮的点击
- (void)searchRecordBtnClick
{
    SearchRecordViewController *searchRecordCtl = [[SearchRecordViewController alloc] init];
    searchRecordCtl.title = @"查询记录";
    searchRecordCtl.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:searchRecordCtl animated:YES];
    
}
#pragma mark - 查询按钮的点击
- (void)searchBtnClick
{
    NSString *date = _date.text;
    if (date.length == 0) {
        return;
    }
    //将农历转换为阳历
    if ([_dataSelectedButton.titleLabel.text isEqualToString:@"农历"]) {
        date = [self changeOldDateToInternationalDate:date];
    }
    NSString *time       = [NSString stringWithFormat:@"%@ %@",date,_time.text];
    NSString *remark     = _remark.text;
    NSString *searchInfo = [NSString stringWithFormat:@"%@ %@",time,remark];
    [self getBaZiData:time];
    [[UserDataManager shareInstance] saveSearchRecord:searchInfo];
}
#pragma mark - 阴历转换为阳历
- (NSString *)changeOldDateToInternationalDate:(NSString *)date
{
    NSString *year  = [date substringWithRange:NSMakeRange(0, 4)];
    NSString *month = [date substringWithRange:NSMakeRange(5, 2)];
    NSString *day   = [date substringWithRange:NSMakeRange(8, 2)];
    Lunar *lunar = [[Lunar alloc] initWithYear:[year intValue] andMonth:[month intValue] andDay:[day intValue]];
    Solar *s     = [CalendarDisplyManager obtainSolarFromLunar:lunar];
    date         = [NSString stringWithFormat:@"%i-%i-%i",s.solarYear,s.solarMonth,s.solarDay];
    return date;
    
}
#pragma mark - 请求八字数据
- (void)getBaZiData:(NSString *)time
{
    NSLog(@"请求八字时间为————————————%@",time);
    //1.创建会话管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [[NSSet alloc] initWithObjects:@"application/xml", @"text/xml",@"text/html", @"application/json",@"text/plain",nil];
    
    //2.封装参数
    NSDictionary *dict = @{
                           @"action":@"getSiZhuAndCharacterDate",
                           @"dateTime":time,
                           };
    //3.get请求
    [manager GET:@"http://rcwifa.com/imade/index.php/Home/SiZhu/getData" parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        Bazi *bazi = [[Bazi alloc] init];
        bazi.timeTianGan    = responseObject[@"data"][@"siZhuGanZhi_Arr"][@"timeGanZhi_Arr"][0];
        bazi.timeDiZhi      = responseObject[@"data"][@"siZhuGanZhi_Arr"][@"timeGanZhi_Arr"][1];
        bazi.dataTianGan    = responseObject[@"data"][@"siZhuGanZhi_Arr"][@"dataGanZhi_Arr"][0];
        bazi.dataDiZhi      = responseObject[@"data"][@"siZhuGanZhi_Arr"][@"dataGanZhi_Arr"][1];
        bazi.monthTianGan   = responseObject[@"data"][@"siZhuGanZhi_Arr"][@"monthGanZhi_Arr"][0];
        bazi.monthDiZhi     = responseObject[@"data"][@"siZhuGanZhi_Arr"][@"monthGanZhi_Arr"][1];
        bazi.yearTianGan    = responseObject[@"data"][@"siZhuGanZhi_Arr"][@"yearGanZhi_Arr"][0];
        bazi.yearDiZhi      = responseObject[@"data"][@"siZhuGanZhi_Arr"][@"yearGanZhi_Arr"][1];
        
        bazi.detailTime     = time;
        bazi.character      = responseObject[@"data"][@"character"];
        
        //将八字信息保存到用户信息里，以便以后访问
        [[UserDataManager shareInstance] saveMyBaziInfo:bazi];
        _baziAlertView = [[BaziAlertView alloc] initWithFrame:CGRectMake(0, -SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _baziAlertView.bazi = bazi;
        [self.view addSubview:_baziAlertView];
        [UIView animateWithDuration:0.3 animations:^{
            self.baziAlertView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        }];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"failure--%@",error);
    }];

}
#pragma mark - 日期选择器
- (void)showDatePick:(UITextField *)textField
{
    if (_datePicker == nil) {
        
        UIView *contenView = [[UIView alloc] initWithFrame:CGRectMake(0,DatePickContentY,SCREEN_WIDTH,DatePickContentHeight)];
        contenView.backgroundColor = [UIColor whiteColor];
        _contentView = contenView;
        [self.view addSubview:_contentView];
        //日期时间选择器
        UIDatePicker *datePicker = [ [ UIDatePicker alloc] initWithFrame:CGRectMake(0,60,SCREEN_WIDTH,DatePickHeight)];
        if (textField.tag == 1) {
            datePicker.datePickerMode = UIDatePickerModeDate;
        }else{
            datePicker.datePickerMode = UIDatePickerModeTime;
            
        }
        datePicker.backgroundColor = [UIColor whiteColor];
        datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
        _datePicker = datePicker;
        [_contentView addSubview: _datePicker];
        
        UIButton *cancelButton = [[UIButton alloc]init];
        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [cancelButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        _cancelBtn = cancelButton;
        [_contentView addSubview:_cancelBtn];
        [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(5);
            make.width.mas_equalTo(45);
            make.height.mas_equalTo(45);
        }];
        UIButton *confirmButton = [[UIButton alloc]init];
        [confirmButton setTitle:@"确定" forState:UIControlStateNormal];
        [confirmButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        _confirmBtn = confirmButton;
        [_contentView addSubview:_confirmBtn];
        [_confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.top.mas_equalTo(5);
            make.width.mas_equalTo(45);
            make.height.mas_equalTo(45);
        }];
        
        [_cancelBtn addTarget:self action:@selector(hideDatePicker) forControlEvents:UIControlEventTouchDown];
        [_confirmBtn addTarget:self action:@selector(confirmDateOrTime) forControlEvents:UIControlEventTouchDown];

    }else{
        if (textField.tag == 1) {
            _datePicker.datePickerMode = UIDatePickerModeDate;
        }else{
            _datePicker.datePickerMode = UIDatePickerModeTime;
            
        }
    }
    _contentView.hidden = NO;
}
#pragma mark - 日期选择器的取消按钮
- (void)hideDatePicker
{
    _contentView.hidden = YES;
}
#pragma mark - 日期选择器的确定按钮
- (void)confirmDateOrTime
{
    NSDate *theDate = _datePicker.date;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    if (_datePicker.datePickerMode == UIDatePickerModeDate) {
        dateFormatter.dateFormat = @"YYYY-MM-dd";
        _date.text = [dateFormatter stringFromDate:theDate];
    }else{
        dateFormatter.dateFormat = @"HH:mm";
        _time.text = [dateFormatter stringFromDate:theDate];
    }
    _contentView.hidden = YES;
}
#pragma mark - 性别选择按钮的点击
- (void)maleBtnClick:(UIButton *)button
{
    _maleSelectedButton.selected = NO;
    button.selected              = YES;
    _maleSelectedButton          = button;
    NSLog(@"%@",button.titleLabel.text);
}
#pragma mark - 阴阳历选择按钮的点击
- (void)dataBtnClick:(UIButton *)button
{
    _dataSelectedButton.selected = NO;
    button.selected              = YES;
    _dataSelectedButton          = button;
    NSLog(@"%@",button.titleLabel.text);

}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_baziAlertView removeFromSuperview];
    [_remark resignFirstResponder];
}
#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
}
#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return NO;
}


@end
