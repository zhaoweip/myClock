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
@property (nonatomic, strong) NSDictionary *ringsDict;



@end

@implementation SelectRingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _ringsArray = [[NSArray alloc] initWithObjects:@"金",@"木",@"水",@"火",@"土", nil];
    _ringsDict = @{@"金":@"metal",@"木":@"wood",@"水":@"water",@"火":@"fire",@"土":@"earth"};
    
    [self setBackImage];
    [self setUpTableView];
    [self setUpSelectRing];
    
    
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
//设置选中铃声
- (void)setUpSelectRing{
//    NSLog(@"==========%ld-----%@",_ringIndex,_ringKey);
//    NSInteger aa = [_ringsArray indexOfObject:_ringKey];
    NSIndexPath * selIndexPath = [NSIndexPath indexPathForRow:[_ringsArray indexOfObject:_ringKey] inSection:0];
    UITableViewCell *newCell = [_ringsTableView cellForRowAtIndexPath:selIndexPath];
    newCell.accessoryType = UITableViewCellAccessoryCheckmark;
    _selectPath = selIndexPath;
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
    return 60;
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
    
    [self destroyAudioServices];

    NSString *soundKey = [_ringsArray objectAtIndex:indexPath.row];
    NSString *soundName = [_ringsDict objectForKey:soundKey];
    
    //1.获得音效文件的全路径
    NSURL *url=[[NSBundle mainBundle] URLForResource:soundName withExtension:@"aif"];
    
    //2.加载音效文件，创建音效ID（SoundID,一个ID对应一个音效文件）
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &_soundID);
    
    
    // 完成播放之后执行的soundCompleteCallback函数
    AudioServicesAddSystemSoundCompletion(_soundID, NULL, NULL, soundCompleteCallback, NULL);
    
    //3.播放音效文件
    AudioServicesPlayAlertSound(_soundID);
    
    //通知tabBarVc切换控制器
    if ([_delegate respondsToSelector:@selector(selectRing:withSoundName:andSoundKey:)]) {
        [_delegate selectRing:indexPath.row withSoundName:soundName andSoundKey:soundKey];
    }
}
#pragma mark - 播放完成之后执行的函数----c函数
void soundCompleteCallback(SystemSoundID sound,void * clientData)
{
    NSLog(@"播放完成");
}
- (void)viewDidAppear:(BOOL)animated{
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [self destroyAudioServices];
}
#pragma mark - 销毁音效和震动
- (void)destroyAudioServices{
    AudioServicesDisposeSystemSoundID(kSystemSoundID_Vibrate);
    AudioServicesDisposeSystemSoundID(_soundID);
    AudioServicesRemoveSystemSoundCompletion(_soundID);

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
