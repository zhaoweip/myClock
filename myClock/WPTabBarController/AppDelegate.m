//
//  AppDelegate.m
//  myClock
//
//  Created by Macintosh on 11/10/17.
//  Copyright © 2017年 Macintosh. All rights reserved.
//

#import "AppDelegate.h"
#import "WPTabBarController.h"
#import <UserNotifications/UserNotifications.h>
#import <AudioToolbox/AudioToolbox.h>


@interface AppDelegate ()<UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    WPTabBarController *tab = [[WPTabBarController alloc] init];
    self.window.rootViewController = tab;
    
    //iOS 10
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    center.delegate = self;
    [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert) completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (!error) {
            NSLog(@"request authorization succeeded!");
        }
    }];
    
//    // 设置应用程序的图标右上角的数字
//    [application setApplicationIconBadgeNumber:0];
//
//    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0) {
//        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound categories:nil];
//        [application registerUserNotificationSettings:settings];
//    }
//
//    // 界面的跳转(针对应用程序被杀死的状态下的跳转)
//    // 杀死状态下的，界面跳转并不会执行下面的方法- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification，
    // 所以我们在写本地通知的时候，要在这个与下面方法中写，但要判断，是通过哪种类型通知来打开的
    if (launchOptions[UIApplicationLaunchOptionsLocalNotificationKey]) {
        // 跳转代码
        UILabel *redView = [[UILabel alloc] init];
        redView.frame = CGRectMake(0, 0, 200, 300);
        redView.numberOfLines = 0;
        redView.font = [UIFont systemFontOfSize:12.0];
        redView.backgroundColor = [UIColor redColor];
        redView.text = [NSString stringWithFormat:@"%@", launchOptions];
        [self.window.rootViewController.view addSubview:redView];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"后台杀死的时候" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        //设置铃声和振动
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        AudioServicesPlaySystemSound(1027);
    }else{
        NSLog(@"2020");
    }
    
    return YES;
}

//- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
//    UIApplicationState state = application.applicationState;
//    NSLog(@"%ld",(long)state);
//    if (state == UIApplicationStateActive) {
//        NSLog(@"。。。。。。UIApplicationStateActive");
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒" message:notification.alertBody delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        [alert show];
//        //设置铃声和振动
//        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
//        AudioServicesPlaySystemSound(1021);
//        application.applicationIconBadgeNumber = 0;
//
//    }else if(state == UIApplicationStateBackground){
//        NSLog(@"-=-=-=-=UIApplicationStateBackground");
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒" message:notification.alertBody delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
//        [alert show];
//        //设置铃声和振动
//        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
//        AudioServicesPlaySystemSound(1021);
//        application.applicationIconBadgeNumber = 0;
//    }else{
//        NSLog(@"-=-=-=-=UIApplicationStateInactive");
//
//    }
//}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
//    completionHandler(UNNotificationPresentationOptionAlert | UNNotificationPresentationOptionSound);
    NSLog(@"123123123");
    //收到推送的请求
    UNNotificationRequest *request = notification.request;
    //收到推送的内容
    UNNotificationContent *content = request.content;
    NSString *body = content.body;
    NSLog(@"%@",body);
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒" message:body delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    //设置铃声和振动
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    AudioServicesPlaySystemSound(1027);
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler{
    NSLog(@"8989898");
    completionHandler(); // 系统要求执行这个方法
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    UIApplicationState state = application.applicationState;
    NSLog(@"-----------------%ld",(long)state);
    NSLog(@"DidEnterBackground");
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
