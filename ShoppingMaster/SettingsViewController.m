//
//  SettingsViewController.m
//  ShoppingMaster
//
//  Created by Lingkai Kong on 12-6-6.
//  Copyright (c) 2012年 Egibbon Inc. All rights reserved.
//

#import "SettingsViewController.h"
#import "ViewSwitcher.h"


@interface SettingsViewController ()

@end

@implementation SettingsViewController

@synthesize shopNames;
  
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{       
    NSString *path = [[NSBundle mainBundle] pathForResource:@"config" ofType:@"plist"];
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    shopNames = [dict objectForKey:@"shop_names"] ;
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(IBAction)showMainView:(id)sender
{
    [[ViewSwitcher instance]goToMainView];   
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [shopNames count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSUInteger row=[indexPath row];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    static NSString *simpleTableIdentifier=@"SimpleTableIdentifier";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if(cell==nil){
        cell=[[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier] 
              autorelease];
    }

    NSString *shopName = [shopNames objectAtIndex:row];
    NSString *logoName = [NSString stringWithFormat:@"%@_logo.png", shopName];
    
    cell.textLabel.text= shopName;
    cell.imageView.image=[UIImage imageNamed:logoName];
    
    if([userDefault stringForKey:shopName] == nil){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else if([userDefault boolForKey:shopName]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSUInteger row = [indexPath row];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    if (cell.accessoryType == UITableViewCellAccessoryNone) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;  
        [userDefault setBool:YES forKey:[shopNames objectAtIndex:row]];            
    } else if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
        cell.accessoryType = UITableViewCellAccessoryNone;   
        [userDefault setBool:NO  forKey:[shopNames objectAtIndex:row]]; 
    }
}

-(void)dealloc  {
    [shopNames release];
    [super dealloc];
}

@end
