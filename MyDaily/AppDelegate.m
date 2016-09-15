//
//  AppDelegate.m
//  MyDaily
//
//  Created by gaoyang on 16/9/15.
//  Copyright © 2016年 gaoyang. All rights reserved.
//

#import "AppDelegate.h"
#import "MDMainNavigationViewController.h"
#import "UIDefine.h"

@interface AppDelegate ()<UITabBarDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self initTabBarController];
    
    self.window.rootViewController = [[MDMainNavigationViewController alloc] initWithRootViewController:_tabBarController];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void )initTabBarController {
    _tabBarController = [[UITabBarController alloc] init];
//    _tabBarController.delegate = self;
    UITabBarItem * diaryItem = [[UITabBarItem alloc] initWithTitle:@"日历" image:UI_IMAGE(@"tabbar_calander") selectedImage:UI_IMAGE(@"tabbar_calander") ];
    UIViewController * firstVC = [[UIViewController alloc] init];
    firstVC.tabBarItem = diaryItem;
    
    UITabBarItem * statisticItem = [[UITabBarItem alloc] initWithTitle:@"统计" image:UI_IMAGE(@"tabbar_statistics") selectedImage:UI_IMAGE(@"tabbar_statistics") ];
    UIViewController * secondVC = [[UIViewController alloc] init];
    secondVC.tabBarItem = statisticItem;
    
    _tabBarController.viewControllers = @[firstVC,secondVC];
}

@end
