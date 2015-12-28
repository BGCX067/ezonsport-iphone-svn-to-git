//
//  SystemManageService.m
//  LoginDemo
//
//  Created by apple on 12-7-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SystemManageService.h"

@implementation SystemManageService

-(SystemManageService*)init
{
    self=[super init];
    if (self) {
        ctx=[[DataContext alloc] initWithCoreDataModelName:@"Login"];
    }
    return self;
    
}

-(NSManagedObject *)getManagedObjectWithEntityName:(NSString *)entityName
{
    return [ctx getManagedObjectWithEntityName:entityName];
}

-(BOOL)addUser:(NSManagedObject *)user
{
    BOOL result;
    @try {
        [ctx beginTransaction];
        [ctx add:user];
        [ctx commit];
        result=YES;
    }
    @catch (NSException *exception) {
        [ctx rollback];
        result=NO;
        NSLog(@"add user failure: %@",[exception reason]);
    }
    @finally {
        return result;
    }
    
}

-(BOOL)deleteUser:(NSManagedObject *)user
{
    BOOL result;
    @try {
        [ctx beginTransaction];
        [ctx delete:user];
        [ctx commit];
        result=YES;
    }
    @catch (NSException *exception) {
        [ctx rollback];
        result=NO;
        NSLog(@"delete user failure: %@",[exception reason]);
    }
    @finally {
        return result;
    }

}

-(BOOL)updateUser:(NSManagedObject *)user
{
    BOOL result;
    @try {
        [ctx beginTransaction];
        [ctx update:user];
        [ctx commit];
        result=YES;
    }
    @catch (NSException *exception) {
        [ctx rollback];
        result=NO;
        NSLog(@"update user failure: %@",[exception reason]);
    }
    @finally {
        return result;
    }

}

-(NSManagedObject *)queryUserByUserName:(NSString *)userName
{
    NSError *error=nil;
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"userName==%@",userName];
    NSArray *userArray=[ctx queryWithEntityName:@"UserEntity" setPredicate:predicate error:error];
    
    NSLog(@"userArray count:%d",[userArray count]);
    
    //如果存在该用户，则返回该用户对象，否则返回nil
    if ([userArray count]>0) {
        return [userArray objectAtIndex:0];
        
    }
    return nil;
}

-(NSArray *)queryAllUsers
{
    NSError *error=nil;
    return [ctx queryAllWithEntityName:@"UserEntity" error:error];
}

-(NSArray *)queryAllWatch
{
    NSError *error=nil;
    return [ctx queryAllWithEntityName:@"WatchEntity" error:error];

}

-(NSString *)userLogin:(NSString *)userName password:(NSString *)password
{
    NSString *error=nil;
    NSManagedObject *dbUser=[self queryUserByUserName:userName];
    //用户存在
    if (dbUser!=nil) {
        //密码正确
        if ([[dbUser valueForKey:@"password"] isEqualToString:password]) {
            //登陆之后的操作
            NSLog(@"login successfully");
        }else {
            error=@"密码错误";
        }
    }else {
        error=@"用户不存在";
    }
    return error;
}


@end
