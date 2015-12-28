//
//  SportDataVisualizeServiceTests.m
//  EzonSportIphone
//
//  Created by tong chen on 12-7-31.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SportDataVisualizeServiceTests.h"

@implementation SportDataVisualizeServiceTests

-(void)setUp
{
    [super setUp];
    mockDataContext=[OCMockObject mockForClass:[DataContext class]];
    sportDataVisualizeService=[[SportDataVisualizeService alloc]init];
}

-(void)tearDown
{
    [super tearDown];
}

///////////////////测试getAllDetailSportData
-(void)testGetAllDetailSportData
{
    NSError *error=nil;
    NSArray *detailSportDataArray=[[NSArray alloc]init];
    [[[mockDataContext stub]andReturn:detailSportDataArray]queryAllWithEntityName:@"SportDataEntity" error:error];
    
    NSArray * actual=[sportDataVisualizeService getAllDetailSportData];
    STAssertNotNil(actual,@"should not nil");
}

///////////////////测试getDetailSportDataByDate:toDate:
-(void)testGetgetDetailSportDataByDateToDateWhenFromLessThanTo
{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    
    //获取指定时间段的计步数据
    NSDate *fromDate=[dateFormatter dateFromString:@"2012-7-10"];
    NSDate *toDate=[dateFormatter dateFromString:@"2012-7-20"];

    NSError *error=nil;
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"collectTime > %@ and collectTime < %@",fromDate,toDate];
    NSArray *detailSportDataArray=[[NSArray alloc]init];
    [[[mockDataContext stub]andReturn:detailSportDataArray]queryWithEntityName:@"SportDataEntity" setPredicate:predicate error:error];
    int expectRow=272;
    NSArray *actual=[sportDataVisualizeService getDetailSportDataByDate:fromDate toDate:toDate];
    int actualRow=[actual count];

    STAssertEquals(expectRow,actualRow,@"expectRow should equal actualRow");
}
-(void)testGetDetailSportDataByDateToDateWhenFromGreaterThanTo
{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    
    //获取指定时间段的计步数据
    NSDate *fromDate=[dateFormatter dateFromString:@"2012-7-20"];
    NSDate *toDate=[dateFormatter dateFromString:@"2012-7-10"];
   
    NSError *error=nil;
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"collectTime > %@ and collectTime < %@",fromDate,toDate];
    NSArray *detailSportDataArray=[[NSArray alloc]init];
    [[[mockDataContext stub]andReturn:detailSportDataArray]queryWithEntityName:@"SportDataEntity" setPredicate:predicate error:error];
    int expect=252;
    NSArray *actual=[sportDataVisualizeService getDetailSportDataByDate:fromDate toDate:toDate];
    int actualRow=[actual count];
    STAssertEquals(expect,actualRow,@"expectRow should equal actualRow");
}
-(void)testGetgetDetailSportDataByDateToDateWhenFromEqualTo
{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    
    //获取指定时间段的计步数据
    NSDate *fromDate=[dateFormatter dateFromString:@"2012-7-10"];
    NSDate *toDate=[dateFormatter dateFromString:@"2012-7-10"];
    
    NSError *error=nil;
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"collectTime > %@ and collectTime < %@",fromDate,toDate];
    NSArray *detailSportDataArray=[[NSArray alloc]init];
    [[[mockDataContext stub]andReturn:detailSportDataArray]queryWithEntityName:@"SportDataEntity" setPredicate:predicate error:error];
    
    NSArray *actual=[sportDataVisualizeService getDetailSportDataByDate:fromDate toDate:toDate];
    int expertRow=22;
    int actualRow=[actual count];
    STAssertEquals(expertRow, actualRow,@"expectRow should equal actualRow");
}

///////////////测试getSportDataByDate:toDate:
-(void)testGetSportDataByDatetoDateWhenFormEqualTo
{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    
    //获取指定时间段的计步数据
    NSDate *fromDate=[dateFormatter dateFromString:@"2012-7-10"];
    NSDate *toDate=[dateFormatter dateFromString:@"2012-7-10"];
    
    NSArray * actual= [sportDataVisualizeService getSportDataByDate:fromDate toDate:toDate];
    
    int expectRow=1;
    int actualRow=[actual count];
    STAssertEquals(expectRow, actualRow,@"expectRow should equal actualRow");
}
-(void)testGetSportDataByDatetoDateWhenFormLessThanTo
{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    
    //获取指定时间段的计步数据
    NSDate *fromDate=[dateFormatter dateFromString:@"2012-7-10"];
    NSDate *toDate=[dateFormatter dateFromString:@"2012-7-20"];
    
    NSArray * actual= [sportDataVisualizeService getSportDataByDate:fromDate toDate:toDate];
    
    int expectRow=11;
    int actualRow=[actual count];
    STAssertEquals(expectRow, actualRow,@"expectRow should equal actualRow");
}
-(void)testGetSportDataByDatetoDateWhenFormGreaterThanTo
{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    
    //获取指定时间段的计步数据
    NSDate *fromDate=[dateFormatter dateFromString:@"2012-7-20"];
    NSDate *toDate=[dateFormatter dateFromString:@"2012-7-10"];
    
    NSArray * actual= [sportDataVisualizeService getSportDataByDate:fromDate toDate:toDate];
    
    int expectRow=11;
    int actualRow=[actual count];
    STAssertEquals(expectRow, actualRow,@"expectRow should equal actualRow");
}


//////////////测试getStepByDate
-(void)testGetStepByDate
{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    
    NSDate *todaty = [dateFormatter dateFromString:@"2012-7-20"];
    
    int expect=3300;
    int actual=[sportDataVisualizeService getStepByDate:todaty];
    STAssertEquals(expect, actual,@"expert should equal actual");
}

//////////////测试getGoalStepByDate:(NSDate *)date

-(void)testGetGoalStepByDate
{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    
    NSDate *date = [dateFormatter dateFromString:@"2012-7-20"];
    
    int expectGoalStep=3000;
    int actualGoalStep=[sportDataVisualizeService getGoalStepByDate:date];
    STAssertEquals(expectGoalStep, actualGoalStep,@"expectGoalStep should equal actualGoalStep");
}
@end
