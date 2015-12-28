//
//  EzonSportIphoneTests.m
//  EzonSportIphoneTests
//
//  Created by tong chen on 12-7-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "EzonSportIphoneTests.h"


@implementation EzonSportIphoneTests
//@synthesize mockDataContext=_mockDataContext;
//@synthesize mockOPeratorLoginPlist=_mockOPeratorLoginPlist;
- (void)setUp
{
    [super setUp];
//    _mockOPeratorLoginPlist=[OCMockObject mockForClass:[OperatorLoginPlist class]];
//    _mockDataContext = [OCMockObject mockForClass:[DataContext class]];
    // Set-up code here.
    mockSystemManageService=[OCMockObject mockForClass:[SystemManageService class]];
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}
/*
- (void)testExample
{
    STFail(@"Unit tests are not implemented yet in EzonSportIphoneTests");
}
*/

//
//- (void)testOCMockPass
//
//{
//    
//    id mock = [OCMockObject mockForClass:[NSString class]];
//    
//    [[[mock stub] andReturn:@"mocktest"] lowercaseString];
//    
//    
//    
//    NSString *returnValue = [mock lowercaseString];
//
//    
//    STAssertEqualObjects(@"mocktest", returnValue, 
//                         
//                         @"Should have returned the expected string.");
//    
//    
//}
//
//- (void)testOCMockFail
//
//{
//    
//    id mock = [OCMockObject mockForClass:NSString.class];
//    
//    [[[mock stub] andReturn:@"mocktest"] lowercaseString];
//    
//    NSString *returnValue = [mock lowercaseString];
//    
//    STAssertEqualObjects(@"mocktest", 
//                         
//                         returnValue, @"Should have returned the expected string.");
//    
//}
//
@end
