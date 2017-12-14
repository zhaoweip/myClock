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

#define SelectTimeLabelToTop        FitSize(80,80,80,100)
#define SelectTimeLabelFont         FitSize(20,24,24,24)
#define RemarkTextViewHeight        FitSize(120,160,180,180)
#define TimePickerViewHeight        FitSize(130,150,150,150)
#define RingTextFieldWidth          FitSize(170,200,240,210)
#define ConfirmBtnToTop             FitSize(20,40,40,40)



@interface AddAlarmViewController ()<UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate,SelectRingDelegate>

@property(nonatomic,strong) NSArray *pickerMonthData;
@property(nonatomic,strong) NSArray *pickerDateData;
@property(nonatomic,strong) NSArray *pickerDayData;
@property(nonatomic,strong) NSArray *pickerShiChenData;
@property(nonatomic,strong) NSArray *pickerHourData;
@property(nonatomic,strong) NSArray *pickerMinuteChenData;

@property(nonatomic,strong) UILabel      *selectTimeLabel;
@property(nonatomic,strong) UIPickerView *timePickerView;
@property(nonatomic,strong) UITextField  *ringTextField;
@property(nonatomic,strong) UIButton     *selectRingBtn;
@property(nonatomic,strong) UILabel      *remindTag;
@property(nonatomic,strong) UITextView   *remarkTextView;

@property(nonatomic,strong) UIButton *cancelBtn;
@property(nonatomic,strong) UIButton *confirmBtn;

@property(nonatomic,assign) NSInteger     ringIndex;   //铃声下标
@property(nonatomic,assign) SystemSoundID soundID; //铃声ID
@property(nonatomic,copy)   NSString      *soundName;


@end

