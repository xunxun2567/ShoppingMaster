//
//  ViewSwitcher.m
//  ShoppingMaster
//
//  Created by Lingkai Kong on 12-6-8.
//  Copyright (c) 2012年 Egibbon Inc. All rights reserved.
//

#import "ViewSwitcher.h"

@implementation ViewSwitcher

@synthesize mainWindow = _mainWindow;

@synthesize viewController = _viewController;
@synthesize favorateViewController = _favorateViewController;
@synthesize settingsViewController = _settingsViewController;
@synthesize itemsViewController = _itemsViewController;

static ViewSwitcher* g_instance;

+(ViewSwitcher*)instance {
    return g_instance;
}

+(void)start:(UIWindow*)mainWindow    {
    g_instance = [[ViewSwitcher alloc]initWithWindow:mainWindow];
}

-(id)initWithWindow:(UIWindow*)mainWindow   { 
    _mainWindow = mainWindow;
    _viewController = [[ViewController alloc]initWithNibName:@"ViewController" bundle:nil];
    _favorateViewController = [[FavorateViewController alloc]initWithNibName:@"FavorateViewController" bundle:nil];
    _settingsViewController = [[SettingsViewController alloc]initWithNibName:@"SettingsViewController" bundle:nil];
    _itemsViewController = [[ItemsViewController alloc]initWithNibName:@"ItemsViewController" bundle:nil];
    
    _mainWindow.rootViewController = _viewController;
    return self;
}

-(void)goToSettings {    
    _mainWindow.rootViewController = _settingsViewController;
}


@end
