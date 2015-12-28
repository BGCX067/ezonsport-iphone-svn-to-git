//
//  SystemManageServiceTests.h
//  EzonSportIphone
//
//  Created by apple on 12-7-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>

@class SystemManageService;
@class DataContext;

@interface SystemManageServiceTests : SenTestCase

@property (nonatomic,retain) SystemManageService *systemManageService;
@property (nonatomic,retain) DataContext *ctx;

@end
