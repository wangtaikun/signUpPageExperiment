//
//  AppDelegate.m
//  SignUpPageExperiment
//
//  Created by wangtaikun on 2018/8/7.
//  Copyright © 2018年 wangtaikun. All rights reserved.
//
#import <IQKeyboardManager/IQKeyboardManager.h>

#import "AppDelegate.h"
#import "ViewController.h"
#import "ShowViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

/* didFinishLaunchingWithOptions：不用故事版的时候设置根viewController；设置第三方库的初始化之类的。
* launchOptions是指示app启动原因的字典（如果有）。这个字典也可能是空的在用户直接点击图标启动的情况下。
* 例如当程序关闭，并且有推送消息过来的时候，通过点击推送打开app这个字典就包含推送过来的消息内容
* 用于完成app的初始化和一些微调。这个方法在状态复位的时候调用，但是发生在app的window和其他UI展现之前。
* 在某些情况下，当这个方法返回值之后，系统会调用其他的代理方法。(当用户进入前台状态或者后台状态的情况)。
*/
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    //加载第一个页面；
    ViewController *viewController = [[ViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
    [self initKeyBoard];
    return YES;
}

//设置键盘样式
-(void)initKeyBoard {
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager];
    // 控制整个功能是否启用
    keyboardManager.enable = YES;
    // 控制点击背景是否收起键盘
    keyboardManager.shouldResignOnTouchOutside = YES;
    // 控制键盘上的工具条文字颜色是否用户自定义
    keyboardManager.shouldToolbarUsesTextFieldTintColor = YES;
    // 有多个输入框时，可以通过点击Toolbar 上的“前一个”“后一个”按钮来实现移动到不同的输入框
    keyboardManager.toolbarManageBehaviour = IQAutoToolbarBySubviews;
    // 控制是否显示键盘上的工具条
    keyboardManager.enableAutoToolbar = YES;
    // 是否显示占位文字
    keyboardManager.shouldShowTextFieldPlaceholder = YES;
    // 设置占位文字的字体
    keyboardManager.placeholderFont = [UIFont boldSystemFontOfSize:13];
    // 输入框距离键盘的距离
    keyboardManager.keyboardDistanceFromTextField = 10.0f;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    // 使用这个方法去暂停正在进行的任务、禁用timers；如果app使用了没有保存的用户数据，应该在这个方法里面保存。然而，不要依赖特定的app状态来保存用户的data。
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    // 执行已经进入后台的操作，发出一个UIApplicationDidEnterBackgroundNotification通知，如果有的类或者对象需要关注这个状态改变可以去接收这个通知处理。
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    // 恢复运行所需要的信息
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    // 重启程序在非活动状态时被暂停的任务。如果程序之前在后台运行可以选择是否刷新用户界面。
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // 程序将要终止时会调用该方法。尽可能保存需要的数据。
}

@end
