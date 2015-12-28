//
//  OperatorLoginPlist.m
//  EzonSportIphone
//
//  Created by tong chen on 12-7-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "OperatorLoginPlist.h"

@implementation OperatorLoginPlist

+(NSDictionary *)readPlist{
    //首先读取login.plist中的数据
    NSArray *storePath=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath=[storePath objectAtIndex:0];
    NSString *plistPath = [documentPath stringByAppendingFormat:@"Login.plist"];
    //NSString *plistPath = [nsd]
    NSDictionary *dictionary=[[NSDictionary alloc]initWithContentsOfFile:plistPath];
    
    //读取登录信息
    //NSDictionary *userInfoDictionary=[dictionary objectForKey:@"LoginedUser"];
    NSLog(@"%@",dictionary);
    return dictionary;
}

+(void)writePlist:(NSString *)userName with:(NSString *)password
{
    NSArray *storePath=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath=[storePath objectAtIndex:0];
    NSString *plistPath = [documentPath stringByAppendingFormat:@"Login.plist"];
    //NSString *plistPath=[[NSBundle mainBundle] pathForResource:@"Login" ofType:@"plist"];
    NSMutableDictionary *dictionary=[[NSMutableDictionary alloc]init];
    NSLog(@"%@\n%@",userName,password);
    [dictionary setObject:userName forKey:@"UserName"];
    [dictionary setObject:password forKey:@"Pwd"];
    NSLog(@"%@\n%@",userName,password);
    [dictionary writeToFile:plistPath atomically:YES];
    NSLog(@"%@",dictionary);
}

@end
