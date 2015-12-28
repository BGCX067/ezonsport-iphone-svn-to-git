//
//  SystemManageService.m
//  EzonSportIphone
//
//  Created by apple on 12-7-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SystemManageService.h"
//#import "EzonAppDelegate.h"
static id currentUser;//全局用户信息

@implementation SystemManageService

@synthesize ctx=_ctx;

-(SystemManageService *)init
{
    self=[super init];
    if (self) {
        _ctx=[DataContext instance];
    }
    return self;
    
}

-(SystemManageService *)initWithDataContext:(DataContext *)ctx
{
    self=[super init];
    if (self) {
        _ctx=ctx;
    }
    return self;
}

+(SystemManageService *)instance
{
    static SystemManageService *instance;
    @synchronized(self)
    {
        if (! instance ) {
            instance=[[SystemManageService alloc] init];
        }
    }
    return instance;
}

+(NSManagedObject *)getCurrentUser
{
    return currentUser;
}

+(void)setCurrentUser:(NSManagedObject *)user
{
    currentUser=user;
}

-(NSManagedObject *)getManagedObjectWithEntityName:(NSString *)entityName
{
    return [_ctx getManagedObjectWithEntityName:entityName];
}


-(NSManagedObject *)queryUserByUserName:(NSString *)userName
{
    NSError *error=nil;
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"userName==%@",userName];
    NSArray *userArray=[_ctx queryWithEntityName:@"UserEntity" setPredicate:predicate error:error];
    
    NSLog(@"count:%d",[userArray count]);
    //如果存在该用户，则返回该用户对象，否则返回nil
    if ([userArray count]>0) {
        return [userArray objectAtIndex:0];
    }
    return nil;
}

-(NSArray *)getAllUserName
{
    NSError *error=nil;
   // NSPredicate *predicate=[NSPredicate predicateWithFormat:@"userName==%@",userName];
    NSArray *userArray=[_ctx queryWithEntityName:@"UserEntity" setPredicate:nil error:error];
    
//    int lenOfUserArray=[userArray count];
//    for(int i=0 ; i<lenOfUserArray ; i++)
//    {
//        
//    }
    return userArray;
}

-(NSString *)userLogin:(NSString *)userName password:(NSString *)password
{
   // UIAlertView *alterView;
    NSString *error=nil;
    NSManagedObject *dbUser=[self queryUserByUserName:userName];
    //NSLog(@"%@",dbUser);
    //用户存在
    if (dbUser!=nil) {
        //密码正确
        if ([[dbUser valueForKey:@"password"] isEqualToString:password]) {
            //登陆成功：保存全局用户信息
            [SystemManageService setCurrentUser:dbUser];
            
            //初始化运动目标
            NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
            NSDate *planDate=[dateFormatter dateFromString:@"2012-7-10"];
            int goalStep=1000;
            double timeInterval=86400;
            for (int i=0; i<5; i++) {
                [self setGoalStep:planDate goalStep:goalStep];
                planDate=[planDate dateByAddingTimeInterval:5*timeInterval];
                goalStep=goalStep+200;
            }

            
            [self writePlist:userName with:password];
            //[self showMainView];
        }else {
            error=@"密码错误";
        }
    }else {
        error=@"用户不存在";
    }
//    if (error!=nil) {
//        alterView=[[UIAlertView alloc]initWithTitle:@"登录失败" message:error delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alterView show];
//    }
    
    return error;
}

-(NSString *)userRegister:(NSMutableDictionary *)userInfo{
    
    NSString *userName = [userInfo valueForKey:@"userName"];
    NSString *password = [userInfo valueForKey:@"passWord"];
    NSString *sex = [userInfo valueForKey:@"sex"];
    NSNumber *height = [NSNumber numberWithFloat:[[userInfo valueForKey:@"height"]intValue]];
    NSNumber *weight = [NSNumber numberWithFloat:[[userInfo valueForKey:@"weight"]floatValue]];
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    NSDate *birth = [dateFormatter dateFromString:[userInfo valueForKey:@"birth"]];
    NSString *error = nil;
    
    if([userName isEqualToString:@""]||userName==nil)
    {
        error=@"用户名不能为空";
    }
    else {
        if([password isEqualToString:@""]||password==nil)
        {
            error=@"密码不能为空";
        }
        else {
            NSManagedObject *dbUser=[self queryUserByUserName:userName];
            if(dbUser!=nil)
            {
                error=@"该用户名已被使用";
            }
            else
            {
                NSManagedObject *user=[self getManagedObjectWithEntityName:@"UserEntity"];
                
                [user setValue:userName forKey:@"userName"];
                [user setValue:password forKey:@"password"];
                //代码添加额外的用户信息
                [user setValue:@"犀利哥" forKey:@"nickName"];
                [user setValue:sex forKey:@"gender"];
                [user setValue:@"" forKey:@"image"];
                [user setValue:height forKey:@"height"];
                [user setValue:weight  forKey:@"weight"];
                [user setValue:birth forKey:@"birthDate"];
                @try {
                    [_ctx beginTransaction];
                    [_ctx insertObject:user];
                    [_ctx commit];

                    //注册成功：保存全局用户信息
                    if([SystemManageService getCurrentUser] == nil){
                        [self writePlist:userName with:password];
                        [SystemManageService setCurrentUser:user];
                    }
                    //初始化运动目标
                    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
                    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
                    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
                    NSDate *planDate=[dateFormatter dateFromString:@"2012-7-10"];
                    int goalStep=1000;
                    double timeInterval=86400;
                    for (int i=0; i<5; i++) {
                        [self setGoalStep:planDate goalStep:goalStep];
                        planDate=[planDate dateByAddingTimeInterval:5*timeInterval];
                        goalStep=goalStep+200;
                    }

                }
                @catch (NSException *exception) {
                    [_ctx rollback];
                    error=@"注册失败，请重新尝试！";
                    //result=NO;
                }
                @finally {
                    
                }
            }
        }
    }
//    if(error!=nil)
//    {
//        alterView=[[UIAlertView alloc]initWithTitle:@"注册失败" message:error delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alterView show];
//    }
    return error;

}