@implementation AddAlarmViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:31/255.0 green:46/255.0 blue:67/255.0 alpha:1.0]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    _pickerMonthData = [[NSArray alloc] initWithObjects:@"01月",@"02月",@"03月",@"04月",@"05月",@"06月",@"07月",@"08月",@"09月",@"10月",@"11月",@"12月", nil];
    
    _pickerDateData = [[NSArray alloc] initWithObjects:@"01日",@"02日",@"03日",@"04日",@"05日",@"06日",@"07日",@"08日",@"09日",@"10日",@"11日",@"12日",@"13日",@"14日",@"15日",@"16日",@"17日",@"18日",@"19日",@"20日",@"21日",@"22日",@"23日",@"24日",@"25日",@"26日",@"27日",@"28日",@"29日",@"30日",@"31日", nil];
    
    _pickerDayData = [[NSArray alloc] initWithObjects:@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日", nil];
    
    _pickerShiChenData = [[NSArray alloc] initWithObjects:@"子时",@"丑时",@"寅时",@"卯时",@"辰时",@"巳时",@"午时",@"未时",@"申时",@"酉时",@"戌时",@"亥时", nil];
    _pickerHourData = [[NSArray alloc] initWithObjects:@"00",@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23", nil];
    _pickerMinuteChenData = [[NSArray alloc] initWithObjects:@"00",@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31",@"32",@"33",@"34",@"35",@"36",@"37",@"38",@"39",@"40",@"41",@"42",@"43",@"44",@"45",@"46",@"47",@"48",@"49",@"50",@"51",@"52",@"53",@"54",@"55",@"56",@"57",@"58",@"59", nil];

    //当页面为添加闹钟页面时，默认值如下
    _soundName = @"metal";
    [self setBackImage];
    [self setSubView];
    [self setEditStatus];
    
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
- (void)keyboardWillHide:(NSNotification *)aNotification
{
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
}

//设置背景图片
- (void)setBackImage
{
    UIImageView *backImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_base_bg.png"]];
    backImage.frame = self.view.frame;
    [self.view addSubview:backImage];
}
- (void)setSubView
{
    _selectTimeLabel           = [[UILabel alloc] init];
    _selectTimeLabel.textColor = [UIColor whiteColor];
    _selectTimeLabel.font      = [UIFont systemFontOfSize:SelectTimeLabelFont];
    [self.view addSubview:_selectTimeLabel];
    [_selectTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(SelectTimeLabelToTop);
    }];
    
    _timePickerView                   = [[UIPickerView alloc] init];
    _timePickerView.layer.borderColor = [UIColor grayColor].CGColor;
    _timePickerView.layer.borderWidth = 2;
    self.timePickerView.delegate      = self;
    self.timePickerView.dataSource    = self;
    [self.view addSubview:_timePickerView];
    [_timePickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(-2);
        make.right.mas_equalTo(2);
        make.top.equalTo(_selectTimeLabel.mas_bottom).offset(15);
        make.height.mas_equalTo(TimePickerViewHeight);
    }];
    
    _ringTextField                    = [[UITextField alloc] init];
    _ringTextField.backgroundColor    = [UIColor whiteColor];
    _ringTextField.textColor          = [UIColor grayColor];
    _ringTextField.layer.cornerRadius = 10;
    _ringTextField.text               = @"金";
    _ringTextField.delegate           = self;
    //设置左边视图的宽度
    _ringTextField.leftView           = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 0)];
    //设置显示模式为永远显示(默认不显示 必须设置 否则没有效果)
    _ringTextField.leftViewMode       = UITextFieldViewModeAlways;
    [self.view addSubview:_ringTextField];
    [_ringTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30);
        make.top.equalTo(_timePickerView.mas_bottom).offset(20);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(RingTextFieldWidth);
    }];
    
    _selectRingBtn                    = [[UIButton alloc] init];
    _selectRingBtn.layer.cornerRadius = 10;
    _selectRingBtn.backgroundColor    = [UIColor whiteColor];
    [_selectRingBtn setTitle:@"选择铃声" forState:UIControlStateNormal];
    [_selectRingBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:_selectRingBtn];
    [_selectRingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_ringTextField.mas_right).offset(10);
        make.right.mas_equalTo(-30);
        make.height.equalTo(_ringTextField);
        make.centerY.equalTo(_ringTextField);
    }];
    
    _remindTag           = [[UILabel alloc] init];
    _remindTag.text      = @"活动提醒:";
    _remindTag.textColor = [UIColor whiteColor];
    [self.view addSubview:_remindTag];
    [_remindTag mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_ringTextField);
        make.top.equalTo(_ringTextField.mas_bottom).offset(15);
    }];
    
    _remarkTextView                    = [[UITextView alloc] init];
    _remarkTextView.layer.cornerRadius = 10;
    _remarkTextView.backgroundColor    = [UIColor whiteColor];
    [self.view addSubview:_remarkTextView];
    [_remarkTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_ringTextField);
        make.right.equalTo(_selectRingBtn);
        make.top.equalTo(_remindTag.mas_bottom).offset(15);
        make.height.mas_equalTo(RemarkTextViewHeight);
    }];
    
    _cancelBtn = [[UIButton alloc] init];
    [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.view addSubview:_cancelBtn];
    [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_timePickerView.mas_left).offset(40);
        make.top.equalTo(_remarkTextView.mas_bottom).offset(ConfirmBtnToTop);
    }];
    
    _confirmBtn = [[UIButton alloc] init];
    [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.view addSubview:_confirmBtn];
    [_confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_timePickerView.mas_right).offset(-40);
        make.top.equalTo(_remarkTextView.mas_bottom).offset(ConfirmBtnToTop);
    }];
    
    [_selectRingBtn addTarget:self action:@selector(clickSelectRingBtn) forControlEvents:UIControlEventTouchDown];
    [_cancelBtn addTarget:self action:@selector(clickcancelBtn) forControlEvents:UIControlEventTouchDown];
    [_confirmBtn addTarget:self action:@selector(clickconfirmBtn) forControlEvents:UIControlEventTouchDown];

}
#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 6;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    //component表示拨盘
    if (component == 0) {
        return _pickerMonthData.count*10;
    }
     else if (component == 1) {
         return _pickerDateData.count*10;
    }
    else  if (component == 2) {
        return _pickerDayData.count*10;
    }
    else if (component == 3) {
        return _pickerShiChenData.count;
    }
    else  if (component == 4) {
        return _pickerHourData.count;
    }
    else  {
        return _pickerMinuteChenData.count*10;
    }
}

