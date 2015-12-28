//
//  EzonAppDelegate.m
//  EzonSportIphone
//
//  Created by apple on 12-7-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "EzonAppDelegate.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"
#import <EzonSport/SystemManageService.h>
//全局变量
static UITabBarController *tabBarController;
static UIWindow *windows;
static SystemManageService *systemManageService;
static LoginViewController *lvController;
static RegisterViewController *rvController;
@implementation EzonAppDelegate

@synthesize window = _window;
@synthesize rootController = _rootController;
@synthesize loginViewController=_loginViewController;
@synthesize registerViewController=_registerViewController;
@synthesize navController=_navController;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //初始化
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [[NSBundle mainBundle] loadNibNamed:@"EzonController" owner:self options:nil]; 
    self.loginViewController = [[LoginViewController alloc]initWithNibName:[LoginViewController description] bundle:nil];
    self.registerViewController= [[RegisterViewController alloc]initWithNibName:[RegisterViewController description] bundle:nil];
    self.registerViewController.title=@"注册";
    self.navController=[[UINavigationController alloc]init];
    [self.navController pushViewController:self.registerViewController animated:YES];
    systemManageService=[[SystemManageService alloc] init];
    
    //设置navController为根view
    self.window.rootViewController=self.loginViewController;
    
    //给静态变量赋值
    windows=self.window;
    tabBarController=self.rootController;
    lvController=self.loginViewController;
    rvController=self.registerViewController;
    [self systemApplication];

    [self.window setBackgroundColor:[UIColor grayColor]];
    [self.window makeKeyAndVisible];
  

    return YES;
}

+(UITabBarController *)getRootController
{
    return tabBarController;
}
+(UIWindow *)getWindow
{
    return windows;
}
+(SystemManageService *)instanceOfSystemManageService
{
    return systemManageService;
}
+(LoginViewController *)getLoginViewController
{
    return lvController;
}
+(RegisterViewController *)getRegisterViewController
{
    return rvController;
}
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



-(void)systemApplication
{
    NSDictionary * userInfoDictionary=[systemManageService readPlist];
    NSString * userName=[userInfoDictionary objectForKey:@"UserName"];
    NSString * password=[userInfoDictionary objectForKey:@"Pwd"];
    //如果plist文件为空，则直接进入登录界面
    if([userName isEqualToString:@""]||userName==nil)
    {
        [[self class ]showLoginView];
    }
    //如果plist文件不为空，则用户验证
    else {
        //验证用户信息
        NSString *isPass = [systemManageService userLogin:userName password:password];
        //通过则显示主界面
        if(isPass==nil)
        {
            [[self class]showMainView];
        }
        //未通过则先提示信息错误，再显示登录界面
        else
        {
            //提示登录失败
            UIAlertView *alterView=[[UIAlertView alloc]initWithTitle:@"登录失败" message:@"您的用户名不存在或密码错误！" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alterView show];
            [[self class] showLoginView];
        }
    }
}
+(void)showLoginView
{
    [SystemManageService setCurrentUser:nil];
    [OperatorLoginPlist writePlist:@"" with:@""];
//    LoginViewController * loginViewController=[EzonAppDelegate getLoginViewController];
//
//    UIWindow * window=[EzonAppDelegate getWindow];
    windows.rootViewController=lvController;
}

+(void)showMainView
{
    UITabBarController *tabBarController=[EzonAppDelegate getRootController];
    UIWindow * window=[EzonAppDelegate getWindow];
    window.rootViewController=tabBarController;
    
}

+(void)showRegisterView
{
    //[SystemManageService setCurrentUser:nil];
    windows.rootViewController=rvController.navigationController;
}

@end
