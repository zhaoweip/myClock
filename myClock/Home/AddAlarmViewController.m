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

@property(nonatomic,strong) NSArray *pickerMonthData;
@property(nonatomic,strong) NSArray *pickerDateData;
@property(nonatomic,strong) NSArray *pickerDayData;
@property(nonatomic,strong) NSArray *pickerShiChenData;
@property(nonatomic,strong) NSArray *pickerHourData;
@property(nonatomic,strong) NSArray *pickerMinuteChenData;

@property(nonatomic,strong) UILabel *selectTimeLabel;
@property(nonatomic,strong) UIPickerView *timePickerView;
@property(nonatomic,strong) UITextField *ringTextField;
@property(nonatomic,strong) UIButton *selectRingBtn;
@property(nonatomic,strong) UILabel *remindTag;
@property(nonatomic,strong) UITextView *remarkTextView;

@property(nonatomic,strong) UIButton *cancelBtn;
@property(nonatomic,strong) UIButton *confirmBtn;

@property(nonatomic,assign) NSInteger ringIndex;   //铃声下标
@property(nonatomic,assign) SystemSoundID soundID; //铃声ID
@property(nonatomic,copy) NSString *soundName;


@end

@implementation AddAlarmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _pickerMonthData = [[NSArray alloc] initWithObjects:@"01月",@"02月",@"03月",@"04月",@"05月",@"06月",@"07月",@"08月",@"09月",@"10月",@"11月",@"12月", nil];
    
    _pickerDateData = [[NSArray alloc] initWithObjects:@"01日",@"02日",@"03日",@"04日",@"05日",@"06日",@"07日",@"08日",@"09日",@"10日",@"11日",@"12日",@"13日",@"14日",@"15日",@"16日",@"17日",@"18日",@"19日",@"20日",@"21日",@"22日",@"23日",@"24日",@"25日",@"26日",@"27日",@"28日",@"29日",@"30日",@"31日", nil];
    
    _pickerDayData = [[NSArray alloc] initWithObjects:@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日", nil];
    
    _pickerShiChenData = [[NSArray alloc] initWithObjects:@"子时",@"丑时",@"寅时",@"卯时",@"辰时",@"巳时",@"午时",@"未时",@"申时",@"酉时",@"戌时",@"亥时", nil];
    _pickerHourData = [[NSArray alloc] initWithObjects:@"00",@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23", nil];
    _pickerMinuteChenData = [[NSArray alloc] initWithObjects:@"00",@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31",@"32",@"33",@"34",@"35",@"36",@"37",@"38",@"39",@"40",@"41",@"42",@"43",@"44",@"45",@"46",@"47",@"48",@"49",@"50",@"51",@"52",@"53",@"54",@"55",@"56",@"57",@"58",@"59", nil];

    //当页面为添加闹钟页面时，默认值如下
    _soundName = @"metal";
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:31/255.0 green:46/255.0 blue:67/255.0 alpha:1.0]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self setBackImage];
    [self setSubView];
    [self setEditStatus];  //设置编辑页面，会根据传入的下标以及ID设置铃声的默认值
    
    
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
    
    _selectTimeLabel = [[UILabel alloc] init];
    _selectTimeLabel.textColor = [UIColor whiteColor];
    _selectTimeLabel.font = [UIFont systemFontOfSize:24];
    [self.view addSubview:_selectTimeLabel];
    [_selectTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(80);
    }];
    
    _timePickerView = [[UIPickerView alloc] init];
    _timePickerView.layer.borderColor = [UIColor grayColor].CGColor;
    _timePickerView.layer.borderWidth = 2;
    [self.view addSubview:_timePickerView];
    self.timePickerView.delegate = self;
    self.timePickerView.dataSource = self;
    [_timePickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(-2);
        make.right.mas_equalTo(2);
        make.top.equalTo(_selectTimeLabel.mas_bottom).offset(15);
        make.height.mas_equalTo(150);
    }];
    
    _ringTextField = [[UITextField alloc] init];
    _ringTextField.backgroundColor = [UIColor whiteColor];
    _ringTextField.textColor = [UIColor grayColor];
    _ringTextField.layer.cornerRadius = 10;
    _ringTextField.text = @"金";
    _ringTextField.delegate = self;
    //设置左边视图的宽度
    _ringTextField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 0)];
    //设置显示模式为永远显示(默认不显示 必须设置 否则没有效果)
    _ringTextField.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:_ringTextField];
    [_ringTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30);
        make.top.equalTo(_timePickerView.mas_bottom).offset(20);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(SCREEN_WIDTH*0.6);
    }];
    
    _selectRingBtn = [[UIButton alloc] init];
    [_selectRingBtn setTitle:@"选择铃声" forState:UIControlStateNormal];
    [_selectRingBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _selectRingBtn.layer.cornerRadius = 10;
    _selectRingBtn.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_selectRingBtn];
    [_selectRingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_ringTextField.mas_right).offset(10);
        make.right.mas_equalTo(-30);
        make.height.equalTo(_ringTextField);
        make.centerY.equalTo(_ringTextField);
    }];
    
    _remindTag = [[UILabel alloc] init];
    _remindTag.text = @"活动提醒:";
    _remindTag.textColor = [UIColor whiteColor];
    [self.view addSubview:_remindTag];
    [_remindTag mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_ringTextField);
        make.top.equalTo(_ringTextField.mas_bottom).offset(15);
    }];
    
    _remarkTextView = [[UITextView alloc] init];
    _remarkTextView.layer.cornerRadius = 10;
    _remarkTextView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_remarkTextView];
    [_remarkTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_ringTextField);
        make.right.equalTo(_selectRingBtn);
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
    return 6;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == 0) {//第一个拨盘
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
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    //为选择器中某个拨盘的行提供数据
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
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    //获得每一列的对应数据，要相应的除以对应数组进行取余
    NSString *currentYearString = [self getCurrentTimeWithFormatter:@"YYYY"];
    NSInteger year    = [currentYearString integerValue];
    NSString *month   = [self.pickerMonthData objectAtIndex:[self.timePickerView selectedRowInComponent:0]%12];
    NSString *date    = [self.pickerDateData objectAtIndex:[self.timePickerView selectedRowInComponent:1]%31];
    NSString *day     = [self.pickerDayData objectAtIndex:[self.timePickerView selectedRowInComponent:2]%7];
    NSString *shichen = [self.pickerShiChenData objectAtIndex:[self.timePickerView selectedRowInComponent:3]];
    NSString *hour    = [self.pickerHourData objectAtIndex:[self.timePickerView selectedRowInComponent:4]];
    NSString *minutes = [self.pickerMinuteChenData objectAtIndex:[self.timePickerView selectedRowInComponent:5]%60];

    //只有滑动月份的时候，相应的年份才会依次增加
    if (component == 0) {
        year = [currentYearString intValue] + row/12;
    }
    //日期与星期联动
    if (component == 0 || component == 1 || component == 2) {
        
        //月份天数限制
        NSInteger dateInt = [[date substringToIndex:2] intValue];
        NSInteger count   = [self howManyDaysInThisYear:(int)year withMonth:[[month substringToIndex:2] intValue]];
        if (dateInt > count) {
            [self.timePickerView selectRow:count-1 inComponent:1 animated:YES];
        }
        
        //获取星期之前要重新获取月份日期，不然会得到跳转前的日期
        month   = [self.pickerMonthData objectAtIndex:[self.timePickerView selectedRowInComponent:0]%12];
        date    = [self.pickerDateData objectAtIndex:[self.timePickerView selectedRowInComponent:1]%31];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *destDate = [dateFormatter dateFromString:[NSString stringWithFormat:@"%ld-%@-%@",year,[month substringToIndex:2],[date substringToIndex:2]]];
        NSString *weekStr = [self weekdayStringFromDate:destDate];
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
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
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
//    selectRing.ringIndex = _ringIndex;  //将默认选择的铃声下标传到铃声选择页面
    selectRing.ringKey = _ringTextField.text;
    [self.navigationController pushViewController:selectRing animated:YES];
    
}
- (void)clickcancelBtn{
    [self.navigationController popViewControllerAnimated:YES];
}
//点击确定的时候，将闹钟保存起来（使用模型，添加到用户数据上，采用单例以便全局使用）
- (void)clickconfirmBtn{

    Alarm *alarm    = [[Alarm alloc] init];
    alarm.timeStr   = _selectTimeLabel.text;
    alarm.ringName  = _ringTextField.text;
    alarm.soundName = _soundName;
    alarm.remarkStr = _remarkTextView.text;
    
    if (self.isEditing) {
        //修改闹钟模型数组
        [[UserDataManager shareInstance] editAlarmModelAtIndex:self.indexOfModelArray withNewModel:alarm];
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        //保存闹钟模型
        [[UserDataManager shareInstance] saveAlarmModel:alarm];
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}
#pragma mark - SelectRingDelegate
- (void)selectRing:(NSInteger)index withSoundName:(NSString *)soundName andSoundKey:(NSString *)soundKey{
    _ringTextField.text = soundKey;
//    _ringIndex = index;
    _soundName = soundName;
}
#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return NO;
}

- (void)setEditStatus
{
    //修改页面
    if (self.isEditing) {
        
        _ringTextField.text    = _alarmModel.ringName;
        _remarkTextView.text   = _alarmModel.remarkStr;
        _selectTimeLabel.text  = _alarmModel.timeStr;
        
        NSString *yearStr      = [_alarmModel.timeStr substringWithRange:NSMakeRange(0, 5)];
        NSString *monthStr     = [_alarmModel.timeStr substringWithRange:NSMakeRange(5, 3)];
        NSString *dateStr      = [_alarmModel.timeStr substringWithRange:NSMakeRange(8, 3)];
        NSString *dayStr       = [_alarmModel.timeStr substringWithRange:NSMakeRange(12, 2)];
        NSString *shiChenStr   = [_alarmModel.timeStr substringWithRange:NSMakeRange(15, 2)];
        NSString *hourStr      = [_alarmModel.timeStr substringWithRange:NSMakeRange(18, 2)];
        NSString *minuteStr    = [_alarmModel.timeStr substringWithRange:NSMakeRange(21, 2)];

        [self.timePickerView selectRow:[self.pickerMonthData indexOfObject:monthStr] inComponent:0 animated:YES];
        [self.timePickerView selectRow:[self.pickerDateData indexOfObject:dateStr] inComponent:1 animated:YES];
        [self.timePickerView selectRow:[self.pickerDayData indexOfObject:dayStr] inComponent:2 animated:YES];
        [self.timePickerView selectRow:[self.pickerShiChenData indexOfObject:shiChenStr] inComponent:3 animated:YES];
        [self.timePickerView selectRow:[self.pickerHourData indexOfObject:hourStr] inComponent:4 animated:YES];
        [self.timePickerView selectRow:[self.pickerMinuteChenData indexOfObject:minuteStr] inComponent:5 animated:YES];

        
    }else{
        NSString *year    = [self getCurrentTimeWithFormatter:@"yyyy年"];
        NSString *monthStr   = [self getCurrentTimeWithFormatter:@"MM月"];
        NSString *dateStr    = [self getCurrentTimeWithFormatter:@"dd日"];
        NSString *dayStr     = [self getChineseWeekFromEng:[self getCurrentTimeWithFormatter:@"eee"]];
        NSString *shiChenStr = [self getShiChenStringFromHour:[self getCurrentTimeWithFormatter:@"HH"]];
        NSString *hourStr = [self getCurrentTimeWithFormatter:@"HH"];
        NSString *minuteStr = [self getCurrentTimeWithFormatter:@"mm"];


        NSString *defaultCurrentTimeStr = [NSString stringWithFormat:@"%@%@%@ %@ %@ %@:%@",year,monthStr,dateStr,dayStr,shiChenStr,hourStr,minuteStr];
        _selectTimeLabel.text = defaultCurrentTimeStr;
        NSLog(@"%@",defaultCurrentTimeStr);
        
        [self.timePickerView selectRow:[self.pickerMonthData indexOfObject:monthStr] inComponent:0 animated:YES];
        [self.timePickerView selectRow:[self.pickerDateData indexOfObject:dateStr] inComponent:1 animated:YES];
        [self.timePickerView selectRow:[self.pickerDayData indexOfObject:dayStr] inComponent:2 animated:YES];
        [self.timePickerView selectRow:[self.pickerShiChenData indexOfObject:shiChenStr] inComponent:3 animated:YES];
        [self.timePickerView selectRow:[self.pickerHourData indexOfObject:hourStr] inComponent:4 animated:YES];
        [self.timePickerView selectRow:[self.pickerMinuteChenData indexOfObject:minuteStr] inComponent:5 animated:YES];
        
    }
}
#pragma mark - 获取当前时间
- (NSString *)getCurrentTimeWithFormatter:(NSString *)formatterStr {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formatterStr];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    return dateTime;
}
#pragma mark - 获取某年某月的天数
- (NSInteger)howManyDaysInThisYear:(NSInteger)year withMonth:(NSInteger)month{
    if((month == 1) || (month == 3) || (month == 5) || (month == 7) || (month == 8) || (month == 10) || (month == 12))
        return 31 ;
    
    if((month == 4) || (month == 6) || (month == 9) || (month == 11))
        return 30;
    
    if((year % 4 == 1) || (year % 4 == 2) || (year % 4 == 3))
    {
        return 28;
    }
    
    if(year % 400 == 0)
        return 29;
    
    if(year % 100 == 0)
        return 28;
    
    return 29;
}
#pragma mark - 获取指定日期的星期
- (NSString*)weekdayStringFromDate:(NSDate*)inputDate {
    
    NSArray *weekdays =[NSArray arrayWithObjects:[NSNull null], @"周日", @"周一", @"周二", @"周三",@"周四", @"周五", @"周六",nil];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    [calendar setTimeZone: timeZone];
    NSCalendarUnit calendarUnit = NSWeekdayCalendarUnit;
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    return [weekdays objectAtIndex:theComponents.weekday];
}
#pragma mark - 根据小时获得时辰
- (NSString *)getShiChenStringFromHour:(NSString *)hour{
    int hourInt = [hour intValue];
    if (hourInt == 0 || hourInt == 23) {
        return @"子时";
    }else{
         return [_pickerShiChenData objectAtIndex:(hourInt + 1)/2];
    }
}
#pragma mark - 星期的中英文转换
- (NSString*)getChineseWeekFromEng:(NSString *)week{
    if ([week isEqualToString:@"Mon"]) {
        return @"周一";
    }else if([week isEqualToString:@"Tue"]){
        return @"周二";
    }else if([week isEqualToString:@"Wed"]){
        return @"周三";
    }else if([week isEqualToString:@"Thu"]){
        return @"周四";
    }else if([week isEqualToString:@"Fri"]){
        return @"周五";
    }else if([week isEqualToString:@"Sat"]){
        return @"周六";
    }else if([week isEqualToString:@"Sun"]){
        return @"周日";
    }else{
        return week;
    }
}

@end
