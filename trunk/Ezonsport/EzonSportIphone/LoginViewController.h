//
//  LoginViewController.h
//  LoginDemo
//
//  Created by apple on 12-7-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SystemManageService;
#import "LoginViewModel.h"
#import "ViewController.h"

@interface LoginViewController : ViewController<UITextFieldDelegate>


@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;//用户名
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;//密码
@property (weak, nonatomic) IBOutlet UILabel *loginMessageLabel;//登陆提示信息

//service
@property (strong,nonatomic) SystemManageService *systemManageService;
@property (strong,nonatomic) LoginViewModel *loginViewModel;

//登陆
- (IBAction)loginButton:(id)sender;

//注册
- (IBAction)registerButton:(id)sender;

//
-(IBAction)hideKeyboard:(id)sender;
//重写父类的更新view方法
-(void)updateView:(ViewModel * )model;

//重写父类的显示错误信息方法
-(void)displayError:(NSError *)error;
@end
