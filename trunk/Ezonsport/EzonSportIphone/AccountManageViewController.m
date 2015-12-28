//
//  AccountManageViewController.m
//  EzonSportIphone
//
//  Created by apple on 12-7-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AccountManageViewController.h"
#import "AddNewUserCell.h"
#import "ExistedUserCell.h"
#import "EzonAppDelegate.h"
@interface AccountManageViewController ()

@end

@implementation AccountManageViewController
@synthesize userArray;
@synthesize systemManageSerivce;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        // Custom initialization
        self.hidesBottomBarWhenPushed = YES;
        self.systemManageSerivce=[[SystemManageService alloc]init];
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
    //NSArray * array = [NSArray arrayWithObjects:nil];
    //self.userArray = array;
    self.userArray = [systemManageSerivce getAllUserName];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.userArray = nil;
}

-(void)viewWillAppear:(BOOL)animated
{
    self.userArray = [systemManageSerivce getAllUserName];
    [[self tableView] reloadData];
    NSLog(@"%@",[[SystemManageService getCurrentUser]valueForKey:@"userName"]);
    [super viewWillAppear:animated];
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
    return [userArray count]+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = [indexPath row];
    NSLog(@"%d",row);
    NSLog(@"%d",[userArray count]);
    if (row == [userArray count]) {
        //1
        static NSString *AddNewUserCellID = @"AddNewUserCellID";
        
        static BOOL nibsRegistered = NO;
        if (!nibsRegistered) {
            UINib *nib = [UINib nibWithNibName:@"AddNewUserCell" bundle:nil];
            [tableView registerNib:nib forCellReuseIdentifier:AddNewUserCellID];
            nibsRegistered = YES;
        }
        AddNewUserCell *addCell = [tableView dequeueReusableCellWithIdentifier:AddNewUserCellID];    
        // Configure the cell...
        return addCell;
    }
        
    
    //2
    else {
        static NSString *ExistedUserCellID = @"ExistedUserCellID";
        
        static BOOL nibsRegistered2 = NO;
        if (!nibsRegistered2) {
            UINib *nib = [UINib nibWithNibName:@"ExistedUserCell" bundle:nil];
            [tableView registerNib:nib forCellReuseIdentifier:ExistedUserCellID];
            nibsRegistered2 = YES;
        }
        ExistedUserCell *existedCell = [tableView dequeueReusableCellWithIdentifier:ExistedUserCellID]; 
        existedCell.userName=[[userArray objectAtIndex:row] valueForKey:@"userName"];
        if ([existedCell.userName isEqualToString:[[SystemManageService getCurrentUser]valueForKey:@"userName"]]) {
            existedCell.image=[UIImage imageNamed:@"accountmanage_user_status.png"];
        }
        else {
            existedCell.image=[UIImage imageNamed:@"accountmanage_user_status_gray.png"];
        }
        
        return existedCell;
    }
//        if (row < [userArray count]) {
//        
//    }
//    
    
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
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 33.0;
}
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
    int count = [userArray count];
    if([indexPath row] ==count)
    {
        [EzonAppDelegate showRegisterView];
//        self.userArray = [systemManageSerivce getAllUserName];
//
//        int count2 = [userArray count];
//        if((count + 1) == count2)
//        {
//            UIAlertView * alertView= [[UIAlertView alloc]initWithTitle:nil message:@"使用新帐号登陆吗？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
//            [alertView show];
//
//        }
//        RegisterViewController *registerViewController=[EzonAppDelegate getRegisterViewController];
//        [self.navigationController pushViewController:(UIViewController *)registerViewController animated:YES];
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0)
    {
       // [EzonAppDelegate showLoginView];
    }
}

@end
