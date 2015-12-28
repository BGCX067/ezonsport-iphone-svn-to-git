//
//  SettingController.m
//  EzonSportIphone
//
//  Created by apple on 12-7-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SettingController.h"
#import "UserInfoViewController.h"
#import "GoalSettingViewController.h"
@interface SettingController ()

@end

@implementation SettingController
@synthesize lists;
@synthesize controllerList;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        // Custom initialization
        self.hidesBottomBarWhenPushed = YES;
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
    NSArray *array = [NSArray arrayWithObjects:@"用户个人信息设置",@"运动目标设置",nil];
    self.lists = array;
    
    NSMutableArray *controllArray = [[NSMutableArray alloc] init];
    UserInfoViewController *userInfoViewController = [[UserInfoViewController alloc]initWithStyle:UITableViewStylePlain];
    userInfoViewController.title = @"用户信息设置";
    [controllArray addObject:userInfoViewController];
    GoalSettingViewController *goalSettingViewController = [[GoalSettingViewController alloc]initWithStyle:UITableViewStylePlain];
    goalSettingViewController.title = @"运动目标设置";
    [controllArray addObject:goalSettingViewController];
    self.controllerList = controllArray;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.lists = nil;
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *TableSampleIdentifier = @"TableSampleIdentifier"; 
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: 
                             TableSampleIdentifier]; 
    if (cell == nil) { 
        cell = [[UITableViewCell alloc] 
                initWithStyle:UITableViewCellStyleDefault 
                reuseIdentifier:TableSampleIdentifier]; 
    } 
    NSUInteger row = [indexPath row]; 
    NSUInteger group = [indexPath section];
    switch (group) {
        case 0:
            cell.textLabel.text = [lists objectAtIndex:row];
            break;
        case 1:
            cell.textLabel.text = [lists objectAtIndex:row + 1];
        default:
            break;
    }
    //cell.textLabel.text = [lists objectAtIndex:row]; 
	return cell; 
}
//响应事件

//- (NSIndexPath *)tableView:(UITableView *)tableView 
//  willSelectRowAtIndexPath:(NSIndexPath *)indexPath { 
//    NSInteger row = [indexPath row];
//    switch (row) {
//        case 0:
//            NSLog(@"用户个人信息设置");
//            break;
//        case 1:
//            NSLog(@"运动目标设置");
//            break;
//        default:
//            break;
//    }
//    return nil;
//}
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
    
    NSInteger group = [indexPath section];//组
    NSInteger row = [indexPath row];
    UITableViewController *nextController ;
    switch (group) {
        case 0:
            nextController = [self.controllerList objectAtIndex:row]; 
            [self.navigationController pushViewController:nextController animated:YES];
            break;
        case 1:
           nextController = [self.controllerList objectAtIndex:row + 1]; 
            [self.navigationController pushViewController:nextController animated:YES];
            break;
            
        default:
            break;
    }
    
   //NSUInteger row = [indexPath row]; 
//   UIViewController *nextController = [self.controllerList objectAtIndex:row]; 
//   [self.navigationController pushViewController:nextController animated:YES];
    //NSLog(@"%d,%@",row,nextController.title);

}
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    switch (section) {
//        case 0:
//            return @"用户信息设置";
//            break;
//        case 1:
//            return @"运动目标设置";
//        default:
//            return nil;
//            break;
//    }
//}

@end
