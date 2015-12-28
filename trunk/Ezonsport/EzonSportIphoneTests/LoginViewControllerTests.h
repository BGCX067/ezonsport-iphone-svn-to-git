//
//  LoginViewControllerTests.h
//  EzonSportIphone
//
//  Created by tong chen on 12-7-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import <OCMock/OCMock.h>

@class LoginViewController;
@class LoginViewModel;

@interface LoginViewControllerTests : SenTestCase

@property id mockUserNameTextField;
@property id mockPasswordTextField;
@property id mockLoginMessageLabel;
@property id mockSystemManageService;

@property (nonatomic,retain) LoginViewController *loginViewController;
@property (nonatomic,retain) LoginViewModel *loginViewModel;

@end
