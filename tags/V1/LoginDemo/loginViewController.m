//
//  loginViewController.m
//  LoginDemo
//
//  Created by apple on 12-7-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "loginViewController.h"
#import "SystemManageService.h"

@interface loginViewController ()

@end

@implementation loginViewController

@synthesize userNameTextField;
@synthesize passwordTextField;
@synthesize resultLabel;


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setUserNameTextField:nil];
    [self setPasswordTextField:nil];
    [self setResultLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

//注册(一对多映射关系测试通过)
- (IBAction)registerClick:(id)sender {
    
    //DataContext *ctx=[[DataContext alloc] initWithCoreDataModelName:@"Login"];
    SystemManageService *service=[[SystemManageService alloc] init];
	
	//定义User实体对象
	NSManagedObject *user=[service getManagedObjectWithEntityName:@"UserEntity"];
	//定义Watch实体对象
	NSManagedObject *watch111=[service getManagedObjectWithEntityName:@"WatchEntity"];
    NSManagedObject *watch222=[service getManagedObjectWithEntityName:@"WatchEntity"];
	
	//为对象实例变量赋值
    [watch111 setValue:[NSNumber numberWithInt:333] forKey:@"watchID"];
    [watch111 setValue:@"ezonsport" forKey:@"watchType"];
    [watch111 setValue:user forKey:@"user"];
    
    [watch222 setValue:[NSNumber numberWithInt:444] forKey:@"watchID"];
    [watch222 setValue:@"ezonsport" forKey:@"watchType"];
    [watch222 setValue:user forKey:@"user"];
	
    NSSet *watchSet=[NSSet setWithObjects:watch111,watch222, nil];
	
	//为对象实例变量赋值
    [user setValue:[userNameTextField text] forKey:@"userName"];
    [user setValue:[passwordTextField text] forKey:@"password"];
    [user setValue:watchSet forKey:@"watchSet"];
    
    BOOL flag=[service addUser:user];
    
    if (flag){
        [resultLabel setText:@"注册成功"];
    } else {
        [resultLabel setText:@"注册失败"];
    }
    
    [service release];
    
}

//登陆
- (IBAction)loginClick:(id)sender {
    
    SystemManageService *service=[[SystemManageService alloc] init];
	
    NSString *error=[service userLogin:[userNameTextField text] password:[passwordTextField text]];
    
    if (error==nil) {
        [resultLabel setText:@"登陆成功"];
    }else {
        [resultLabel setText:error];
        
    }
    
    [service release];

    
    
    
    
}

- (IBAction)deleteClick:(id)sender {
    
    SystemManageService *service=[[SystemManageService alloc] init];
    
    NSArray *watchArray=[service queryAllWatch];
    NSEnumerator *enumerator=[watchArray objectEnumerator];
    
    //NSArray *userArray=[service queryAllUsers];
    //NSEnumerator *enumerator=[userArray objectEnumerator];
    
    id anObject=[enumerator nextObject];
    
    if ([service deleteUser:anObject]) {
        [resultLabel setText:@"删除成功"];
    }else {
        [resultLabel setText:@"删除失败"];
    }
    [service release];
    
    

}

- (void)dealloc {
    [userNameTextField release];
    [passwordTextField release];
    [resultLabel release];
    [super dealloc];
}

@end
