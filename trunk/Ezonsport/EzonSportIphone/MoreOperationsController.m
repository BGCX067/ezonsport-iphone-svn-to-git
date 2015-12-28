//
//  MoreOperationsController.m
//  EzonSportIphone
//
//  Created by apple on 12-7-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MoreOperationsController.h"
#import "MoreOperationsCellController.h"
#import "SettingController.h"
#import "FeedbackController.h"
#import "HelpController.h"
#import "AboutController.h"
#import "AccountManageViewController.h"
#import "ExitAccountController.h"
//#import "RegisterViewController.h"
//#import <EzonSport/SystemManageService.h>

#import "EzonAppDelegate.h"
@interface MoreOperationsController ()

@end

@implementation MoreOperationsController

@synthesize dataList;
@synthesize imageList;
@synthesize controllerList;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //add operations name
    NSArray *array = [[NSArray alloc] initWithObjects:@"设置", @"帐户管理",@"意见反馈",@"帮助",@"关于",@"退出当前帐户",nil];
    self.dataList = array;
    //add operations icon
    NSMutableArray *imageArray = [[NSMutableArray alloc] init];
    NSString *imageUrl1 = [[NSString alloc] initWithString: @"moreitems_setting_icon.png"];
    UIImage *image1 = [UIImage imageNamed:imageUrl1];
    [imageArray addObject: image1]; 
    
    NSString *imageUrl2 = [[NSString alloc] initWithString: @"moreitems_accountmanage_icon.png"];
    UIImage *image2 = [UIImage imageNamed:imageUrl2];
    [imageArray addObject: image2]; 
    
    NSString *imageUrl3 = [[NSString alloc] initWithString: @"moreitems_feedback_icon.png"];
    UIImage *image3 = [UIImage imageNamed:imageUrl3];
    [imageArray addObject: image3]; 
    
    NSString *imageUrl4 = [[NSString alloc] initWithString: @"moreitems_help_icon.png"];
    UIImage *image4 = [UIImage imageNamed:imageUrl4];
    [imageArray addObject: image4]; 
    
    NSString *imageUrl5 = [[NSString alloc] initWithString: @"moreitems_about_icon.png"];
    UIImage *image5 = [UIImage imageNamed:imageUrl5];
    [imageArray addObject: image5]; 
    
    NSString *imageUrl6 = [[NSString alloc] initWithString: @"moreitems_exit_icon.png"];
    UIImage *image6 = [UIImage imageNamed:imageUrl6];
    [imageArray addObject:image6];
    self.imageList = imageArray;
    
    //add view controllers
    NSMutableArray *controllerArray = [[NSMutableArray alloc]init ];
    
    SettingController *settingController = [[SettingController alloc]initWithStyle:UITableViewStylePlain];
    settingController.title = @"设置";
    [controllerArray addObject:settingController];
    
    AccountManageViewController *accountController = [[AccountManageViewController alloc]initWithStyle:UITableViewStylePlain];
    accountController.title = @"帐户管理";
    [controllerArray addObject:accountController];
    
    FeedbackController *feedbackController = [[FeedbackController alloc]initWithNibName:@"FeedbackController" bundle:nil];
    feedbackController.title = @"意见反馈";
    [controllerArray addObject:feedbackController];
    
    HelpController *helpController = [[HelpController alloc]initWithNibName:@"HelpController" bundle:nil];
    helpController.title = @"帮助";
    [controllerArray addObject:helpController];
    
    AboutController *aboutController = [[AboutController alloc]initWithNibName:@"AboutController" bundle:nil];
    aboutController.title = @"关于";
    [controllerArray addObject:aboutController];
    
    ExitAccountController *exitAccountController = [[ExitAccountController alloc]initWithNibName:@"ExitAccountController" bundle:nil];
    exitAccountController.title = @"退出当前帐户";
    [controllerArray addObject:exitAccountController];
    
    
    self.controllerList = controllerArray;

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.dataList = nil;
    self.imageList = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [imageList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MoreOperationsCell";
    
    static BOOL nibsRegistered = NO;
    if (!nibsRegistered) {
        UINib *nib = [UINib nibWithNibName:@"MoreOperationsCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:CellIdentifier];
        nibsRegistered = YES;
    }

    MoreOperationsCellController *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    NSUInteger row = [indexPath row];
    cell.optName = [self.dataList objectAtIndex:row]; 
    cell.image = [self.imageList objectAtIndex:row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; 
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    NSUInteger row = [indexPath row]; 
    //NSUInteger len = [indexPath length];
    if(row == 5)
    {
        UIAlertView * alertView= [[UIAlertView alloc]initWithTitle:nil message:@"确定要注销您的帐号吗？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        [alertView show];
    }
    else {
        UIViewController *nextController = [self.controllerList objectAtIndex:row]; 
        NSLog(@"NAME = %@",[nextController title]);
        [self.navigationController pushViewController:nextController animated:YES];
    }
    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0)
    {
        [EzonAppDelegate showLoginView];
    }
}

@end
