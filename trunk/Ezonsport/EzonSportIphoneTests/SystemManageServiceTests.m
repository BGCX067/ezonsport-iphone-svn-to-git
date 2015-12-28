//
//  SystemManageServiceTests.m
//  EzonSportIphone
//
//  Created by apple on 12-7-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SystemManageServiceTests.h"
#import "SystemManageService.h"
#import "DataContext.h"

@implementation SystemManageServiceTests

@synthesize systemManageService=_systemManageService;
@synthesize ctx=_ctx;

-(void) setUp
{
    [super setUp];
    _systemManageService=[SystemManageService instance];
    
}

@end
