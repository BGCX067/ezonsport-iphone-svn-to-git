//
//  SystemManagementTests.m
//  EzonSportIphone
//
//  Created by tong chen on 12-7-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SystemManagementTests.h"



@implementation SystemManagementTests
-(void)setUp
{
    [super setUp];
    mockDataContext =[OCMockObject mockForClass:[DataContext class]];
    //mockOPeratorLoginPlist = [OCMockObject mockForClass:[OperatorLoginPlist class]];
   // mockSystemManageService=[OCMockObject mockForClass:[SystemManageService class]];
    systemManageService = [[SystemManageService alloc]init];
    dataContext = [DataContext instance];
}
-(void)tearDown
{
    [super tearDown];
}

////////////////////////////测试getCurrentGoalStep
-(void)testGetCurrentGoalStep
{
    NSError *error=nil;
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"user==%@",@"321"];
    NSSortDescriptor *sortDescriptor=[[NSSortDescriptor alloc] initWithKey:@"planDate" ascending:NO];
    NSArray *sortDescriptors=[[NSArray alloc] initWithObjects:sortDescriptor, nil];
    
    NSManagedObject *entity=[systemManageService getManagedObjectWithEntityName:@"SportPlanEntity" ];
    NSNumber *goalStep=[NSNumber numberWithInt:4000];
    [entity setValue:goalStep forKey:@"goalStep"];
    NSArray *sportPlanArray=[[NSArray alloc]initWithObjects:goalStep, nil];
    
    [[[mockDataContext stub]andReturn:sportPlanArray]queryWithEntityName:@"SportPlanEntity" setPredicate:predicate setSortDescriptors:sortDescriptors error:error];
    
    int expect=4000;
    int actual=[systemManageService getCurrentGoalStep];
    
    STAssertEquals(expect, actual,@"actual should equal 4000");
}
////////////////////////////测试queryUserByUserName
//测试queryUserByUserName,用户存在
-(void)testQueryUserByUserNameUserExist
{
    NSString *userName= @"321";
    
    NSError *error=nil;
    NSManagedObject *user=[systemManageService getManagedObjectWithEntityName:@"UserEntity"];
    NSArray *userArray=[[NSArray alloc]initWithObjects:user, nil];
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"userName==%@",userName];
    [[[mockDataContext stub]andReturn:userArray ]queryWithEntityName:@"UserEntity" setPredicate:predicate error:error];
    
    NSManagedObject *actual=[systemManageService queryUserByUserName:@"321"];
    
    STAssertNotNil(actual,@"用户应该存在");
}
//测试queryUserByUserName，用户不存在
-(void)testQueryUserByUserNameUserNotExist
{
    NSString *userName= @"1111";
    
    NSError *error=nil;
    NSManagedObject *user=[systemManageService getManagedObjectWithEntityName:@"UserEntity"];
    NSArray *userArray=[[NSArray alloc]initWithObjects:user, nil];
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"userName==%@",userName];
    [[[mockDataContext stub]andReturn:userArray ]queryWithEntityName:@"UserEntity" setPredicate:predicate error:error];
    
    NSManagedObject *actual=[systemManageService queryUserByUserName:@"1111"];
    
    STAssertNil(actual,@"用户应该不存在");
}
/////////////////////////测试userLogin
//测试登录，成功登录
-(void)testUserLoginWhenUserExistandPasswordRight
{
    NSString *userName=@"321";
    NSString *password=@"321";
    

    NSString *actualError = [systemManageService userLogin:userName password:password];
    
    STAssertNil(actualError,@"the user shoud login successfully!");
}
//测试登录，用户不存在
-(void)testUserLoginWhenUserNotExist
{
    NSString *userName=@"1111";
    NSString *password=@"123";
    

    
    NSString *expectError = @"用户不存在";
    NSString *actualError = [systemManageService userLogin:userName password:password];
    NSLog(@"%@  %@",expectError,actualError);

    STAssertTrue([expectError isEqualToString: actualError],@"the user should be not exist!");
}
//测试登录，用户密码错误
-(void)testUserLoginWhenUserExistandPasswordWrong
{
    NSString *userName=@"321";
    NSString *password=@"111";
    
    NSString *expectError = @"密码错误";
    NSString *actualError = [systemManageService userLogin:userName password:password];
     NSLog(@"%@  %@",expectError,actualError);
     STAssertTrue([expectError isEqualToString:actualError],@"应该提示密码错误");
}
////////////////////////测试userRegister
//测试注册，用户成功注册
-(void)testUserRegisterSucceed
{
    NSString *userName = @"hgjkhg";
    NSString *password = @"111";
    
    Boolean expectResult=YES;
    Boolean acutalResult=[systemManageService userRegister:userName pssword:password];
     STAssertEquals(expectResult, acutalResult,@"the user should register successfully");
}
//测试注册，用户名为空
-(void)testUserRegisterUserNameNULL
{
    NSString *userName = @"";
    NSString *password = @"111";
    
    Boolean expectResult=NO;
    Boolean acutalResult=[systemManageService userRegister:userName pssword:password];
    STAssertEquals(expectResult, acutalResult,@"the user should write userName");
}
//测试注册，用户名已存在
-(void)testUserRegisterUserNameHasBeenUsed
{
    NSString *userName = @"321";
    NSString *password = @"111";

    Boolean expectResult=NO;
    Boolean acutalResult=[systemManageService userRegister:userName pssword:password];
    STAssertEquals(expectResult, acutalResult,@"the userName has been used");
}
//测试注册，用户密码为空
-(void)testUserRegisterPasswordNULL
{
    NSString *userName = @"ghj";
    NSString *password = @"";

    Boolean expectResult=NO;
    Boolean acutalResult=[systemManageService userRegister:userName pssword:password];
    STAssertEquals(expectResult, acutalResult,@"the user should write password");
}
@end

