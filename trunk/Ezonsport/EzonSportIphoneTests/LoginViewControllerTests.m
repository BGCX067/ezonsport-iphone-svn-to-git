//
//  LoginViewControllerTests.m
//  EzonSportIphone
//
//  Created by tong chen on 12-7-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LoginViewControllerTests.h"
#import "SystemManageService.h"
#import "LoginViewController.h"
#import "LoginViewModel.h"

@implementation LoginViewControllerTests

@synthesize mockUserNameTextField=_mockUserNameTextField;
@synthesize mockPasswordTextField=_mockPasswordTextField;
@synthesize mockLoginMessageLabel=_mockLoginMessageLabel;
@synthesize mockSystemManageService=_mockSystemManageService;

@synthesize loginViewController=_loginViewController;
@synthesize loginViewModel=_loginViewModel;

-(void)setUp
{
    _mockUserNameTextField=[OCMockObject mockForClass:[UITextField class]];
    _mockPasswordTextField=[OCMockObject mockForClass:[UITextField class]];
    _mockLoginMessageLabel=[OCMockObject mockForClass:[UILabel class]];
    _mockSystemManageService=[OCMockObject mockForClass:[SystemManageService class]];
    
    _loginViewModel=[[LoginViewModel alloc] init];
    _loginViewController=[[LoginViewController alloc] init];
    [_loginViewController setValue:_mockUserNameTextField forKey:@"userNameTextField"];
    [_loginViewController setValue:_mockPasswordTextField forKey:@"passwordTextField"];
    [_loginViewController setValue:_mockLoginMessageLabel forKey:@"loginMessageLabel"];
    [_loginViewController setValue:_mockSystemManageService forKey:@"systemManageService"];
    [_loginViewController setValue:_loginViewModel forKey:@"loginViewModel"];
    
}

-(void)tearDown
{
    
}

//登陆测试：用户名不存在
-(void)testLoginUserNameNotExist
{
    
}
@end
