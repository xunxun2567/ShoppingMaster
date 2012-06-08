//
//  ViewSwitcher.h
//  ShoppingMaster
//
//  Created by Lingkai Kong on 12-6-8.
//  Copyright (c) 2012年 Egibbon Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewController.h"
#import "FavorateViewController.h"
#import "SettingsViewController.h"
#import "ItemsViewController.h"

@interface ViewSwitcher : NSObject

+(ViewSwitcher*)instance;

+(void)start:(UIWindow*)mainWindow;
-(id)initWithWindow:(UIWindow*)mainWindow;

@property (strong, nonatomic, readonly) UIWindow* mainWindow;

@property (strong, nonatomic, readonly) ViewController* viewController;
@property (strong, nonatomic, readonly) FavorateViewController* favorateViewController;
@property (strong, nonatomic, readonly) SettingsViewController* settingsViewController;
@property (strong, nonatomic, readonly) ItemsViewController* itemsViewController;

-(void)goToSettings;
-(void)goToMainView;

@end