#pragma mark - UIPickerViewDelegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    //component表示拨盘,row表示拨盘下的选项
    if (component == 0) {
        return [_pickerMonthData objectAtIndex:(row%self.pickerMonthData.count)];
    }
    else if(component == 1){
        return [_pickerDateData objectAtIndex:(row%self.pickerDateData.count)];
    }
    else if(component == 2){
        return [_pickerDayData objectAtIndex:(row%self.pickerDayData.count)];
    }
    else if(component == 3){
        return [_pickerShiChenData objectAtIndex:row];
    }
    else if(component == 4){
        return [_pickerHourData objectAtIndex:row];
    }
    else{
        return [_pickerMinuteChenData objectAtIndex:(row%self.pickerMinuteChenData.count)];
    }
    
}
#pragma mark - 选中选择器的某个拨盘中的某行时调用
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    //获得每一列的对应数据，要相应的除以对应数组进行取余
    NSString *currentYearString = [WPDateTimeUtils getCurrentTimeWithFormatter:@"YYYY"];
    NSInteger year              = [currentYearString integerValue];
    NSString *month             = [self.pickerMonthData objectAtIndex:[self.timePickerView selectedRowInComponent:0]%12];
    NSString *date              = [self.pickerDateData objectAtIndex:[self.timePickerView selectedRowInComponent:1]%31];
    NSString *day               = [self.pickerDayData objectAtIndex:[self.timePickerView selectedRowInComponent:2]%7];
    NSString *shichen           = [self.pickerShiChenData objectAtIndex:[self.timePickerView selectedRowInComponent:3]];
    NSString *hour              = [self.pickerHourData objectAtIndex:[self.timePickerView selectedRowInComponent:4]];
    NSString *minutes           = [self.pickerMinuteChenData objectAtIndex:[self.timePickerView selectedRowInComponent:5]%60];

    //如果页面为编辑状态,year应该为传入的值
    if (self.isEditing) {
        year = [[_alarmModel.timeStr substringToIndex:4] integerValue];
    }
    
    //只有滑动月份的时候，相应的年份才会依次增加
    if (component == 0) {
        year = [currentYearString intValue] + row/12;
    }
    //日期与星期联动
    if (component == 0 || component == 1 || component == 2) {
        
        //月份天数限制
        NSInteger dateInt = [[date substringToIndex:2] intValue];
        NSInteger count   = [WPDateTimeUtils getDaysInThisYear:(int)year withMonth:[[month substringToIndex:2] intValue]];
        if (dateInt > count) {
            [self.timePickerView selectRow:count-1 inComponent:1 animated:YES];
        }
        
        //获取星期之前要重新获取月份日期，不然会得到跳转前的日期
        month   = [self.pickerMonthData objectAtIndex:[self.timePickerView selectedRowInComponent:0]%12];
        date    = [self.pickerDateData objectAtIndex:[self.timePickerView selectedRowInComponent:1]%31];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *destDate = [dateFormatter dateFromString:[NSString stringWithFormat:@"%ld-%@-%@",year,[month substringToIndex:2],[date substringToIndex:2]]];
        NSString *weekStr = [WPDateTimeUtils weekdayStringFromDate:destDate];
        [self.timePickerView selectRow:[self.pickerDayData indexOfObject:weekStr] inComponent:2 animated:YES];
        //星期与日期关联之后，要重新获取星期
        day = [self.pickerDayData objectAtIndex:[self.timePickerView selectedRowInComponent:2]%7];
        
    }
    //时辰选择列，相应的小时会跟着跳转
    if (component == 3) {
        if (row != 0) {
            [self.timePickerView selectRow:row*2-1 inComponent:4 animated:YES];
        }else{
            [self.timePickerView selectRow:23 inComponent:4 animated:YES];
        }
        hour = [self.pickerHourData objectAtIndex:[self.timePickerView selectedRowInComponent:4]];
    }
    //小时选择列，相应的时辰会跟着跳转
    if (component == 4) {
        if (row == 0 || row==23) {
            [self.timePickerView selectRow:0 inComponent:3 animated:YES];
        }else{
            NSLog(@"%ld",(row+1)/2);
            [self.timePickerView selectRow:(row+1)/2 inComponent:3 animated:YES];
        }
        shichen = [self.pickerShiChenData objectAtIndex:[self.timePickerView selectedRowInComponent:3]];
    }
    
    _selectTimeLabel.text = [NSString stringWithFormat:@"%ld年%@%@ %@ %@ %@:%@",year,month,date,day,shichen,hour,minutes];
    
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        pickerLabel.textAlignment = NSTextAlignmentCenter;
        pickerLabel.textColor = [UIColor colorWithRed:245/255.0 green:218/255.0 blue:142/255.0 alpha:1];
        pickerLabel.font = [UIFont systemFontOfSize:24];
    }
    // Fill the label text here
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_remarkTextView resignFirstResponder];
}
#pragma mark - 点击按钮
- (void)clickSelectRingBtn
{
    SelectRingViewController *selectRing = [[SelectRingViewController alloc]init];
    selectRing.title = @"选择铃声";
    selectRing.hidesBottomBarWhenPushed = YES;
    selectRing.delegate = self;
    selectRing.ringKey = _ringTextField.text;
    [self.navigationController pushViewController:selectRing animated:YES];
    
}
- (void)clickcancelBtn
{
    [self.navigationController popViewControllerAnimated:YES];
}

