//
//  Updater.m
//  ShoppingMaster
//
//  Created by Lingkai Kong on 12-6-8.
//  Copyright (c) 2012年 Egibbon Inc. All rights reserved.
//

#import "Updater.h"

@implementation Updater

@synthesize documentDirectory = _documentDirectory;
@synthesize databaseFilepath = _databaseFilepath;
@synthesize serverAddress = _serverAddress;
@synthesize objectModel = _objectModel;
@synthesize objectContext = _objectContext;

static Updater* g_instance;

+(Updater*)instance {
    if (!g_instance)    {
        NSString* configFile = [[NSBundle mainBundle]pathForResource:@"config" ofType:@"plist"];
        NSMutableDictionary* dict = [NSMutableDictionary dictionaryWithContentsOfFile:configFile];
        
        NSString* serverAddress = [dict objectForKey:@"server_address"];
        NSString* databaseFile = [dict objectForKey:@"database_file"];
        g_instance = [[Updater alloc]initWithServerAddress:serverAddress andLocalDatabaseFile:databaseFile];
    }
    return g_instance;
}

-(id)initWithServerAddress:(NSString*)serverAddress andLocalDatabaseFile:(NSString*)localDatabaseFilename   {
    
    _documentDirectory = [[[NSFileManager defaultManager]URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask]objectAtIndex:0];
    NSLog(@"Document Directory: %@", _documentDirectory);
    
    _databaseFilepath = [_documentDirectory URLByAppendingPathComponent:localDatabaseFilename];
    NSLog(@"Database file at: %@", _databaseFilepath);
    
    _serverAddress = [NSURL URLWithString:serverAddress];
    NSLog(@"Server address:%@", _serverAddress);
    
    _objectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    NSLog(@"Object model constructd.");
    
    NSPersistentStoreCoordinator* coordinator = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:_objectModel];
    NSPersistentStore* store = [coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:_databaseFilepath options:nil error:nil];
    if (!store)   {
        NSLog(@"Critical: cannot init persistence store, check the db file!");
        abort();
    }
    _objectContext = [[NSManagedObjectContext alloc]init];
    [_objectContext setPersistentStoreCoordinator:coordinator];
    NSLog(@"Ojbect context constructed");
    
    g_instance = self;    
    return self;
}


@end