-(void)updateUserInfo:(NSManagedObject *)user
{
    @try {
        [_ctx beginTransaction];
        [_ctx updateObject:user];
        [_ctx commit];
    }
    @catch (NSException *exception) {
        [_ctx rollback];
    }
    
}

-(void)setGoalStep:(int)goalStep
{
    //初始化目标对象
    NSManagedObject *sportPlan=[_ctx getManagedObjectWithEntityName:@"SportPlanEntity"];
    [sportPlan setValue:[NSNumber numberWithInt:goalStep] forKey:@"goalStep"];
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    //[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    NSString *dateString=[dateFormatter stringFromDate:[NSDate date]];
    NSDate *planDate=[dateFormatter dateFromString:dateString];
    
    [sportPlan setValue:planDate forKey:@"planDate"];
    [sportPlan setValue:currentUser forKey:@"user"];

    @try {
        [_ctx beginTransaction];
        [_ctx insertObject:sportPlan];
        [_ctx commit];
    }
    @catch (NSException *exception) {
        [_ctx rollback];
    }
}

-(void)setGoalStep:(NSDate *)planDate goalStep:(int)step
{
    //初始化目标对象
    NSManagedObject *sportPlan=[_ctx getManagedObjectWithEntityName:@"SportPlanEntity"];
    [sportPlan setValue:[NSNumber numberWithInt:step] forKey:@"goalStep"];
    [sportPlan setValue:planDate forKey:@"planDate"];
    [sportPlan setValue:currentUser forKey:@"user"];
    
    @try {
        [_ctx beginTransaction];
        [_ctx insertObject:sportPlan];
        [_ctx commit];
    }
    @catch (NSException *exception) {
        [_ctx rollback];
    }

}

-(int) getCurrentGoalStep
{
    NSError *error=nil;
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"user==%@",currentUser];
    NSSortDescriptor *sortDescriptor=[[NSSortDescriptor alloc] initWithKey:@"planDate" ascending:NO];
    NSArray *sortDescriptors=[[NSArray alloc] initWithObjects:sortDescriptor, nil];
    NSArray *sportPlanArray=[_ctx queryWithEntityName:@"SportPlanEntity" setPredicate:predicate setSortDescriptors:sortDescriptors error:error];
    
    int currentGoalStep=[[[sportPlanArray objectAtIndex:0] valueForKey:@"goalStep"] intValue];
    NSDate *latestDate=[[sportPlanArray objectAtIndex:0] valueForKey:@"planDate"];
    for (id sportPlan in sportPlanArray) {
        NSDate *planDate = [sportPlan valueForKey:@"planDate"];
        if ([planDate compare:latestDate] == NSOrderedDescending) {
            latestDate=planDate;
            currentGoalStep=[[sportPlan valueForKey:@"goalStep"] intValue];
        }
    }
    return currentGoalStep;
    
}


-(NSDictionary *)readPlist
{
    return [OperatorLoginPlist readPlist];
}
-(void)writePlist:(NSString *)userName with:(NSString *)password
{
    [OperatorLoginPlist writePlist:userName with:password];
}

//-(void)systemApplication
//{
//    NSDictionary * userInfoDictionary=[self readPlist];
//    NSString * userName=[userInfoDictionary objectForKey:@"UserName"];
//    NSString * password=[userInfoDictionary objectForKey:@"Pwd"];
//    //如果plist文件为空，则直接进入登录界面
//    if([userName isEqualToString:@""]||userName==nil)
//    {
//        [self showLoginView];
//    }
//    //如果plist文件不为空，则用户验证
//    else {
//        //验证用户信息
//        NSString *isPass = [self userLogin:userName password:password];
//        //通过则显示主界面
//        if(isPass==nil)
//        {
//            [self showMainView];
//        }
//        //未通过则先提示信息错误，再显示登录界面
//        else
//        {
//            //提示登录失败
//            UIAlertView *alterView=[[UIAlertView alloc]initWithTitle:@"登录失败" message:@"您的用户名不存在或密码错误！" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//            [alterView show];
//            [self showLoginView];
//        }
//    }
//}
//-(void)showLoginView
//{
//    [SystemManageService setCurrentUser:nil];
//    [OperatorLoginPlist writePlist:@"" with:@""];
//    LoginViewController * loginViewController=[EzonAppDelegate getLoginViewController];
//
//    UIWindow * window=[EzonAppDelegate getWindow];
//    window.rootViewController=loginViewController.navigationController;
//}
//
//-(void)showMainView
//{
//    UITabBarController *tabBarController=[EzonAppDelegate getRootController];
//    UIWindow * window=[EzonAppDelegate getWindow];
//    window.rootViewController=tabBarController;
//    
//}
//
//-(void)showRegisterView
//{
//    //[SystemManageService setCurrentUser:nil];
//    RegisterViewController * registerViewController=[[RegisterViewController alloc]init];
//    UIWindow *window=[EzonAppDelegate getWindow];
//    window.rootViewController=registerViewController;
//}
@end
