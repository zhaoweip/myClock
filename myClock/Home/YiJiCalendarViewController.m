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

#define LeftMargin                FitSize(20,28,30,28)
#define TopMargin                 FitSize(10,80,80,100)
#define CalendarToTop             FitSize(90,160,160,180)
#define CalendarWidth             FitSize(280,320,350,320)
#define ScrollerContentHeight     FitSize(SCREEN_HEIGHT*1.1,SCREEN_HEIGHT,SCREEN_HEIGHT,SCREEN_HEIGHT)


@interface YiJiCalendarViewController ()<SKCalendarViewDelegate>

@property (nonatomic, strong) UIScrollView * scrollView;

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

@property (nonatomic, strong) UILabel * yiLabel;
@property (nonatomic, strong) UILabel * jiLabel;
@property (nonatomic, strong) UILabel * yiDetailLabel;
@property (nonatomic, strong) UILabel * jiDetailLabel;

@property (nonatomic, strong) NSMutableArray * oneMonthYiJiEventArray;
@property (nonatomic, strong) NSMutableArray * oneMonthYiEventArray;
@property (nonatomic, strong) NSMutableArray * oneMonthJiEventArray;

@end

@implementation YiJiCalendarViewController

- (NSMutableArray *)oneMonthYiJiEventArray
{
    if (!_oneMonthYiJiEventArray) {
        _oneMonthYiJiEventArray = [NSMutableArray array];
    }
    return _oneMonthYiJiEventArray;
}
- (NSMutableArray *)oneMonthYiEventArray
{
    if (!_oneMonthYiEventArray) {
        _oneMonthYiEventArray = [NSMutableArray array];
    }
    return _oneMonthYiEventArray;
}
- (NSMutableArray *)oneMonthJiEventArray
{
    if (!_oneMonthJiEventArray) {
        _oneMonthJiEventArray = [NSMutableArray array];
    }
    return _oneMonthJiEventArray;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:31/255.0 green:46/255.0 blue:67/255.0 alpha:1.0]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self setBackImage];
    [self setSubviews];
}
//设置背景图片
- (void)setBackImage
{
    UIImageView *backImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_base_bg.png"]];
    backImage.frame = self.view.frame;
    [self.view addSubview:backImage];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, ScrollerContentHeight);
    [self.view addSubview:_scrollView];
}
- (void)setSubviews
{
    //选择的日期
    self.selectedDateLabel           = [UILabel new];
    self.selectedDateLabel.font      = [UIFont systemFontOfSize:24 weight:8];
    self.selectedDateLabel.textColor = [UIColor whiteColor];
    [self.scrollView addSubview:self.selectedDateLabel];
    [self.selectedDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(TopMargin);
        make.left.mas_equalTo(LeftMargin);
    }];
    
    //选择的星期
    self.selectedDayLabel           = [UILabel new];
    self.selectedDayLabel.font      = [UIFont systemFontOfSize:24 weight:7];
    self.selectedDayLabel.textColor = [UIColor whiteColor];
    [self.scrollView addSubview:self.selectedDayLabel];
    [self.selectedDayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.selectedDateLabel.mas_bottom).offset(10);
        make.left.equalTo(self.selectedDateLabel);
    }];

    //日历
    [self.scrollView addSubview:self.calendarView];

    // 查看下个月
    self.nextButton = [UIButton new];
    [self.nextButton setTitle:[NSString stringWithFormat:@"%@月", @(self.nextMonth)] forState:UIControlStateNormal];
    [self.nextButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.scrollView addSubview:self.nextButton];
    [self.nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.calendarView.mas_bottom);
        make.right.equalTo(self.calendarView.mas_right).with.offset(-10);
    }];
    [self.nextButton addTarget:self action:@selector(checkNextMonthCalendar) forControlEvents:UIControlEventTouchUpInside];

    // 查看上个月
    self.lastButton = [UIButton new];
    [self.lastButton setTitle:[NSString stringWithFormat:@"%@月", @(self.lastMonth)] forState:UIControlStateNormal];
    [self.lastButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.scrollView addSubview:self.lastButton];
    [self.lastButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.calendarView.mas_bottom);
        make.left.equalTo(self.calendarView.mas_left).with.offset(10);
    }];
    [self.lastButton addTarget:self action:@selector(checkLastMonthCalendar) forControlEvents:UIControlEventTouchUpInside];

    // 返回今天
    self.backToday = [UIButton new];
    [self.scrollView addSubview:self.backToday];
    [self.backToday setTitle:@"返回今天" forState:UIControlStateNormal];
    [self.backToday setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.backToday mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.calendarView.mas_bottom);
        make.centerX.equalTo(self.calendarView);
    }];
    [self.backToday addTarget:self action:@selector(clickBackToday) forControlEvents:UIControlEventTouchUpInside];

    //宜
    self.yiLabel           = [UILabel new];
    self.yiLabel.text      = @"宜";
    self.yiLabel.font      = [UIFont systemFontOfSize:26 weight:10];
    self.yiLabel.textColor = [UIColor whiteColor];
    [self.scrollView addSubview:self.yiLabel];
    [self.yiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lastButton.mas_bottom).offset(10);
        make.left.equalTo(self.lastButton.mas_left);
    }];

    //忌
    self.jiLabel           = [UILabel new];
    self.jiLabel.text      = @"忌";
    self.jiLabel.font      = [UIFont systemFontOfSize:26 weight:10];
    self.jiLabel.textColor = [UIColor whiteColor];
    [self.scrollView addSubview:self.jiLabel];

    [self selectDateWithRow:[SKCalendarManage manage].todayPosition];
}
#pragma mark - 日历设置
- (SKCalendarView *)calendarView
{
    if (!_calendarView) {
        _calendarView = [[SKCalendarView alloc] initWithFrame:CGRectMake(LeftMargin, CalendarToTop, CalendarWidth, 300)];
        _calendarView.layer.cornerRadius      = 5;
        _calendarView.layer.borderColor       = [UIColor blackColor].CGColor;
        _calendarView.layer.borderWidth       = 1;
        _calendarView.delegate                = self;                   // 获取点击日期的方法，一定要遵循协议
        _calendarView.calendarTodayTitle      = @"今日";                 // 今天下标题
        _calendarView.calendarTodayTitleColor = [UIColor redColor];     // 今天标题字体颜色
        _calendarView.dateColor               = [UIColor orangeColor];  // 今天日期数字背景颜色
        _calendarView.calendarTodayColor      = [UIColor whiteColor];   // 今天日期字体颜色
        _calendarView.calendarTitleColor      = [UIColor whiteColor];   // 日期标题字体颜色
        _calendarView.dayoffInWeekColor       = [UIColor whiteColor];
        _calendarView.holidayColor            = [UIColor whiteColor]; //节日字体颜色
        _calendarView.springColor  = [UIColor colorWithRed:48 / 255.0 green:200 / 255.0 blue:104 / 255.0 alpha:1];// 春季节气颜色
        _calendarView.summerColor  = [UIColor colorWithRed:18 / 255.0 green:96 / 255.0 blue:0 alpha:8];           // 夏季节气颜色
        _calendarView.autumnColor  = [UIColor colorWithRed:232 / 255.0 green:195 / 255.0 blue:0 / 255.0 alpha:1]; // 秋季节气颜色
        _calendarView.winterColor  = [UIColor colorWithRed:77 / 255.0 green:161 / 255.0 blue:255 / 255.0 alpha:1];// 冬季节气颜色
        self.lastMonth = _calendarView.lastMonth;          // 获取上个月的月份
        self.nextMonth = _calendarView.nextMonth;          // 获取下个月的月份
    }
    
    return _calendarView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSString *yearMonth = [WPDateTimeUtils getCurrentTimeWithFormatter:@"yyyy-MM"];
    [self getOneMonthData:yearMonth];
}

