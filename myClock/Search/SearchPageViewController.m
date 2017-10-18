//
//  SearchPageViewController.m
//  myClock
//
//  Created by Macintosh on 11/10/17.
//  Copyright © 2017年 Macintosh. All rights reserved.
//

#import "SearchPageViewController.h"

#define LabelTagToTop            FitSize(50,70,70,90)
#define LabelTagEdgeMargin       FitSize(30,42,42,42)
#define LabelTagAndImgOffset     FitSize(5,7,7,7)
#define LabelTagImgWidth         FitSize(10,10,12,12)
#define LabelTagFontSize         FitSize(16,18,20,20)

#define SelectedButtonEdgeMargin FitSize(60,90,90,90)
#define SelectedButtonToLeft     FitSize(120,150,150,150)

#define SearchButtonMarginToTop  FitSize(70,100,130,130)

#define DatePickHeight           SCREEN_HEIGHT*0.3
#define DatePickContentHeight    SCREEN_HEIGHT*0.3+60
#define DatePickContentY         SCREEN_HEIGHT*0.7-60



@interface SearchPageViewController ()<UINavigationControllerDelegate,UITextFieldDelegate>

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

@end

@implementation SearchPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setBackImage];
    [self setSearceContent];
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
    
    
    _date = [self createTextFieldWithTag:1 andLastView:_oldDateBtn];
    _time = [self createTextFieldWithTag:2 andLastView:_date];

    
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
- (UIButton *)createButtonWithTitle:(NSString *)title{
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:title forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"Inquire_normal.png"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"Inquire_selected.png"] forState:UIControlStateSelected];
    [self.view addSubview:button];
    return button;
}
//创建textfield
- (UITextField *)createTextFieldWithTag:(NSInteger)tag andLastView:(UIView *)lastView{
    UITextField *textField = [[UITextField alloc] init];
    textField.backgroundColor = [UIColor whiteColor];
    textField.textColor = [UIColor grayColor];
    textField.layer.cornerRadius = 10;
    //设置左边视图的宽度
    textField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 0)];
    //设置显示模式为永远显示(默认不显示 必须设置 否则没有效果)
    textField.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:textField];
    
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lastView.mas_bottom).offset(20);
        make.left.mas_equalTo(38);
        make.right.mas_equalTo(-38);
        make.height.mas_equalTo(45);
    }];

    textField.delegate = self;
    textField.tag = tag;
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

- (void)searchBtnClick{
    NSLog(@"%@-----%@",_dataSelectedButton.titleLabel.text,_maleSelectedButton.titleLabel.text);
    NSLog(@"%@-----%@",_date.text,_time.text);
}
//日期选择器
- (void)showDatePick:(UITextField *)textField{
    
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

- (void)hideDatePicker{
    _contentView.hidden = YES;
}
- (void)confirmDateOrTime{
    NSDate *theDate = _datePicker.date;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    if (_datePicker.datePickerMode == UIDatePickerModeDate) {
        dateFormatter.dateFormat = @"YYYY-MM-dd";
        _date.text = [dateFormatter stringFromDate:theDate];
    }else{
        dateFormatter.dateFormat = @"HH:mm";
        _time.text = [dateFormatter stringFromDate:theDate];
    }
//    NSLog(@"%@",[dateFormatter stringFromDate:theDate]);
    _contentView.hidden = YES;
}

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
#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return NO;
}


@end