//点击确定的时候，将闹钟保存起来（使用模型，添加到用户数据上，采用单例以便全局使用）
- (void)clickconfirmBtn
{
    Alarm *alarm    = [[Alarm alloc] init];
    alarm.timeStr   = _selectTimeLabel.text;
    alarm.ringName  = _ringTextField.text;
    alarm.soundName = _soundName;
    alarm.remarkStr = _remarkTextView.text;
    
    if (self.isEditing) {
        //修改闹钟模型数组
        Alarm *oldAlarm = [[UserDataManager shareInstance] getOneAlarmFromIndex:self.indexOfModelArray];
        alarm.isOpen    = oldAlarm.isOpen;
        [[UserDataManager shareInstance] editAlarmModelAtIndex:self.indexOfModelArray withNewModel:alarm];
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        //保存闹钟模型
        alarm.isOpen = YES;
        [[UserDataManager shareInstance] saveAlarmModel:alarm];
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}
#pragma mark - SelectRingDelegate
- (void)selectRing:(NSInteger)index withSoundName:(NSString *)soundName andSoundKey:(NSString *)soundKey
{
    _ringTextField.text = soundKey;
    _soundName          = soundName;
}
#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return NO;
}

- (void)setEditStatus
{
    //修改页面
    if (self.isEditing) {
        
        _ringTextField.text    = _alarmModel.ringName;
        _remarkTextView.text   = _alarmModel.remarkStr;
        _selectTimeLabel.text  = _alarmModel.timeStr;
        
        NSString *yearStr      = [_alarmModel.timeStr substringWithRange:NSMakeRange(0, 4)];
        NSString *currentYear  = [WPDateTimeUtils getCurrentTimeWithFormatter:@"YYYY"];
        NSString *monthStr     = [_alarmModel.timeStr substringWithRange:NSMakeRange(5, 3)];
        NSString *dateStr      = [_alarmModel.timeStr substringWithRange:NSMakeRange(8, 3)];
        NSString *dayStr       = [_alarmModel.timeStr substringWithRange:NSMakeRange(12, 2)];
        NSString *shiChenStr   = [_alarmModel.timeStr substringWithRange:NSMakeRange(15, 2)];
        NSString *hourStr      = [_alarmModel.timeStr substringWithRange:NSMakeRange(18, 2)];
        NSString *minuteStr    = [_alarmModel.timeStr substringWithRange:NSMakeRange(21, 2)];
        
        int yearCount = 0;
        if ([yearStr intValue] > [currentYear intValue]) {
            yearCount = [yearStr intValue] - [currentYear intValue];
        }
        [self.timePickerView selectRow:[self.pickerMonthData indexOfObject:monthStr]+yearCount*12 inComponent:0 animated:YES];
        [self.timePickerView selectRow:[self.pickerDateData indexOfObject:dateStr] inComponent:1 animated:YES];
        [self.timePickerView selectRow:[self.pickerDayData indexOfObject:dayStr] inComponent:2 animated:YES];
        [self.timePickerView selectRow:[self.pickerShiChenData indexOfObject:shiChenStr] inComponent:3 animated:YES];
        [self.timePickerView selectRow:[self.pickerHourData indexOfObject:hourStr] inComponent:4 animated:YES];
        [self.timePickerView selectRow:[self.pickerMinuteChenData indexOfObject:minuteStr] inComponent:5 animated:YES];

    }else{
        NSString *year       = [WPDateTimeUtils getCurrentTimeWithFormatter:@"yyyy年"];
        NSString *monthStr   = [WPDateTimeUtils getCurrentTimeWithFormatter:@"MM月"];
        NSString *dateStr    = [WPDateTimeUtils getCurrentTimeWithFormatter:@"dd日"];
        NSString *dayStr     = [WPDateTimeUtils getChineseWeekFromEng:[WPDateTimeUtils getCurrentTimeWithFormatter:@"eee"]];
        NSString *shiChenStr = [WPDateTimeUtils getShiChenStringFromHour:[WPDateTimeUtils getCurrentTimeWithFormatter:@"HH"]];
        NSString *hourStr    = [WPDateTimeUtils getCurrentTimeWithFormatter:@"HH"];
        NSString *minuteStr  = [WPDateTimeUtils getCurrentTimeWithFormatter:@"mm"];

        NSString *defaultCurrentTimeStr = [NSString stringWithFormat:@"%@%@%@ %@ %@ %@:%@",year,monthStr,dateStr,dayStr,shiChenStr,hourStr,minuteStr];
        _selectTimeLabel.text = defaultCurrentTimeStr;
        
        [self.timePickerView selectRow:[self.pickerMonthData indexOfObject:monthStr] inComponent:0 animated:YES];
        [self.timePickerView selectRow:[self.pickerDateData indexOfObject:dateStr] inComponent:1 animated:YES];
        [self.timePickerView selectRow:[self.pickerDayData indexOfObject:dayStr] inComponent:2 animated:YES];
        [self.timePickerView selectRow:[self.pickerShiChenData indexOfObject:shiChenStr] inComponent:3 animated:YES];
        [self.timePickerView selectRow:[self.pickerHourData indexOfObject:hourStr] inComponent:4 animated:YES];
        [self.timePickerView selectRow:[self.pickerMinuteChenData indexOfObject:minuteStr] inComponent:5 animated:YES];
        
    }
}

@end
