//
//  SelectRingViewController.m
//  myClock
//
//  Created by Macintosh on 30/10/17.
//  Copyright © 2017年 Macintosh. All rights reserved.
//

#import "SelectRingViewController.h"

@interface SelectRingViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *ringsTableView;
@property (nonatomic, strong) NSIndexPath *selectPath; //存放被点击的哪一行的标志
@property (nonatomic, strong) NSArray *ringsArray;



@end

@implementation SelectRingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setBackImage];
    [self setUpTableView];
    
    _ringsArray = [[NSArray alloc] initWithObjects:@"铃声1",@"铃声2",@"铃声3",@"铃声4",@"铃声5",@"铃声6",@"铃声7",@"铃声8",@"铃声9",@"铃声10",@"铃声11",@"铃声12",@"铃声13",@"铃声14",@"铃声15", @"铃声16",@"铃声17",@"铃声18",@"铃声19",@"铃声20", nil];
    
    
    
    
}
//设置背景图片
- (void)setBackImage{
    UIImageView *backImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_base_bg.png"]];
    backImage.frame = self.view.frame;
    [self.view addSubview:backImage];
}
//设置tableview
- (void)setUpTableView{
    _ringsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    _ringsTableView.backgroundColor = [UIColor clearColor];
    _ringsTableView.delegate = self;
    _ringsTableView.dataSource = self;
    _ringsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_ringsTableView];
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _ringsArray.count;
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
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.textColor = [UIColor whiteColor];
        NSLog(@"creat cell:%ld", indexPath.row);
        
    }
    cell.textLabel.text = [_ringsArray objectAtIndex:indexPath.row];

    
    if (_selectPath == indexPath) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    
    return cell;
}


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int newRow = (int)[indexPath row];
    int oldRow = (int)(_selectPath != nil) ? (int)[_selectPath row]:-1;
    if (newRow != oldRow) {
        UITableViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
        newCell.accessoryType = UITableViewCellAccessoryCheckmark;
        
        UITableViewCell *oldCell = [tableView cellForRowAtIndexPath:_selectPath];
        oldCell.accessoryType = UITableViewCellAccessoryNone;
        _selectPath = [indexPath copy];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"%ld",indexPath.row);
    
    _soundID = (int)indexPath.row + 1020;
    
    //1.获得音效文件的全路径
    NSURL *url=[[NSBundle mainBundle] URLForResource:@"4.wav" withExtension:nil];
    
    //2.加载音效文件，创建音效ID（SoundID,一个ID对应一个音效文件）
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &_soundID);
    
    
    // 完成播放之后执行的soundCompleteCallback函数
    AudioServicesAddSystemSoundCompletion(_soundID, NULL, NULL, soundCompleteCallback, NULL);
    
    //3.播放音效文件
    AudioServicesPlayAlertSound(_soundID);
    
    //通知tabBarVc切换控制器
    if ([_delegate respondsToSelector:@selector(selectRing:)]) {
        [_delegate selectRing:indexPath.row];
    }
}
#pragma mark - 播放完成之后执行的函数----c函数
void soundCompleteCallback(SystemSoundID sound,void * clientData)
{
    NSLog(@"播放完成");
}
- (void)viewDidAppear:(BOOL)animated{
    if (_ringIndex) {
        NSLog(@"==========%ld",_ringIndex);
        NSIndexPath * selIndexPath = [NSIndexPath indexPathForRow:_ringIndex inSection:0];
        UITableViewCell *newCell = [_ringsTableView cellForRowAtIndexPath:selIndexPath];
        newCell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
}
- (void)viewWillDisappear:(BOOL)animated{
    //销毁音效和震动
    AudioServicesDisposeSystemSoundID(kSystemSoundID_Vibrate);
    AudioServicesDisposeSystemSoundID(_soundID);
    AudioServicesRemoveSystemSoundCompletion(_soundID);

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
