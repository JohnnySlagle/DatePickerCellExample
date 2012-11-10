//
//  JSAppDelegate.m
//  DatePickerCellExample
//
//  Created by Johnny on 11/8/12.
//  Copyright (c) 2012 Johnny Slagle. All rights reserved.
//

#import "JSAppDelegate.h"

#import "JSDateTableViewController.h"


@implementation JSAppDelegate

- (BOOL)application:(UIApplication *)iApplication didFinishLaunchingWithOptions:(NSDictionary *)iLaunchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    JSDateTableViewController *dateTableViewController = [[JSDateTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    
    [self.window setRootViewController:dateTableViewController];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)iApplication {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)iApplication {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)iApplication {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)iApplication {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)iApplication {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