- (void)getOneMonthData:(NSString *)yearMonth
{
    NSLog(@"请求月份的时间为————————————%@",yearMonth);
    //1.创建会话管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [[NSSet alloc] initWithObjects:@"application/xml", @"text/xml",@"text/html", @"application/json",@"text/plain",nil];
    
    //2.封装参数
    NSDictionary *dict = @{
                           @"action":@"getOneMonthYiJiEvent",
                           @"dateTime":yearMonth,
                           };
    //3.get请求
    [manager GET:@"http://rcwifa.com/imade/index.php/Home/SiZhu/getData" parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //将一个月的宜忌事件存入到二维数组中去
        [self.oneMonthYiJiEventArray  removeAllObjects];
        [self.oneMonthYiEventArray  removeAllObjects];
        [self.oneMonthJiEventArray  removeAllObjects];
        for (int i = 0; i < [responseObject[@"data"][@"oneMonthYiJi_Arr"] count]; i++) {
            [self.oneMonthYiEventArray addObject:responseObject[@"data"][@"oneMonthYiJi_Arr"][i][@"yi_Arr"]];
            [self.oneMonthJiEventArray addObject:responseObject[@"data"][@"oneMonthYiJi_Arr"][i][@"ji_Arr"]];
        }
        [self.oneMonthYiJiEventArray addObject:_oneMonthYiEventArray];
        [self.oneMonthYiJiEventArray addObject:_oneMonthJiEventArray];
        
        [self turnPageClickDate:yearMonth];
      
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"failure-------%@",error);
    }];
}

