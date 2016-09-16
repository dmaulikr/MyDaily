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
    
    MDMainNavigationViewController * mainNaviVC = [[MDMainNavigationViewController alloc] initWithRootViewController:_tabBarController];
    [mainNaviVC setNavigationBarHidden:YES];
    self.window.rootViewController = mainNaviVC;
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
    UITabBarItem * diaryItem = [[UITabBarItem alloc] initWithTitle:@"日记" image:UI_IMAGE(@"tabbar_calendar") selectedImage:UI_IMAGE(@"tabbar_calendar") ];
    UIViewController * diaryVC = [[UIViewController alloc] init];
    diaryVC.tabBarItem = diaryItem;
    
    UITabBarItem * statisticItem = [[UITabBarItem alloc] initWithTitle:@"统计" image:UI_IMAGE(@"tabbar_statistics") selectedImage:UI_IMAGE(@"tabbar_statistics") ];
    UIViewController * statisticVC = [[UIViewController alloc] init];
    statisticVC.tabBarItem = statisticItem;
    
    UITabBarItem * foundItem = [[UITabBarItem alloc] initWithTitle:@"发现" image:UI_IMAGE(@"tabbar_found") selectedImage:UI_IMAGE(@"tabbar_found") ];
    UIViewController * foundVC = [[UIViewController alloc] init];
    foundVC.tabBarItem = foundItem;
    
    UITabBarItem * myItem = [[UITabBarItem alloc] initWithTitle:@"我的" image:UI_IMAGE(@"tabbar_my") selectedImage:UI_IMAGE(@"tabbar_my") ];
    UIViewController * myVC = [[UIViewController alloc] init];
    myVC.tabBarItem = myItem;
    
    _tabBarController.viewControllers = @[diaryVC,foundVC,statisticVC,myVC];
}

@end
