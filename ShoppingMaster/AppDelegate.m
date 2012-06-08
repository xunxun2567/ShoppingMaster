//
//  AppDelegate.m
//  ShoppingMaster
//
//  Created by Lingkai Kong on 12-6-6.
//  Copyright (c) 2012年 Egibbon Inc. All rights reserved.
//

#import "AppDelegate.h"
#import <CoreData/CoreData.h>
#import "ViewController.h"
#import "Updater.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // Override point for customization after application launch.
    self.viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
