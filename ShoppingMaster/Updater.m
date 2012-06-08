//
//  Updater.m
//  ShoppingMaster
//
//  Created by Lingkai Kong on 12-6-8.
//  Copyright (c) 2012年 Egibbon Inc. All rights reserved.
//

#import "Updater.h"
#import "JSONKit.h"
#import "Brand.h"

@implementation Updater

@synthesize configFile = _configFile;
@synthesize documentDirectory = _documentDirectory;
@synthesize databaseFilepath = _databaseFilepath;
@synthesize serverAddress = _serverAddress;
@synthesize objectModel = _objectModel;
@synthesize objectContext = _objectContext;

static Updater* g_instance;

+(Updater*)instance {
    if (!g_instance)    {
        g_instance = [[Updater alloc]init];
    }
    return g_instance;
}

-(id)init   {    
    _configFile = [[[NSBundle mainBundle]pathForResource:@"config" ofType:@"plist"]copy];
    NSMutableDictionary* dict = [NSMutableDictionary dictionaryWithContentsOfFile:_configFile];

    NSString* serverAddress = [dict objectForKey:@"server_address"];
    NSString* databaseFile = [dict objectForKey:@"database_file"];

    _documentDirectory = [[[[NSFileManager defaultManager]URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask]objectAtIndex:0]copy];
    NSLog(@"Document Directory: %@", _documentDirectory);
    
    _databaseFilepath = [[_documentDirectory URLByAppendingPathComponent:databaseFile]copy];
    NSLog(@"Database file at: %@", _databaseFilepath);
    
    _serverAddress = [[NSURL URLWithString:serverAddress]copy];
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
            
    return self;
}

-(NSString*)_makeRequestString   {
    NSDate* lastUpdate = [[NSUserDefaults standardUserDefaults]objectForKey:@"last_update"];

    NSDateFormatter* format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"YMMddHHmm"];
    
    NSString* queryString = @"";
    NSString* requestString = @"";
    if (!lastUpdate)  {
        NSLog(@"last_update not found in config.plist, this seems to be your first run.");
        queryString = [@"init=1" copy];
    }
    else {
        queryString = [NSString stringWithFormat:@"prev_update=%@", [format stringFromDate:lastUpdate]];
    }
    requestString = [NSString stringWithFormat:@"http://%@/api/?key=timeline&%@", _serverAddress, queryString];
    return requestString;
}

-(void)_updateToContext:(NSMutableDictionary*)dict   {
    // TODO: please go do it
    
    //    Brand* brand = (Brand*)[NSEntityDescription insertNewObjectForEntityForName:@"Brand" inManagedObjectContext:_objectContext];
    //    
    //    brand.name = @"some random brand";
    //    
    //    [_objectContext save:nil];    
}

-(void)startUpdate  {
    NSLog(@"Starting update.");
    
    NSString* requestString = [self _makeRequestString];
    NSLog(@"Query string formed as: %@", requestString);

    NSURL* url = [NSURL URLWithString:requestString];
    NSString* responseText = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"response: %@", responseText);
    
    NSMutableDictionary* dict = [responseText mutableObjectFromJSONString];
    NSMutableDictionary* content = [dict objectForKey:@"content"];

    [self _updateToContext:content];
    
    NSDate* today = [NSDate dateWithTimeIntervalSinceNow:0];
    [[NSUserDefaults standardUserDefaults]setObject:today forKey:@"last_update"];
}


@end
