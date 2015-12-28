//
//  WeightController.m
//  EzonSportIphone
//
//  Created by apple on 12-8-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "WeightController.h"
#import "EzonAppDelegate.h"
@interface WeightController ()

@end

@implementation WeightController
@synthesize myPickerData;
@synthesize myPickerView;
@synthesize myPickerData_2;
@synthesize myPickerData_3;

@synthesize registerModel;
@synthesize systemManager;
@synthesize user;
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
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    systemManager = [SystemManageService instance];
    registerModel = [[RegisterViewModel alloc]init];
    
    
    //初始化数据
    NSMutableArray *array = [[NSMutableArray alloc]init];
    for(int i = 20;i<250 ;i++){
        [array addObject:[[NSString alloc] initWithFormat:@"%d",i]];
    }
    NSArray *array2 = [[NSArray alloc] initWithObjects:@".1",@".2",@".3",@".4",@".5",@".6",@".7",@".8",@".9", nil];
    NSArray *array3 = [[NSArray alloc] initWithObjects:@"kg", nil];
    self.myPickerData = array;
    self.myPickerData_2 = array2;
    self.myPickerData_3 = array3;
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




#pragma mark - 
#pragma mark Picker Data Source Methods 

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView { 
    return 3; 
} 

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{ 
    if(component == 0){
        return [myPickerData count];
    }else if(component == 1){
        return [myPickerData_2 count];
    }
    return [myPickerData_3 count];
} 

#pragma mark Picker Delegate Methods 
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row             forComponent:(NSInteger)component { 
    if(component == 0){
        return [myPickerData objectAtIndex:row]; 
    }else if(component == 1){
        return [myPickerData_2 objectAtIndex:row];
    }
    return [myPickerData_3 objectAtIndex:row];
}


- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 37)];
    if(component == 0){
        label.text = [myPickerData objectAtIndex:row];
    }else if(component == 1) {
        label.text = [myPickerData_2 objectAtIndex:row];
    } else {
        label.text =[myPickerData_3 objectAtIndex:row];
    }
    
    label.font =[UIFont boldSystemFontOfSize:24];
    label.textAlignment = UITextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    return label;
}
- (IBAction)commitRegister:(id)sender {
    
    //获取体重计上的数据
    NSInteger row = [myPickerView selectedRowInComponent:0]; 
    NSInteger row_2 = [myPickerView selectedRowInComponent:1];
    //NSInteger row_3 = [myPickerView selectedRowInComponent:2];
    NSString *selected = [myPickerData objectAtIndex:row];
    NSString *selected_2 = [myPickerData_2 objectAtIndex:row_2];
   // NSString *selected_3 = [myPickerData_3 objectAtIndex:row_3];
    NSString *weight =[selected stringByAppendingFormat:selected_2];
    
    
    //收集注册信息
    NSString *userName = [[NSUserDefaults standardUserDefaults]stringForKey:@"userName"];
    NSString *password = [[NSUserDefaults standardUserDefaults]stringForKey:@"userPassWord"]; 
    NSString *sex = [[NSUserDefaults standardUserDefaults]stringForKey:@"sexOfUser"];
    NSString *height = [[NSUserDefaults standardUserDefaults]stringForKey:@"heightOfUser"];
    NSString *birth = [[NSUserDefaults standardUserDefaults]stringForKey:@"birthdayOfUser"];
    
    //将信息存入
    NSMutableDictionary *userInfo=[[NSMutableDictionary alloc]init];
    [userInfo setObject:userName forKey:@"userName"];
    [userInfo setObject:password forKey:@"passWord"];
    [userInfo setObject:sex forKey:@"sex"];
    [userInfo setObject:height forKey:@"height"];
    [userInfo setObject:birth forKey:@"birth"];
    [userInfo setObject:weight forKey:@"weight"];
    //开始写入数据库
    
//    [systemManager userRegister:userName pssword:password];
//     user = [systemManager queryUserByUserName:[[SystemManageService getCurrentUser] valueForKey:@"userName"]];
//    [user setValue:[NSNumber numberWithFloat: [height intValue]] forKey:@"height"];
//    [user setValue:[NSNumber numberWithFloat: [weight floatValue]] forKey:@"weight"];
//    [user setValue:sex forKey:@"gender"];
//    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
//    [dateFormat setDateFormat:@"MM/dd/yyyy"];
//    NSDate *date = [dateFormat dateFromString:birth];
//    [user setValue:date forKey:@"birthDate"];
//    [systemManager updateUserInfo:user ];
    NSString *error=[systemManager userRegister:userInfo];
    
    if(error==nil){
        if([userName isEqualToString:[[SystemManageService getCurrentUser] valueForKey:@"userName"]])
        {
            [self.navigationController popToRootViewControllerAnimated:YES];
            [EzonAppDelegate showMainView];
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"注册成功" message:@"是否切换到新用户？" delegate:self cancelButtonTitle:@"是" otherButtonTitles:@"否", nil];
            [alert show];
            
        }
        
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"注册失败" message:error delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([[alertView title] isEqualToString:@"注册成功"]) {
        if(buttonIndex == 0)
        {
            NSString *userName = [[NSUserDefaults standardUserDefaults]stringForKey:@"userName"];
            NSString *password = [[NSUserDefaults standardUserDefaults]stringForKey:@"userPassWord"]; 
            [systemManager userLogin:userName password:password];
            
            [self.navigationController popToRootViewControllerAnimated:YES];
            [EzonAppDelegate showMainView];
        }
        else {
            [self.navigationController popToRootViewControllerAnimated:YES];
            [EzonAppDelegate showMainView];
        }
    }
}

@end
