//
//  ViewController.m
//  ShoppingMaster
//
//  Created by Lingkai Kong on 12-6-6.
//  Copyright (c) 2012年 Egibbon Inc. All rights reserved.
//

#import "ViewController.h"

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
    // TODO: change this later to show up settings view
    UIAlertView *alert=[[UIAlertView alloc]
                        initWithTitle:@"title"   
                        message:@"James Message"  
                        delegate: self      
                        cancelButtonTitle:@"Cancel"                       
                        otherButtonTitles:@"OK",nil];    
    [alert show];
}

@end
