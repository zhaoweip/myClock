//
//  SearchRecordViewController.m
//  myClock
//
//  Created by Macintosh on 15/12/17.
//  Copyright © 2017年 Macintosh. All rights reserved.
//

#import "SearchRecordViewController.h"
#import "Bazi.h"
#import "BaziAlertView.h"

@interface SearchRecordViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView    *searchRecordTableView;
@property (nonatomic, strong) NSMutableArray *searchRecordArray;
@property (nonatomic, strong) BaziAlertView  *baziAlertView;


@end

@implementation SearchRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:31/255.0 green:46/255.0 blue:67/255.0 alpha:1.0]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self setBackImage];
    
    //设置tableview
    _searchRecordTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    _searchRecordTableView.backgroundColor = [UIColor clearColor];
    _searchRecordTableView.delegate        = self;
    _searchRecordTableView.dataSource      = self;
    _searchRecordTableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_searchRecordTableView];
    
}
//设置背景图片
- (void)setBackImage
{
    UIImageView *backImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_base_bg.png"]];
    backImage.frame        = self.view.frame;
    [self.view addSubview:backImage];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.searchRecordArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID  = @"cell";
    //1.从复用池中（复用队列）中根据标识取一个cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    //2.如果取不到则创建一个cell 并指定一个复用标识
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        cell.backgroundColor     = [UIColor clearColor];
        cell.selectionStyle      = UITableViewCellSelectionStyleNone;
        cell.textLabel.textColor = [UIColor whiteColor];
        [WPLayoutUtils addBottomDivider:cell size:1 color:[UIColor whiteColor] leftEdge:10 rightEdge:0];
    }
    cell.textLabel.text = self.searchRecordArray[indexPath.row];
    return cell;
}


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *searchInfo = [self.searchRecordArray objectAtIndex:indexPath.row];
    NSString *time       = [searchInfo substringToIndex:16];
    [self getBaZiData:time];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.searchRecordArray = [[UserDataManager shareInstance] getAllSearchRecord];
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
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_baziAlertView removeFromSuperview];
}


@end
