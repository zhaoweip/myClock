//
//  YiJiCalendarViewController.m
//  myClock
//
//  Created by Macintosh on 20/11/17.
//  Copyright © 2017年 Macintosh. All rights reserved.
//

#import "YiJiCalendarViewController.h"
#import "SKConstant.h"
#import "SKCalendarManage.h"

@interface YiJiCalendarViewController ()<SKCalendarViewDelegate>
@property (nonatomic, strong) UILabel * selectedDateLabel;//选择的日期
@property (nonatomic, strong) UILabel * selectedDayLabel;//星期
@property (nonatomic, strong) SKCalendarView * calendarView;
@property (nonatomic, strong) UIButton * nextButton;
@property (nonatomic, strong) UIButton * lastButton;
@property (nonatomic, strong) UILabel * chineseYearLabel;// 农历年
@property (nonatomic, strong) UILabel * chineseMonthAndDayLabel;
@property (nonatomic, strong) UILabel * yearLabel;// 公历年
@property (nonatomic, strong) UILabel * holidayLabel;//节日&节气
@property (nonatomic, strong) UIButton * backToday;// 返回今天

@property (nonatomic, assign) NSUInteger lastMonth;
@property (nonatomic, assign) NSUInteger nextMonth;


@end

@implementation YiJiCalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:31/255.0 green:46/255.0 blue:67/255.0 alpha:1.0]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self setBackImage];
    [self.view addSubview:self.calendarView];
    
    //选择的日期
    self.selectedDateLabel = [UILabel new];
    [self.view addSubview:self.selectedDateLabel];
    self.selectedDateLabel.font = [UIFont systemFontOfSize:24 weight:8];
    self.selectedDateLabel.textColor = [UIColor whiteColor];
