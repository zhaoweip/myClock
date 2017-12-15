//
//  SearchRecordViewController.m
//  myClock
//
//  Created by Macintosh on 15/12/17.
//  Copyright © 2017年 Macintosh. All rights reserved.
//

#import "SearchRecordViewController.h"

@interface SearchRecordViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *searchRecordTableView;

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
    _searchRecordTableView.delegate = self;
    _searchRecordTableView.dataSource = self;
    _searchRecordTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_searchRecordTableView];
    
}
//设置背景图片
- (void)setBackImage
{
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    //2.如果取不到则创建一个cell 并指定一个复用标识
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle  = UITableViewCellSelectionStyleNone;
        NSLog(@"creat cell:%ld", indexPath.row);
        cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
        cell.textLabel.textColor = [UIColor whiteColor];
        [WPLayoutUtils addBottomDivider:cell size:1 color:[UIColor whiteColor] leftEdge:10 rightEdge:0];
    }
    
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
    NSLog(@"didSelectRowAtIndexPath");
}


@end
