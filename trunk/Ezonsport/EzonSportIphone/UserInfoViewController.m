//
//  UserInfoViewController.m
//  EzonSportIphone
//
//  Created by apple on 12-7-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UserInfoViewController.h"
#import "UserInfoCellController.h"
#import "UserImgCellController.h"
#import "ImgCellController.h"

@interface UserInfoViewController ()

@end

@implementation UserInfoViewController


@synthesize listData;
@synthesize heightOfUser;
@synthesize  weightOfUser;
@synthesize birthdayOfUser;
@synthesize imageOfUser;
@synthesize nickNameOfUser;
@synthesize systemManageService;
@synthesize userInfoModel;
@synthesize user;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    [self.tableView beginUpdates ];
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    nickNameOfUser = userInfoModel.nickNameOfUser;
    heightOfUser = [NSString stringWithFormat:@"%d",[userInfoModel.heightOfUser integerValue] ];
    weightOfUser = [NSString stringWithFormat:@"%3.1f",[userInfoModel.weightOfUser floatValue] ];
    birthdayOfUser = [dateFormatter stringFromDate:userInfoModel.birthDayOfUser];
    self.listData = [NSArray arrayWithObjects:nickNameOfUser,heightOfUser,weightOfUser,birthdayOfUser, nil];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    systemManageService = [SystemManageService instance];
    userInfoModel = [[UserInfoViewModel alloc]init];
    user = [systemManageService queryUserByUserName:[[SystemManageService getCurrentUser] valueForKey:@"userName"]];
    //装配model
    //userInfoModel.photoOfUser = self.imageOfUser;
    //别名
    userInfoModel.nickNameOfUser = [[NSString alloc] initWithFormat:@"%@",[user valueForKey:@"nickName"]];
    //身高
    NSString * tem = [[NSString alloc] initWithFormat:@"%@",[user valueForKey:@"height"]];
    userInfoModel.heightOfUser = [NSNumber numberWithInteger: [tem integerValue]]; 
    //体重
    NSString * tem2 = [[NSString alloc] initWithFormat:@"%@",[user valueForKey:@"weight"]];
    userInfoModel.weightOfUser = [NSNumber numberWithFloat: [tem2 floatValue]]; 
    //出生日期
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *birthDate = [dateFormatter stringFromDate:[user valueForKey:@"birthDate"]];
    userInfoModel.birthDayOfUser =[dateFormatter dateFromString:birthDate]; 
    nickNameOfUser = userInfoModel.nickNameOfUser;
    heightOfUser = [NSString stringWithFormat:@"%d",[userInfoModel.heightOfUser integerValue] ];
    weightOfUser = [NSString stringWithFormat:@"%3.1f",[userInfoModel.weightOfUser floatValue] ];
    birthdayOfUser = [dateFormatter stringFromDate:userInfoModel.birthDayOfUser];
    NSArray * array = [NSArray arrayWithObjects:nickNameOfUser,heightOfUser,weightOfUser,birthdayOfUser, nil];
    self.listData = array;
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.listData = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 36.0;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 1:
            return 3;
            break;
        case 0:
            return 1;
            break;
        default:
            return 0;
            break;
    }
}
//每个section显示的标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 1:
            return @"用户基本信息";
            break;
        case 0:
            return  @"";
            break;
        default:
            return nil;
            break;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //1
    static NSString *UserInfoCellControllerIdentifier = @"UserInfoCellControllerIdentifier";
    static BOOL nibsRegistered2 = NO;
    if (!nibsRegistered2) {
        UINib *nib = [UINib nibWithNibName:@"UserInfoCellController" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:UserInfoCellControllerIdentifier];
        nibsRegistered2 = YES;
    }
    UserInfoCellController *cell = [tableView dequeueReusableCellWithIdentifier:UserInfoCellControllerIdentifier];
    //2
    static NSString *ImgCellControllerID = @"ImgCellControllerID";
    static BOOL nibsRegistered = NO;
    if (!nibsRegistered) {
        UINib *nib = [UINib nibWithNibName:@"ImgCellController" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:ImgCellControllerID];
        nibsRegistered = YES;
    }
    ImgCellController *imgCell = [tableView dequeueReusableCellWithIdentifier:ImgCellControllerID];
    NSInteger group = [indexPath section];
    NSInteger row = [indexPath row];
   // NSLog(@"group  = %d, row = %d",group,row);
    switch (group) {
        case 1:
            if(row == 0){
                 cell.titleLabel.text = @"身高(CM):";
               
            }else if (row == 1) {
                 cell.titleLabel.text = @"体重(KG):";
            }else if (row == 2) {
                 cell.titleLabel.text = @"生日:";
                UIDatePicker *birth = [[UIDatePicker alloc]init];
                birth.datePickerMode = UIDatePickerModeDate;
                [birth addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
                cell.contentLabel.borderStyle = UITextBorderStyleNone;
                cell.contentLabel.inputView = birth;
            }
            cell.contentLabel.text = [listData objectAtIndex:row + 1 ];
            if(row !=2){
                cell.contentLabel.delegate = self;
                //[cell.contentLabel becomeFirstResponder];
                cell.contentLabel.returnKeyType = UIReturnKeyDone;
            }
            break;
        case 0:
            imgCell.userNameLabel.text = [listData objectAtIndex:row];
            return imgCell;
            break;
        default:
            break;
    }
    return cell;
}
-(void)dateChanged:(id)sender{
    NSDate *date = [sender date];
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *tem = [dateFormatter stringFromDate:date];
    if([tem isEqualToString:birthdayOfUser]){
    }else {
        birthdayOfUser = tem;
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:2 inSection:1];
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        UITextField  *contentLabel=(UITextField *)[cell.contentView viewWithTag:2];
        contentLabel.text = birthdayOfUser;
    }
}
#pragma mark - Table view delegate
//保存当前设置
- (void)viewWillDisappear:(BOOL)animated
{
    int row = 0;
    int section = 1;
    NSIndexPath *indexPath;
    UITableViewCell *cell;
    UITextField  *contentLabel;
    //获取匿名
        indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        cell = [self.tableView cellForRowAtIndexPath:indexPath];
        contentLabel=(UITextField *)[cell.contentView viewWithTag:2];
    nickNameOfUser = contentLabel.text;
    //获取其他的设置
    for (row = 0; row < 3; row ++) {
        indexPath = [NSIndexPath indexPathForRow:row inSection:section];
        cell = [self.tableView cellForRowAtIndexPath:indexPath];
        contentLabel=(UITextField *)[cell.contentView viewWithTag:2];
        switch (row) {
            case 0:
                heightOfUser = [contentLabel text];
                NSLog(@"heightOfuser = %@",heightOfUser);
                break;
            case 1:
                weightOfUser = [contentLabel text];
                break;
            case 2:
                birthdayOfUser = [contentLabel text];
                break;
            default:
                break;
        }
    }
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *tem = [dateFormatter stringFromDate:userInfoModel.birthDayOfUser];
    
    if(!([birthdayOfUser isEqualToString:tem])||([heightOfUser integerValue] != [userInfoModel.heightOfUser integerValue])||([weightOfUser floatValue] != [userInfoModel.weightOfUser floatValue])||!([nickNameOfUser isEqualToString:userInfoModel.nickNameOfUser])){
        //别名
        userInfoModel.nickNameOfUser = nickNameOfUser;
        //身高
        userInfoModel.heightOfUser = [NSNumber numberWithInteger: [heightOfUser integerValue]]; 
        NSLog(@"%@",heightOfUser);
        //体重
        userInfoModel.weightOfUser = [NSNumber numberWithFloat: [weightOfUser floatValue]]; 
        //出生日期
        NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        userInfoModel.birthDayOfUser =[dateFormatter dateFromString:birthdayOfUser]; 
        [user setValue:userInfoModel.nickNameOfUser forKey:@"nickName"];
        [user setValue:userInfoModel.heightOfUser forKey:@"height"];
        [user setValue:userInfoModel.weightOfUser forKey:@"weight"];
        [user setValue:userInfoModel.birthDayOfUser forKey:@"birthDate"];
    }
    [systemManageService updateUserInfo:user ];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[textField resignFirstResponder];
	return YES;
}
-(void)viewDidAppear:(BOOL)animated
{
    [self.tableView endUpdates];
}



@end
