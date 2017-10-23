//
//  AddAlarmViewController.m
//  myClock
//
//  Created by Macintosh on 23/10/17.
//  Copyright © 2017年 Macintosh. All rights reserved.
//

#import "AddAlarmViewController.h"

@interface AddAlarmViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>

@property(nonatomic,strong) UIPickerView *timePickerView;
@property(nonatomic,strong) NSArray *pickerShiChenData;
@property(nonatomic,strong) NSArray *pickerHourData;
@property(nonatomic,strong) NSArray *pickerMinuteChenData;

@end

@implementation AddAlarmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _pickerShiChenData = [[NSArray alloc] initWithObjects:@"子时",@"丑时",@"寅时",@"卯时",@"辰时",@"巳时",@"午时",@"未时",@"申时",@"酉时",@"戌时",@"亥时", nil];
    _pickerHourData = [[NSArray alloc] initWithObjects:@"00",@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23", nil];
    _pickerMinuteChenData = [[NSArray alloc] initWithObjects:@"00",@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31",@"32",@"33",@"34",@"35",@"36",@"37",@"38",@"39",@"40",@"41",@"42",@"43",@"44",@"45",@"46",@"47",@"48",@"49",@"50",@"51",@"52",@"53",@"54",@"55",@"56",@"57",@"58",@"59", nil];
    
    
    [self setBackImage];
    [self.navigationItem setHidesBackButton:YES];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:31/255.0 green:46/255.0 blue:67/255.0 alpha:1.0]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    _timePickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,250)];
    _timePickerView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_timePickerView];
    self.timePickerView.delegate = self;
    self.timePickerView.dataSource = self;
    
}
//设置背景图片
- (void)setBackImage{
    UIImageView *backImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_base_bg.png"]];
    backImage.frame = self.view.frame;
    [self.view addSubview:backImage];
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
//        switch (row) {
//            case 0:
//                [self.timePickerView selectRow:23 inComponent:1 animated:YES];
//                break;
//            case 1:
//                [self.timePickerView selectRow:1 inComponent:1 animated:YES];
//                break;
//            case 2:
//                [self.timePickerView selectRow:3 inComponent:1 animated:YES];
//                break;
//            case 3:
//                [self.timePickerView selectRow:5 inComponent:1 animated:YES];
//                break;
//            case 4:
//                [self.timePickerView selectRow:7 inComponent:1 animated:YES];
//                break;
//            case 5:
//                [self.timePickerView selectRow:9 inComponent:1 animated:YES];
//                break;
//            case 6:
//                [self.timePickerView selectRow:11 inComponent:1 animated:YES];
//                break;
//            case 7:
//                [self.timePickerView selectRow:13 inComponent:1 animated:YES];
//                break;
//            case 8:
//                [self.timePickerView selectRow:15 inComponent:1 animated:YES];
//                break;
//            case 9:
//                [self.timePickerView selectRow:17 inComponent:1 animated:YES];
//                break;
//            case 10:
//                [self.timePickerView selectRow:19 inComponent:1 animated:YES];
//                break;
//            case 11:
//                [self.timePickerView selectRow:21 inComponent:1 animated:YES];
//                break;
//            default:
//                break;
//        }
        if (row != 0) {
            [self.timePickerView selectRow:row*2-1 inComponent:1 animated:YES];
        }else{
            [self.timePickerView selectRow:23 inComponent:1 animated:YES];
        }
    }
    if (component == 1) {
        switch (row) {
            case 0:
                [self.timePickerView selectRow:0 inComponent:0 animated:YES];
                break;
            case 1:
                [self.timePickerView selectRow:1 inComponent:0 animated:YES];
                break;
            case 2:
                [self.timePickerView selectRow:1 inComponent:0 animated:YES];
                break;
            case 3:
                [self.timePickerView selectRow:2 inComponent:0 animated:YES];
                break;
            case 4:
                [self.timePickerView selectRow:2 inComponent:0 animated:YES];
                break;
            case 5:
                [self.timePickerView selectRow:3 inComponent:0 animated:YES];
                break;
            case 6:
                [self.timePickerView selectRow:3 inComponent:0 animated:YES];
                break;
            case 7:
                [self.timePickerView selectRow:4 inComponent:0 animated:YES];
                break;
            case 8:
                [self.timePickerView selectRow:4 inComponent:0 animated:YES];
                break;
            case 9:
                [self.timePickerView selectRow:5 inComponent:0 animated:YES];
                break;
            case 10:
                [self.timePickerView selectRow:5 inComponent:0 animated:YES];
                break;
            case 11:
                [self.timePickerView selectRow:6 inComponent:0 animated:YES];
                break;
            case 12:
                [self.timePickerView selectRow:6 inComponent:0 animated:YES];
                break;
            case 13:
                [self.timePickerView selectRow:7 inComponent:0 animated:YES];
                break;
            case 14:
                [self.timePickerView selectRow:7 inComponent:0 animated:YES];
                break;
            case 15:
                [self.timePickerView selectRow:8 inComponent:0 animated:YES];
                break;
            case 16:
                [self.timePickerView selectRow:8 inComponent:0 animated:YES];
                break;
            case 17:
                [self.timePickerView selectRow:9 inComponent:0 animated:YES];
                break;
            case 18:
                [self.timePickerView selectRow:9 inComponent:0 animated:YES];
                break;
            case 19:
                [self.timePickerView selectRow:10 inComponent:0 animated:YES];
                break;
            case 20:
                [self.timePickerView selectRow:10 inComponent:0 animated:YES];
                break;
            case 21:
                [self.timePickerView selectRow:11 inComponent:0 animated:YES];
                break;
            case 22:
                [self.timePickerView selectRow:11 inComponent:0 animated:YES];
                break;
            case 23:
                [self.timePickerView selectRow:0 inComponent:0 animated:YES];
                break;
            default:
                break;
        }
//        if (row == 0) {
//            NSLog(@"1111");
//        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
