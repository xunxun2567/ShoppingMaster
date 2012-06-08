//
//  Updater.h
//  ShoppingMaster
//
//  Created by Lingkai Kong on 12-6-8.
//  Copyright (c) 2012年 Egibbon Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface Updater : NSObject

@property (strong, nonatomic, readonly) NSString* configFile;
@property (strong, nonatomic, readonly) NSURL* documentDirectory;
@property (strong, nonatomic, readonly) NSURL* databaseFilepath;
@property (strong, nonatomic, readonly) NSURL* serverAddress;
@property (strong, nonatomic, readonly) NSManagedObjectModel* objectModel;
@property (strong, nonatomic, readonly) NSManagedObjectContext* objectContext;

+(Updater*)instance;

-(void)startUpdate;

@end
