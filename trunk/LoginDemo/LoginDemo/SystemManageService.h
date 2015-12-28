//
//  SystemManageService.h
//  LoginDemo
//
//  Created by apple on 12-7-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataContext.h"
#import "UserEntity.h"

@interface SystemManageService : NSObject
{
    DataContext *ctx;
}

//初始化
-(SystemManageService *)init;

//获取托管对象
-(NSManagedObject *)getManagedObjectWithEntityName:(NSString *)entityName;

//增删改查用户信息
-(BOOL) addUser:(NSManagedObject *)user;
-(BOOL) deleteUser:(NSManagedObject *)user;
-(BOOL) updateUser:(NSManagedObject *)user;

-(NSArray *)queryAllUsers;
-(NSArray *)queryAllWatch;
-(NSManagedObject *)queryUserByUserName:(NSString *)userName;

//用户登陆
-(NSString *)userLogin:(NSString *)userName password:(NSString *)password;


@end
