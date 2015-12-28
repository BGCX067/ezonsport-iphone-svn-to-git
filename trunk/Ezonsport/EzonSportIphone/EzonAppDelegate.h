//
//  EzonAppDelegate.h
//  EzonSportIphone
//
//  Created by apple on 12-7-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LoginViewController;
@class RegisterViewController;
@class SystemManageService;
@interface EzonAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) IBOutlet UITabBarController *rootController;
@property (strong, nonatomic) LoginViewController * loginViewController;
@property (strong, nonatomic) RegisterViewController *registerViewController;
@property (strong, nonatomic) UINavigationController * navController;
//单例模式
+(UITabBarController *)getRootController;
+(UIWindow *)getWindow;
+(SystemManageService *)instanceOfSystemManageService;
+(LoginViewController *)getLoginViewController;
+(RegisterViewController *)getRegisterViewController;

-(void)systemApplication;

+(void)showLoginView;
+(void)showMainView;
+(void)showRegisterView;
@end
