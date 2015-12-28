//
//  LoginViewModel.m
//  LoginDemo
//
//  Created by apple on 12-7-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LoginViewModel.h"

@implementation LoginViewModel

@synthesize userName;
@synthesize password;

-(void)setUserName:(NSString *)uName
{
    if (![userName  isEqualToString:uName]) {
        userName=[uName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    [self fireModelChanged];
    }
}

-(void)setPassword:(NSString *)pwd
{
    if (![password isEqualToString:pwd]){
//        if ([pwd length]>8) {
//            NSError *error=[[NSError alloc]initWithDomain:@"loginViewModelError" code:11 userInfo:nil];
//            [self fireErrorHappened:error];
//        }
//        else {
            password=pwd;
            [self fireModelChanged];
        //}
    }
}
@end
