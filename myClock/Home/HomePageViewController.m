//
//  HomePageViewController.m
//  myClock
//
//  Created by Macintosh on 11/10/17.
//  Copyright © 2017年 Macintosh. All rights reserved.
//

#import "HomePageViewController.h"
#import "HomePageHeaderView.h"
#import "HomePageTableViewCell.h"
#import "HomePageFootView.h"
#import "AddAlarmViewController.h"
#import "Alarm.h"


@interface HomePageViewController ()<UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource,MyHomePageFootViewDelegate>

@property (nonatomic, strong) UITableView *homePageTableView;


@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackImage];
    
    //设置导航控制器的代理为self，在代理方法里面去隐藏导航栏
    self.navigationController.delegate = self;
    
    //设置tableview
    _homePageTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -20, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    _homePageTableView.backgroundColor = [UIColor clearColor];
    _homePageTableView.delegate = self;
    _homePageTableView.dataSource = self;
    _homePageTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_homePageTableView];
    
    //头视图
    HomePageHeaderView *headerView = [[HomePageHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT * 0.5)];
    headerView.backgroundColor = [UIColor clearColor];
    self.homePageTableView.tableHeaderView = headerView;
    
    //尾视图
    HomePageFootView *footView = [[HomePageFootView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80)];
    footView.backgroundColor = [UIColor clearColor];
    footView.delegate = self;
    self.homePageTableView.tableFooterView = footView;
    
    
    [NotificationCenter addObserver:self
                           selector:@selector(alarmsChange)
                               name:@"MyAlarmsChangedNotification"
                             object:nil];
    
}
- (void)dealloc
{
    [NotificationCenter removeObserver:self];
}
- (void)alarmsChange{
    if ( [UserDataManager shareInstance].alarmModelArray) {
        NSLog(@"-----------%@",[UserDataManager shareInstance].alarmModelArray);
        Alarm *alarm = [[UserDataManager shareInstance].alarmModelArray objectAtIndex:0];
        NSLog(@"%@",alarm.remarkStr);
    }
}
//设置背景图片
- (void)setBackImage{
    UIImageView *backImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_base_bg.png"]];
    backImage.frame = self.view.frame;
    [self.view addSubview:backImage];
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *ID  = @"cell";
    //1.从复用池中（复用队列）中根据标识取一个cell
    HomePageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    //2.如果取不到则创建一个cell 并指定一个复用标识
    if (cell == nil) {
        cell = [[HomePageTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSLog(@"creat cell:%ld", indexPath.row);
    }
    return cell;
}


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - MyHomePageFootViewDelegate
- (void)footViewClickAddButton
{
    AddAlarmViewController *addAlarm = [[AddAlarmViewController alloc]init];
    addAlarm.title = @"添加闹钟";
    addAlarm.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:addAlarm animated:YES];
}

@end
