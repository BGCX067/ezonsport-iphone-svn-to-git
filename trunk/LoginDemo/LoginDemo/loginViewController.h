//
//  loginViewController.h
//  LoginDemo
//
//  Created by apple on 12-7-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface loginViewController : UIViewController
{
    UITextField *userNameTextField;//用户名
	UITextField *passwordTextField;//密码
	
	UILabel *resultLabel;//登录或注册结果
	
}
@property (retain, nonatomic) IBOutlet UITextField *userNameTextField;
@property (retain, nonatomic) IBOutlet UITextField *passwordTextField;
@property (retain, nonatomic) IBOutlet UILabel *resultLabel;


- (IBAction)registerClick:(id)sender;

- (IBAction)loginClick:(id)sender;

- (IBAction)deleteClick:(id)sender;

@end
