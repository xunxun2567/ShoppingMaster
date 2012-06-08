//
//  ViewController.m
//  ShoppingMaster
//
//  Created by Lingkai Kong on 12-6-6.
//  Copyright (c) 2012年 Egibbon Inc. All rights reserved.
//

#import "ViewController.h"
#import "Updater.h"
#import "ViewSwitcher.h"
#import "JSONKit.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)showSettingsView:(id) sender 
{
    [[ViewSwitcher instance]goToSettings];

}

static NSString* API_URL = @"http://127.0.0.1:8000/api/?key=timeline&prev_update=201205260000";

-(IBAction)startUpdate:(id)sender   {
    NSLog(@"Starting update.");
    NSURL* url = [NSURL URLWithString:API_URL];
    NSString* responseText = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    //NSLog(@"responseText: %@", responseText);
    NSMutableDictionary* dict = [responseText mutableObjectFromJSONString];
    NSMutableDictionary* content = [dict objectForKey:@"content"];

    NSLog(@"%@", [[content allValues]objectAtIndex:0]); 
    
    [NSEntityDescription insertNewObjectForEntityForName:@"Brand" inManagedObjectContext:[Updater instance].objectContext];
}

@end
