//
//  LoginViewController.m
//  LoginDemo
//
//  Created by apple on 12-7-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//


#import "EzonAppDelegate.h"
#import "LoginViewController.h"
#import <EzonSport/SystemManageService.h>
#import "RegisterViewController.h"
@interface LoginViewController ()

@end

@implementation LoginViewController

@synthesize userNameTextField;
@synthesize passwordTextField;
@synthesize loginMessageLabel;
@synthesize systemManageService=_systemManageService;
@synthesize loginViewModel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _systemManageService=[SystemManageService instance];
        loginViewModel=[[LoginViewModel alloc] init];
        [self setViewModel:loginViewModel];
    }
    return self;
}

-(void)updateView:(ViewModel * )model
{
    LoginViewModel * viewMode=(LoginViewModel *)model;
    [self.userNameTextField setText:viewMode.userName];
    [self.passwordTextField setText:viewMode.password];
    NSLog(@"%@\n%@",viewMode.userName,viewMode.password);
}

-(void)displayError:(NSError *)error
{
    UIAlertView *alterView=[[UIAlertView alloc]initWithTitle:[error domain] message:@"Password is too long long!!!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alterView show];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.passwordTextField.delegate=self;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

//登陆
- (IBAction)loginButton:(id)sender {
    
    //批更新Model
    [self.loginViewModel batchUpdateModelBegin];
    
    self.loginViewModel.userName=[self.userNameTextField text];
    self.loginViewModel.password=[self.passwordTextField text];
    
    [self.loginViewModel batchUpdateModelEnd];
    NSString *error=[_systemManageService userLogin:self.loginViewModel.userName password:self.loginViewModel.password];
    if (error==nil) {
        //登陆成功
//       UITabBarController *tabBarController=[EzonAppDelegate getRootController];
//        UIWindow * window=[EzonAppDelegate getWindow];
//        window.rootViewController=tabBarController;
        [EzonAppDelegate showMainView];
    }
    else {
        UIAlertView* alterView=[[UIAlertView alloc]initWithTitle:@"登录失败" message:error delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alterView show];
        //[self.loginMessageLabel setText:error];
    }
}

//注册
- (IBAction)registerButton:(id)sender {
    [EzonAppDelegate showRegisterView];

}


-(IBAction)hideKeyboard:(id)sender
{
    [self.userNameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}
@end