//    self.selectedDateLabel.text = @"2012年8月12日";
    [self.selectedDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(80);
        make.left.mas_equalTo(50);
    }];
    
    //选择的星期
    self.selectedDayLabel = [UILabel new];
    [self.view addSubview:self.selectedDayLabel];
    self.selectedDayLabel.font = [UIFont systemFontOfSize:24 weight:7];
    self.selectedDayLabel.textColor = [UIColor whiteColor];
    self.selectedDayLabel.text = @"星期四";
    [self.selectedDayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.selectedDateLabel.mas_bottom).offset(10);
        make.left.equalTo(self.selectedDateLabel);
    }];
    
    
    // 查看下个月
    self.nextButton = [UIButton new];
    [self.view addSubview:self.nextButton];
    [self.nextButton setTitle:[NSString stringWithFormat:@"%@月", @(self.nextMonth)] forState:UIControlStateNormal];
    [self.nextButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.calendarView.mas_bottom);
        make.right.equalTo(self.calendarView.mas_right).with.offset(-10);
    }];
    [self.nextButton addTarget:self action:@selector(checkNextMonthCalendar) forControlEvents:UIControlEventTouchUpInside];
    
    // 查看上个月
    self.lastButton = [UIButton new];
    [self.view addSubview:self.lastButton];
    [self.lastButton setTitle:[NSString stringWithFormat:@"%@月", @(self.lastMonth)] forState:UIControlStateNormal];
    [self.lastButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.lastButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.calendarView.mas_bottom);
        make.left.equalTo(self.calendarView.mas_left).with.offset(10);
    }];
    [self.lastButton addTarget:self action:@selector(checkLastMonthCalendar) forControlEvents:UIControlEventTouchUpInside];
    
    // 公历年
    self.yearLabel = [UILabel new];
    [self.view addSubview:self.yearLabel];
    self.yearLabel.font = [UIFont systemFontOfSize:18];
    self.yearLabel.text = [NSString stringWithFormat:@"%@年%@月", @(self.calendarView.year), @(self.calendarView.month)];
    [self.yearLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.calendarView.mas_bottom).with.offset(5);
        make.centerX.equalTo(self.calendarView);
    }];
    
    // 农历年
    self.chineseYearLabel = [UILabel new];
    [self.view addSubview:self.chineseYearLabel];
    self.chineseYearLabel.font = [UIFont systemFontOfSize:18];
    self.chineseYearLabel.text = [NSString stringWithFormat:@"%@年", self.calendarView.chineseYear];
    self.chineseYearLabel.textAlignment = NSTextAlignmentCenter;
    [self.chineseYearLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.calendarView.mas_bottom).with.offset(50);
        make.centerX.equalTo(self.calendarView);
    }];
    
    // 农历月日
    self.chineseMonthAndDayLabel = [UILabel new];
    [self.view addSubview:self.chineseMonthAndDayLabel];
    self.chineseMonthAndDayLabel.font = [UIFont systemFontOfSize:15];
    self.chineseMonthAndDayLabel.textColor = [UIColor redColor];
    // 默认农历日期 今天
    self.chineseMonthAndDayLabel.text = [NSString stringWithFormat:@"%@%@", self.calendarView.chineseCalendarMonth[self.calendarView.todayInMonth - 1], getNoneNil(self.calendarView.chineseCalendarDay[self.calendarView.todayInMonth])];
    self.chineseMonthAndDayLabel.textAlignment = NSTextAlignmentCenter;
    [self.chineseMonthAndDayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.chineseYearLabel.mas_bottom).with.offset(5);
        make.centerX.equalTo(self.chineseYearLabel);
    }];
    
    // 节日&节气
    self.holidayLabel = [UILabel new];
    [self.view addSubview:self.holidayLabel];
    self.holidayLabel.font = [UIFont systemFontOfSize:15];
    self.holidayLabel.textColor = [UIColor purpleColor];
    self.holidayLabel.textAlignment = NSTextAlignmentCenter;
    // 获取节日，注意：此处传入的参数为chineseCalendarDay(包含不节日等信息)
    self.holidayLabel.text = [self.calendarView getHolidayAndSolarTermsWithChineseDay:getNoneNil(self.calendarView.chineseCalendarDay[self.calendarView.todayInMonth])];
    [self.holidayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.chineseMonthAndDayLabel.mas_bottom).with.offset(5);
        make.centerX.equalTo(self.chineseMonthAndDayLabel);
    }];
    
    // 返回今天
    self.backToday = [UIButton new];
    [self.view addSubview:self.backToday];
    [self.backToday setTitle:@"返回今天" forState:UIControlStateNormal];
    [self.backToday setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [self.backToday mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.calendarView.mas_top).with.offset(-5);
        make.centerX.equalTo(self.calendarView);
    }];
    [self.backToday addTarget:self action:@selector(clickBackToday) forControlEvents:UIControlEventTouchUpInside];

    
    [self selectDateWithRow:[SKCalendarManage manage].todayPosition];
    
}
//设置背景图片
- (void)setBackImage{
    UIImageView *backImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_base_bg.png"]];
    backImage.frame = self.view.frame;
    [self.view addSubview:backImage];
}
#pragma mark - 日历设置
- (SKCalendarView *)calendarView
{
    if (!_calendarView) {
        _calendarView = [[SKCalendarView alloc] initWithFrame:CGRectMake(self.view.center.x - 150, self.view.center.y - 150, 300, 300)];
        _calendarView.layer.cornerRadius = 5;
        _calendarView.layer.borderColor = [UIColor whiteColor].CGColor;
        _calendarView.layer.borderWidth = 0.5;
        _calendarView.delegate = self;// 获取点击日期的方法，一定要遵循协议
        _calendarView.calendarTodayTitleColor = [UIColor redColor];// 今天标题字体颜色
        _calendarView.calendarTitleColor = [UIColor whiteColor];   //日期标题字体颜色
        _calendarView.calendarTodayTitle = @"今日";// 今天下标题
        _calendarView.dateColor = [UIColor orangeColor];// 今天日期数字背景颜色
        _calendarView.calendarTodayColor = [UIColor whiteColor];// 今天日期字体颜色
        _calendarView.dayoffInWeekColor = [UIColor whiteColor];
        _calendarView.springColor = [UIColor colorWithRed:48 / 255.0 green:200 / 255.0 blue:104 / 255.0 alpha:1];// 春季节气颜色
        _calendarView.summerColor = [UIColor colorWithRed:18 / 255.0 green:96 / 255.0 blue:0 alpha:8];// 夏季节气颜色
        _calendarView.autumnColor = [UIColor colorWithRed:232 / 255.0 green:195 / 255.0 blue:0 / 255.0 alpha:1];// 秋季节气颜色
        _calendarView.winterColor = [UIColor colorWithRed:77 / 255.0 green:161 / 255.0 blue:255 / 255.0 alpha:1];// 冬季节气颜色
        _calendarView.holidayColor = [UIColor whiteColor];//节日字体颜色
        self.lastMonth = _calendarView.lastMonth;// 获取上个月的月份
        self.nextMonth = _calendarView.nextMonth;// 获取下个月的月份
    }
    
    return _calendarView;
}

