//
//  GoalSettingViewController.m
//  EzonSportIphone
//
//  Created by apple on 12-7-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GoalSettingViewController.h"
#import "ContentCellController.h"
#import "TitleCellController.h"
#import "EzonAppDelegate.h"
@interface GoalSettingViewController ()

@end

@implementation GoalSettingViewController

@synthesize listsData;
@synthesize currentGoal;
@synthesize systemManageService;
@synthesize listsSelectedImage;
@synthesize saveButton;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    NSLog(@"apper:");
    lastestGoal=[systemManageService getCurrentGoalStep];
    currentGoal = [NSString stringWithFormat: @"%d", lastestGoal];
    [self.tableView reloadData];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
     self.systemManageService = [SystemManageService instance];
   
    NSArray *lists = [NSArray arrayWithObjects:@"2000",@"3000",@"5000",@"7500",@"用户自定义" ,nil];
    self.listsData = lists;
    lastestGoal=[systemManageService getCurrentGoalStep];
    NSString *current = [NSString stringWithFormat: @"%d", lastestGoal];
    self.currentGoal = current; 
    
    //自定显示的选择图片
    listsSelectedImage = [NSArray arrayWithObjects:[UIImage imageNamed:@"goalsetting_choose_normal.png"],[UIImage imageNamed:@"goalsetting_choose.png"],nil];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
   // self.listsGoal = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
#pragma mark Table Delegate Methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = [indexPath row];
    if(row == 0){
        return 145;
    }
    return 40.0;
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
    return [listsData count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *ContentCellControllerIdentifier = @"ContentCellControllerIdentifier";
    
    static BOOL nibsRegistered = NO;
    if (!nibsRegistered) {
        UINib *nib = [UINib nibWithNibName:@"ContentCellController" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:ContentCellControllerIdentifier];
        nibsRegistered = YES;
    }    
    ContentCellController *contentCell = [tableView dequeueReusableCellWithIdentifier:ContentCellControllerIdentifier];
    
    
    static NSString *TitleCellControllerIdentifier = @"TitleCellControllerIdentifier";
      static BOOL nibsRegistered2 = NO;
    if (!nibsRegistered2) {
        UINib *nib = [UINib nibWithNibName:@"TitleCellController" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:TitleCellControllerIdentifier];
        nibsRegistered2 = YES;
    }    
    TitleCellController *titleCell = [tableView dequeueReusableCellWithIdentifier:TitleCellControllerIdentifier];
    
    NSInteger row = [indexPath row];
    if (row == 0) {
        titleCell.goalLabel.text = currentGoal;
        titleCell.backgroundColor = [UIColor redColor];
        return titleCell;
    }else{
        if(row !=5){
            contentCell.commonGoalsLabel.text = [[listsData objectAtIndex:row -1] stringByAppendingFormat:@"步/天"];
        }else {
            contentCell.commonGoalsLabel.text = [listsData objectAtIndex:row -1];
        }
        if(lastestGoal == [[listsData objectAtIndex:row -1] intValue]){
            contentCell.commonSelectedImage.image = [listsSelectedImage objectAtIndex:1];
        }
        contentCell.selectionStyle=UITableViewCellSelectionStyleNone;
        return contentCell;
    }
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
    NSInteger row = [indexPath row];
    NSInteger goal = 0;
    switch (row) {
        case 1:
            goal = 2000;
            break;
        case 2:
            goal = 3000;
            break;
        case 3:
            goal = 5000;
            break;
        case 4:
            goal = 7500;
            break;
        case 5:
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"输入自定义的目标步数：" message:@"\n" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消",nil];
            textField = [[UITextField alloc]initWithFrame:CGRectMake(12.0, 45.0, 250.0, 30.0)];
            textField.borderStyle = UITextBorderStyleRoundedRect;
            [alert addSubview:textField];
            [alert show];
        }
            break;
        default: 
            break;
    }
    lastestGoal = goal;
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    self.saveButton=(UIButton *)[cell.contentView viewWithTag:3];
    //NSLog(@"name = %@",[saveButton.titleLabel text]);
    [self.saveButton addTarget:self action:@selector(saveGoalButton) forControlEvents:UIControlEventTouchUpInside];
    
   // cell.commonSelectedImage.image = [listsData objectAtIndex:1];
    
}
//set currentGoal
- (void)alertView:(UIAlertView *)alert clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        if (textField.text == nil || [textField.text isEqualToString:@""]) {
            
        }else {
            self.currentGoal= textField.text;
            lastestGoal = [currentGoal intValue];
            [self.systemManageService setGoalStep:lastestGoal];
            currentGoal = [NSString stringWithFormat: @"%d", lastestGoal];
            [self.tableView reloadData];

        }
    }
}

//设置最新运动目标
-(void)saveGoalButton
{
    NSLog(@"lastGoal =%d",lastestGoal);
    [systemManageService setGoalStep:lastestGoal];
    currentGoal = [NSString stringWithFormat: @"%d", lastestGoal];
    [self.tableView reloadData];

}

@end
