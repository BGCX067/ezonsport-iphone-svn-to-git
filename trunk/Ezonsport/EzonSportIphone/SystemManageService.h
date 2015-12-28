//
//  SystemManageService.h
//  EzonSportIphone
//
//  Created by apple on 12-7-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <EzonSport/DataContext.h>
#import <EzonSport/OperatorLoginPlist.h>
@interface SystemManageService : NSObject

@property (nonatomic,retain) DataContext *ctx;

//初始化
-(SystemManageService *)init;
-(SystemManageService *)initWithDataContext:(DataContext *)ctx;//测试用
+(SystemManageService *)instance;

//获取托管对象
-(NSManagedObject *)getManagedObjectWithEntityName:(NSString *)entityName;

//存取全局用户信息
+(NSManagedObject *)getCurrentUser;
+(void)setCurrentUser:(NSManagedObject *)user;

//根据用户名获取用户信息
-(NSManagedObject *)queryUserByUserName:(NSString *)userName;

//返回所有用户的用户名
-(NSArray *)getAllUserName;
//用户登陆和注册
-(NSString *)userLogin:(NSString *)userName password:(NSString *)password;
-(NSString *)userRegister:(NSString *)userName pssword:(NSString *)password;

//更新用户信息
-(void) updateUserInfo:(NSManagedObject *)user;

//设置运动目标
-(void) setGoalStep:(int)goalStep;
-(void) setGoalStep:(NSDate *)planDate goalStep:(int)step;

//获取当前运动目标
-(int) getCurrentGoalStep;

-(NSDictionary *)readPlist;
-(void)writePlist:(NSString *)userName with:(NSString *)password;

//-(void)systemApplication;
//
//-(void)showLoginView;
//-(void)showMainView;
//-(void)showRegisterView;
@end