#pragma mark - 查看上/下一月份日历
- (void)checkNextMonthCalendar
{
    self.calendarView.checkNextMonth = YES;// 查看下月
    [self changeButton:self.nextButton isNext:YES];
    [SKCalendarAnimationManage animationWithView:self.calendarView andEffect:SK_ANIMATION_REVEAL isNext:YES];
//    self.chineseYearLabel.text = [NSString stringWithFormat:@"%@年", self.calendarView.chineseYear];// 农历年
    self.yearLabel.text = [NSString stringWithFormat:@"%@年%@月", @(self.calendarView.year), @(self.calendarView.month)];// 公历年
}

- (void)checkLastMonthCalendar
{
    self.calendarView.checkLastMonth = YES;// 查看上月
    [self changeButton:self.lastButton isNext:NO];
    [SKCalendarAnimationManage animationWithView:self.calendarView andEffect:SK_ANIMATION_REVEAL isNext:NO];
//    self.chineseYearLabel.text = [NSString stringWithFormat:@"%@年", self.calendarView.chineseYear];// 农历年
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
    [self getOneMonthData:[NSString stringWithFormat:@"%lu-%lu",(unsigned long)self.calendarView.year,(unsigned long)self.calendarView.month]];
    
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
        
        NSString *yiDetailText = @"";
        NSString *jiDetailText = @"";
        for (NSInteger i = [_oneMonthYiJiEventArray[0][todayDate-1] count]-1; i >= 0 ; i--) {
            yiDetailText = [NSString stringWithFormat:@"%@ %@",_oneMonthYiJiEventArray[0][todayDate-1][i],yiDetailText];
        }
        for (NSInteger i = [_oneMonthYiJiEventArray[1][todayDate-1] count]-1; i >=0 ; i--) {
            jiDetailText = [NSString stringWithFormat:@"%@ %@",_oneMonthYiJiEventArray[1][todayDate-1][i],jiDetailText];
        }
        
        [self.yiDetailLabel removeFromSuperview];
        self.yiDetailLabel               = [UILabel new];
        self.yiDetailLabel.text          = yiDetailText;
        self.yiDetailLabel.font          = [UIFont systemFontOfSize:15];
        self.yiDetailLabel.textColor     = [UIColor whiteColor];
        self.yiDetailLabel.numberOfLines = 0;
        [self.scrollView addSubview:self.yiDetailLabel];
        [self.yiDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.yiLabel.mas_top).offset(6);
            make.left.equalTo(self.yiLabel.mas_right).offset(10);
            make.right.equalTo(self.calendarView.mas_right);
        }];

        [self.jiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.yiDetailLabel.mas_bottom).offset(10);
            make.left.equalTo(self.yiLabel.mas_left);
        }];

        [self.jiDetailLabel removeFromSuperview];
        self.jiDetailLabel               = [UILabel new];
        self.jiDetailLabel.text          = jiDetailText;
        self.jiDetailLabel.font          = [UIFont systemFontOfSize:15];
        self.jiDetailLabel.textColor     = [UIColor whiteColor];
        self.jiDetailLabel.numberOfLines = 0;
        [self.scrollView addSubview:self.jiDetailLabel];
        [self.jiDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.jiLabel.mas_top).offset(6);
            make.left.equalTo(self.jiLabel.mas_right).offset(10);
            make.right.equalTo(self.calendarView.mas_right);
        }];

    }
}

#pragma mark - 返回今日
- (void)clickBackToday
{
    [self.calendarView checkCalendarWithAppointDate:[NSDate date]];
    self.lastMonth = _calendarView.lastMonth;// 获取上个月的月份
    self.nextMonth = _calendarView.nextMonth;// 获取下个月的月份
    [self.lastButton setTitle:[NSString stringWithFormat:@"%@月", @(self.lastMonth)] forState:UIControlStateNormal];
    [self.nextButton setTitle:[NSString stringWithFormat:@"%@月", @(self.nextMonth)] forState:UIControlStateNormal];
    [self getOneMonthData:[NSString stringWithFormat:@"%ld-%ld",_calendarView.year,_calendarView.month]];

}
#pragma mark - 翻页定位
- (void)turnPageClickDate:(NSString *)yearMonth
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM"];
    if ([yearMonth isEqualToString:[dateFormatter stringFromDate:[NSDate date]]]) {
        [self selectDateWithRow:[SKCalendarManage manage].todayPosition];

    }else{
        [self selectDateWithRow:[SKCalendarManage manage].dayInWeek-1];

    }
}

@end
