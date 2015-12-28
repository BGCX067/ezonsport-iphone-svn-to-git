//
//  RegisterViewController.m
//  EzonSportIphone
//
//  Created by tong chen on 12-7-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//


#import "EzonAppDelegate.h"
#import "RegisterViewController.h"
#import "SexController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController
@synthesize userNameTextFiled;
@synthesize passwordTextField;
@synthesize verifypasswordTextField;
@synthesize registerViewModel=_registerViewModel;
@synthesize systemManageService=_systemManageService;
@synthesize sportDataVisualizeService=_sportDataVisualizeService;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _registerViewModel=[[RegisterViewModel alloc]init];
        _systemManageService=[[SystemManageService alloc]init];
        _sportDataVisualizeService=[SportDataVisualizeService instance];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //初始化运动目标
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    NSDate *collectionTime=[dateFormatter dateFromString:@"2012-7-1 8:30"];
    
    int minuteInterval=180;//3分钟=＝180秒
    int dayInterval=86400;//1天＝＝86400秒
    
    //初始化运动数据（每3分钟一条运动数据）
    for (int i=0; i<=30; i++) {
        for (int j=0; j<=10; j++) {
            //NSLog(@"collection time:%@",collectionTime);
            NSManagedObject *stepData=[_sportDataVisualizeService getManagedObjectWithEntityName:@"StepDataEntity"];
            [stepData setValue:[NSNumber numberWithFloat:rand()%50] forKey:@"calorie"];
            [stepData setValue:[NSNumber numberWithFloat:rand()%100] forKey:@"distance"];
            [stepData setValue:[NSNumber numberWithInt:rand()%200] forKey:@"steps"];
            [stepData setValue:collectionTime forKey:@"collectTime"];
            [stepData setValue:nil forKey:@"watch"];
            [_sportDataVisualizeService addSportData:stepData];
            collectionTime=[collectionTime dateByAddingTimeInterval:minuteInterval];
        }
        collectionTime=[collectionTime dateByAddingTimeInterval:dayInterval];
    }


}

- (void)viewDidUnload
{
    [self setUserNameTextFiled:nil];
    [self setPasswordTextField:nil];
    [self setVerifypasswordTextField:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)verifyRegister:(id)sender {
//    NSString *error;
    self.registerViewModel.userName = self.userNameTextFiled.text;
    self.registerViewModel.password = self.passwordTextField.text;
    self.registerViewModel.verifyPassword = self.verifypasswordTextField.text;
    //NSLog(@"%@\n%@\n%@", self.registerViewModel.userName,self.registerViewModel.password,self.registerViewModel.verifyPassword);
    if([self.registerViewModel.password isEqualToString:self.registerViewModel.verifyPassword]&&
       (self.registerViewModel.userName!=nil&&![self.registerViewModel.userName isEqualToString:@""])&&
       (self.registerViewModel.password!=nil&&![self.registerViewModel.password isEqualToString:@""]&&
        self.registerViewModel.verifyPassword!=nil&&![self.registerViewModel.verifyPassword isEqualToString:@""])){
//        error = [_systemManageService userRegister:self.registerViewModel.userName pssword:self.registerViewModel.password];
//        if (error==nil) {
//            [EzonAppDelegate showMainView];
//        }
//        else{
//            UIAlertView* alterView=[[UIAlertView alloc]initWithTitle:@"注册失败" message:error delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//            [alterView show];
//        }
//            [self.userNameTextFiled setText:nil];
           [[NSUserDefaults standardUserDefaults] setValue:self.registerViewModel.userName forKey:@"userName"];
           [[NSUserDefaults standardUserDefaults] setValue:self.registerViewModel.password forKey:@"userPassWord"];

        SexController *sc = [[SexController alloc]init];
        [self.navigationController pushViewController:sc animated:YES];
    }
    else if(self.registerViewModel.password==nil||[self.registerViewModel.password isEqualToString:@""]||self.registerViewModel.verifyPassword==nil||[self.registerViewModel.verifyPassword isEqualToString:@""])
    {
        UIAlertView* alterView=[[UIAlertView alloc]initWithTitle:@"注册失败" message:@"请将信息填写完整！" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alterView show];
    }
    else {
        UIAlertView* alterView=[[UIAlertView alloc]initWithTitle:@"注册失败" message:@"两次密码输入不一致！" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alterView show];
    }
    [self.passwordTextField setText:nil];
    [self.verifypasswordTextField setText:nil];
}
- (IBAction)cancleRegister:(id)sender {
    [self.userNameTextFiled setText:nil];
    [self.passwordTextField setText:nil];
    [self.verifypasswordTextField setText:nil];
    if ([SystemManageService getCurrentUser]!=nil) {
        [EzonAppDelegate showMainView];
    }
    else {
        [EzonAppDelegate showLoginView];
    }
}
-(IBAction)hideKeyboard:(id)sender
{
    [self.userNameTextFiled resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    [self.verifypasswordTextField resignFirstResponder];
}
@end
