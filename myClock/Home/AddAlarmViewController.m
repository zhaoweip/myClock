//
//  AddAlarmViewController.m
//  myClock
//
//  Created by Macintosh on 23/10/17.
//  Copyright © 2017年 Macintosh. All rights reserved.
//

#import "AddAlarmViewController.h"
#import "SelectRingViewController.h"
#import "Alarm.h"


@interface AddAlarmViewController ()<UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate,SelectRingDelegate>

@property(nonatomic,strong) NSArray *pickerShiChenData;
@property(nonatomic,strong) NSArray *pickerHourData;
@property(nonatomic,strong) NSArray *pickerMinuteChenData;

@property(nonatomic,strong) UIPickerView *timePickerView;
@property(nonatomic,strong) UITextField *ringTextField;
@property(nonatomic,strong) UIButton *selectRingBtn;
@property(nonatomic,strong) UILabel *remindTag;
@property(nonatomic,strong) UITextView *remarkTextView;

@property(nonatomic,strong) UIButton *cancelBtn;
@property(nonatomic,strong) UIButton *confirmBtn;

@property(nonatomic,assign) NSInteger ringIndex;   //铃声下标
@property(nonatomic,assign) SystemSoundID soundID; //铃声ID


@end

@implementation AddAlarmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _pickerShiChenData = [[NSArray alloc] initWithObjects:@"子时",@"丑时",@"寅时",@"卯时",@"辰时",@"巳时",@"午时",@"未时",@"申时",@"酉时",@"戌时",@"亥时", nil];
    _pickerHourData = [[NSArray alloc] initWithObjects:@"00",@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23", nil];
    _pickerMinuteChenData = [[NSArray alloc] initWithObjects:@"00",@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31",@"32",@"33",@"34",@"35",@"36",@"37",@"38",@"39",@"40",@"41",@"42",@"43",@"44",@"45",@"46",@"47",@"48",@"49",@"50",@"51",@"52",@"53",@"54",@"55",@"56",@"57",@"58",@"59", nil];

    _ringIndex = 0;
    _soundID = 1020;
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:31/255.0 green:46/255.0 blue:67/255.0 alpha:1.0]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self setBackImage];
    [self setSubView];
    
    
    //增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}
//当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    self.view.frame = CGRectMake(0, -200, SCREEN_WIDTH, SCREEN_HEIGHT);
}
//当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification{
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
}

//设置背景图片
- (void)setBackImage{
    UIImageView *backImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_base_bg.png"]];
    backImage.frame = self.view.frame;
    [self.view addSubview:backImage];
}
- (void)setSubView{
    _timePickerView = [[UIPickerView alloc] init];
    _timePickerView.backgroundColor = [UIColor clearColor];
    _timePickerView.layer.cornerRadius = 10;
    _timePickerView.layer.borderColor = [UIColor whiteColor].CGColor;
    _timePickerView.layer.borderWidth = 1;
    [self.view addSubview:_timePickerView];
    self.timePickerView.delegate = self;
    self.timePickerView.dataSource = self;
    [_timePickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(40);
        make.right.mas_equalTo(-40);
        make.top.mas_equalTo(84);
        make.height.mas_equalTo(150);
    }];
    
    _ringTextField = [[UITextField alloc] init];
    _ringTextField.backgroundColor = [UIColor whiteColor];
    _ringTextField.textColor = [UIColor grayColor];
    _ringTextField.layer.cornerRadius = 10;
    _ringTextField.text = @"铃声1";
    _ringTextField.delegate = self;
    //设置左边视图的宽度
    _ringTextField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 0)];
    //设置显示模式为永远显示(默认不显示 必须设置 否则没有效果)
    _ringTextField.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:_ringTextField];
    [_ringTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_timePickerView);
        make.top.equalTo(_timePickerView.mas_bottom).offset(15);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(230);
    }];
    
    _selectRingBtn = [[UIButton alloc] init];
    [_selectRingBtn setTitle:@"选择铃声" forState:UIControlStateNormal];
    [_selectRingBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _selectRingBtn.layer.cornerRadius = 10;
    _selectRingBtn.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_selectRingBtn];
    [_selectRingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_ringTextField.mas_right).offset(10);
        make.right.mas_equalTo(-40);
        make.height.equalTo(_ringTextField);
        make.centerY.equalTo(_ringTextField);
    }];
    
    _remindTag = [[UILabel alloc] init];
    _remindTag.text = @"活动提醒:";
    _remindTag.textColor = [UIColor whiteColor];
    [self.view addSubview:_remindTag];
    [_remindTag mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_timePickerView);
        make.top.equalTo(_ringTextField.mas_bottom).offset(15);
    }];
    
    _remarkTextView = [[UITextView alloc] init];
    _remarkTextView.layer.cornerRadius = 10;
    _remarkTextView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_remarkTextView];
    [_remarkTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_timePickerView);
        make.right.equalTo(_timePickerView);
        make.top.equalTo(_remindTag.mas_bottom).offset(15);
        make.height.mas_equalTo(180);
    }];
    
    _cancelBtn = [[UIButton alloc] init];
    [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.view addSubview:_cancelBtn];
    [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_timePickerView.mas_left).offset(40);
        make.top.equalTo(_remarkTextView.mas_bottom).offset(40);
    }];
    
    _confirmBtn = [[UIButton alloc] init];
    [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.view addSubview:_confirmBtn];
    [_confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_timePickerView.mas_right).offset(-40);
        make.top.equalTo(_remarkTextView.mas_bottom).offset(40);
    }];
    
    [_selectRingBtn addTarget:self action:@selector(clickSelectRingBtn) forControlEvents:UIControlEventTouchDown];
    [_cancelBtn addTarget:self action:@selector(clickcancelBtn) forControlEvents:UIControlEventTouchDown];
    [_confirmBtn addTarget:self action:@selector(clickconfirmBtn) forControlEvents:UIControlEventTouchDown];

}
#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == 0) {//第一个拨盘
        return _pickerShiChenData.count;
    }
     else if (component == 1) {
         return _pickerHourData.count;
    }
    else  {
        return _pickerMinuteChenData.count;
    }
}