#pragma mark - 查看上/下一月份日历
- (void)checkNextMonthCalendar
{
    self.calendarView.checkNextMonth = YES;// 查看下月
    [self changeButton:self.nextButton isNext:YES];
    [SKCalendarAnimationManage animationWithView:self.calendarView andEffect:SK_ANIMATION_REVEAL isNext:YES];
    self.chineseYearLabel.text = [NSString stringWithFormat:@"%@年", self.calendarView.chineseYear];// 农历年
    self.yearLabel.text = [NSString stringWithFormat:@"%@年%@月", @(self.calendarView.year), @(self.calendarView.month)];// 公历年
}

- (void)checkLastMonthCalendar
{
    self.calendarView.checkLastMonth = YES;// 查看上月
    [self changeButton:self.lastButton isNext:NO];
    [SKCalendarAnimationManage animationWithView:self.calendarView andEffect:SK_ANIMATION_REVEAL isNext:NO];
    self.chineseYearLabel.text = [NSString stringWithFormat:@"%@年", self.calendarView.chineseYear];// 农历年
    self.yearLabel.text = [NSString stringWithFormat:@"%@年%@月", @(self.calendarView.year), @(self.calendarView.month)];// 公历年
}

// 改变上/下月按钮的月份
- (void)changeButton:(UIButton *)button isNext:(BOOL)next
{
    if (next == YES) {
        self.lastMonth = self.lastMonth + 1;
        self.nextMonth = self.nextMonth + 1;
        if (self.lastMonth > 12) {
            self.lastMonth = 1;
        }
        if (self.nextMonth > 12) {
            self.nextMonth = 1;
        }
    } else {
        self.lastMonth = self.lastMonth - 1;
        self.nextMonth = self.nextMonth - 1;
        if (self.lastMonth < 1) {
            self.lastMonth = 12;
        }
        if (self.nextMonth < 1) {
            self.nextMonth = 12;
        }
    }
    [self.lastButton setTitle:[NSString stringWithFormat:@"%@月", @(self.lastMonth)] forState:UIControlStateNormal];
    [self.nextButton setTitle:[NSString stringWithFormat:@"%@月", @(self.nextMonth)] forState:UIControlStateNormal];
}

#pragma mark - 点击日期
- (void)selectDateWithRow:(NSUInteger)row
{
    NSInteger todayDate = (row-([SKCalendarManage manage].dayInWeek-2));

    if (todayDate >= 1 && todayDate <= [SKCalendarManage manage].days) {
        
        //选择的日期
        self.selectedDateLabel.text = [NSString stringWithFormat:@"%lu年%lu月%lu日",(unsigned long)self.calendarView.year,(unsigned long)self.calendarView.month,todayDate];
        //选择的星期
        self.selectedDayLabel.text = [NSString stringWithFormat:@"星期%@",[[SKCalendarManage manage].weekList objectAtIndex:row%7]];

    }
    self.chineseMonthAndDayLabel.text = [NSString stringWithFormat:@"%@%@", self.calendarView.chineseCalendarMonth[row], getNoneNil(self.calendarView.chineseCalendarDay[row])];
    // 获取节日，注意：此处传入的参数为chineseCalendarDay(不包含节日等信息)
    self.holidayLabel.text = [self.calendarView getHolidayAndSolarTermsWithChineseDay:getNoneNil(self.calendarView.chineseCalendarDay[row])];
}

#pragma mark - 返回今日
- (void)clickBackToday
{
    [self.calendarView checkCalendarWithAppointDate:[NSDate date]];
    self.lastMonth = _calendarView.lastMonth;// 获取上个月的月份
    self.nextMonth = _calendarView.nextMonth;// 获取下个月的月份
    [self.lastButton setTitle:[NSString stringWithFormat:@"%@月", @(self.lastMonth)] forState:UIControlStateNormal];
    [self.nextButton setTitle:[NSString stringWithFormat:@"%@月", @(self.nextMonth)] forState:UIControlStateNormal];
}

@end
