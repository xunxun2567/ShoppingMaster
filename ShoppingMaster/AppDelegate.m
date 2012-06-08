//
//  AppDelegate.m
//  ShoppingMaster
//
//  Created by Lingkai Kong on 12-6-6.
//  Copyright (c) 2012年 Egibbon Inc. All rights reserved.
//

#import "AppDelegate.h"
#import <CoreData/CoreData.h>
#import "ViewSwitcher.h"

#import "Updater.h"
#import "Brand.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    UIWindow* window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    [ViewSwitcher start:window];
    
    Updater* updater = [Updater instance];

    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Brand" inManagedObjectContext:updater.objectContext];
    [request setEntity:entity];

    NSMutableArray *mutableFetchResults = [[updater.objectContext executeFetchRequest:request error:nil] mutableCopy];
        
    NSLog(@"brands: %@", mutableFetchResults);

    [window makeKeyAndVisible];
    return YES;
}

@end