#pragma mark - UIPickerViewDelegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    //为选择器中某个拨盘的行提供数据
    if (component == 0) {
        return [_pickerShiChenData objectAtIndex:row];
    } else if(component == 1){
        return [_pickerHourData objectAtIndex:row];
    } else{
        return [_pickerMinuteChenData objectAtIndex:row];
    }
    
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    //选中选择器的某个拨盘中的某行时调用
    if (component == 0) {
        if (row != 0) {
            [self.timePickerView selectRow:row*2-1 inComponent:1 animated:YES];
        }else{
            [self.timePickerView selectRow:23 inComponent:1 animated:YES];
        }
    }
    if (component == 1) {
        if (row == 0 || row==23) {
            [self.timePickerView selectRow:0 inComponent:0 animated:YES];
        }else{
            NSLog(@"%ld",(row+1)/2);
            [self.timePickerView selectRow:(row+1)/2 inComponent:0 animated:YES];
        }
    }
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        pickerLabel.textAlignment = NSTextAlignmentCenter;
        pickerLabel.textColor = [UIColor whiteColor];
        pickerLabel.font = [UIFont systemFontOfSize:24];
    }
    // Fill the label text here
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_remarkTextView resignFirstResponder];
}
#pragma mark - 点击按钮
- (void)clickSelectRingBtn{

    SelectRingViewController *selectRing = [[SelectRingViewController alloc]init];
    selectRing.title = @"选择铃声";
    selectRing.hidesBottomBarWhenPushed = YES;
    selectRing.delegate = self;
    selectRing.ringIndex = _ringIndex;  //将默认选择的铃声下标传到铃声选择页面
    [self.navigationController pushViewController:selectRing animated:YES];
    
}
- (void)clickcancelBtn{
    [self.navigationController popViewControllerAnimated:YES];
}
//点击确定的时候，将闹钟保存起来（使用模型，添加到用户数据上，采用单例以便全局使用）
- (void)clickconfirmBtn{
    NSInteger row1 = [self.timePickerView selectedRowInComponent:0];
    NSInteger row2 = [self.timePickerView selectedRowInComponent:1];
    NSInteger row3 = [self.timePickerView selectedRowInComponent:2];
    NSString *shiChenStr=[self.pickerShiChenData objectAtIndex:row1];
    NSString *hourStr=[self.pickerHourData objectAtIndex:row2];
    NSString *minuteStr=[self.pickerMinuteChenData objectAtIndex:row3];
    
    Alarm *alarm = [[Alarm alloc] init];
    alarm.timeStr = [NSString stringWithFormat:@"%@ %@:%@",shiChenStr,hourStr,minuteStr];
    alarm.ringName = _ringTextField.text;
    alarm.soundID = _soundID;
    alarm.remarkStr = _remarkTextView.text;
    //保存闹钟模型
    [[UserDataManager shareInstance] saveAlarmModel:alarm];
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - SelectRingDelegate
- (void)selectRing:(NSInteger)index withSoundId:(SystemSoundID)soundID
{
    _ringTextField.text = [NSString stringWithFormat:@"铃声%ld",index+1];
    _ringIndex = index;
    _soundID = soundID;
    
}
#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return NO;
}
@end
