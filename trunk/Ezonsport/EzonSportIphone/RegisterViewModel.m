//
//  RegisterViewModel.m
//  EzonSportIphone
//
//  Created by tong chen on 12-7-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "RegisterViewModel.h"

@implementation RegisterViewModel
@synthesize userName;
@synthesize password;
@synthesize verifyPassword;

-(void)setUserName:(NSString *)uName
{
    userName=[uName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

@end
