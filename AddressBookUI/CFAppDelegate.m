//
//  CFAppDelegate.m
//  AddressBookUI
//
//  Created by   颜风 on 14-6-5.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

// !!!: 清除各个类多余的头文件
#import "CFAppDelegate.h"
#import "CFAddressBookViewController.h"
#import "CFAddressBookModel.h"
#import "CFMainViewController.h"

@implementation CFAppDelegate
-(void)dealloc
{
    self.window = nil;
    
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    // 数据模型
    NSString * path;
    path = [NSBundle pathForResource:@"addressBookData" ofType: nil inDirectory:[NSBundle mainBundle].bundlePath];
    CFAddressBookModel * addressBookModel = [[CFAddressBookModel alloc] initWithFile:path];
    
    CFAddressBookViewController * abVC = [[CFAddressBookViewController alloc] init];
    
    CFMainViewController * mainVC = [[CFMainViewController alloc] initWithRootViewController: abVC];
    mainVC.model = addressBookModel;
    mainVC.addressBookVC = abVC;
    [abVC release];
    [addressBookModel release];
    
    self.window.rootViewController = mainVC;
    [mainVC release];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
