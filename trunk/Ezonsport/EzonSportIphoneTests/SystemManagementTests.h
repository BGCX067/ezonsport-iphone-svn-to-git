//
//  SystemManagementTests.h
//  EzonSportIphone
//
//  Created by tong chen on 12-7-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "SystemManageService.h"
#import <OCMock/OCMock.h>
@interface SystemManagementTests : SenTestCase
{
    //id mockOPeratorLoginPlist;
    id mockDataContext;
    //id mockSystemManageService;
    SystemManageService *systemManageService;
    DataContext *dataContext;
}
@end
