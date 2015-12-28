//
//  SportDataVisualizeService.m
//  EzonSportIphone
//
//  Created by apple on 12-7-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SportDataVisualizeService.h"

@implementation SportDataVisualizeService

@synthesize ctx=_ctx;

-(SportDataVisualizeService *)init
{
    self=[super init];
    if (self) {
        _ctx=[DataContext instance];
    }
    return self;
    
}

+(SportDataVisualizeService *)instance
{
    static SportDataVisualizeService *instance;
    @synchronized(self)
    {
        if (! instance ) {
            instance=[[SportDataVisualizeService alloc] init];
        }
    }
    return instance;
}

-(NSManagedObject *)getManagedObjectWithEntityName:(NSString *)entityName
{
    return [_ctx getManagedObjectWithEntityName:entityName];
}

-(NSArray *) getAllSportData
{
    //NSArray *detailSportDataArray=[self getAllDetailSportData];//详细运动记录
    //NSMutableArray *sportDataArray=[[NSMutableArray alloc] init];//统计每天的运动记录
    return nil;
}

-(NSArray *) getAllDetailSportData
{
    NSError *error=nil;
    NSArray *detailSportDataArray=[_ctx queryAllWithEntityName:@"SportDataEntity" error:error];
    return detailSportDataArray;
}

-(NSArray *) getDetailSportDataByDate:(NSDate *)from toDate:(NSDate *)to
{
    NSError *error=nil;
    NSPredicate *predicate=nil;
    int dayInterval=24*60*60;//一天＝24*60*60秒，即每天的间隔时间 

    //如果from <= to
    if ([from compare:to] != NSOrderedDescending) {
        to=[to dateByAddingTimeInterval:dayInterval];
        predicate=[NSPredicate predicateWithFormat:@"collectTime > %@ and collectTime < %@",from,to];
    }else {
        //如果from > to
        from=[from dateByAddingTimeInterval:dayInterval];
        predicate=[NSPredicate predicateWithFormat:@"collectTime > %@ and collectTime < %@",to,from];
    }    
    NSArray *detailSportDataArray=[_ctx queryWithEntityName:@"SportDataEntity" setPredicate:predicate error:error];
    //NSLog(@"detail sport data count:%d",[detailSportDataArray count]);
    //NSLog(@"%@",detailSportDataArray);
    return detailSportDataArray;
}

-(NSArray *) getSportDataByDate:(NSDate *)from toDate:(NSDate *)to
{
    NSMutableArray *sportDataArray=[[NSMutableArray alloc] init];//统计每天的运动记录
    int dayInterval=86400;//一天＝86400秒，即每天的间隔时间 
    
    if ([from compare:to] == NSOrderedAscending) {
        NSDate *temp=from;
        from=to;
        to=temp;
    }
    
    for (NSDate *tempDate=from; [tempDate compare:to] != NSOrderedAscending; ) {
        
        //NSDate *tempDateAfter=[tempDate dateByAddingTimeInterval:dayInterval];
        NSArray *detailSportDataArray=[self getDetailSportDataByDate:tempDate toDate:tempDate];//每天的详细运动记录
        NSManagedObject *sportData=[self getManagedObjectWithEntityName:@"StepDataEntity"];
        
        float calorie=0;
        float distance=0;
        int steps=0;
        
        //统计每天的卡路里，运动距离和运动步数
        for (id detailSportData in detailSportDataArray) {
            calorie=calorie+[[detailSportData valueForKey:@"calorie"] intValue];
            distance=distance+[[detailSportData valueForKey:@"distance"] intValue];
            steps=steps+[[detailSportData valueForKey:@"steps"] intValue];
        }
        
        [sportData setValue:tempDate forKey:@"collectTime"];
        [sportData setValue:[NSNumber numberWithFloat:calorie] forKey:@"calorie"];
        [sportData setValue:[NSNumber numberWithFloat:distance] forKey:@"distance"];
        [sportData setValue:[NSNumber numberWithFloat:steps] forKey:@"steps"];
        
        tempDate=[tempDate dateByAddingTimeInterval:-dayInterval];
        [sportDataArray addObject:sportData];
    }

    return sportDataArray;
}


-(int)getStepByDate:(NSDate *)date
{
    NSDate *today=date;
    NSDate *tomorrow=[date dateByAddingTimeInterval:86400];
    NSArray *stepArray=[self getDetailSportDataByDate:today toDate:tomorrow];
    
    int sumStepofDay=0;
    for (id stepData in stepArray) {
        NSNumber *steps=[stepData valueForKey:@"steps"];
        sumStepofDay=sumStepofDay+[steps intValue];
    }
    return sumStepofDay;
    
}
-(int)getGoalStepByDate:(NSDate *)date
{
    NSError *error=nil;
    NSArray *sportPlanArray=[_ctx queryAllWithEntityName:@"SportPlanEntity" error:error];
    int goalStep=0;
    int planCount=[sportPlanArray count];

    //如果在第一次设定目标之前有运动，则运动目标为默认目标
    if ([date compare:[[sportPlanArray objectAtIndex:0] valueForKey:@"planDate"]] == NSOrderedAscending) {
        
        goalStep=2000;//设定运动目标之前的默认目标是2000
        
    }else if ([date compare:[[sportPlanArray objectAtIndex:planCount-1] valueForKey:@"planDate"]] != NSOrderedAscending) {
        
        goalStep=[[[sportPlanArray objectAtIndex:planCount-1] valueForKey:@"goalStep"] intValue];
        
    }else {
        for (int i=0; i<planCount-1; i++) {
            NSDate *planDateBefore = [[sportPlanArray objectAtIndex:i] valueForKey:@"planDate"];
            NSDate *planDateAfter = [[sportPlanArray objectAtIndex:i+1] valueForKey:@"planDate"];
            if ([date compare: planDateBefore] != NSOrderedAscending && [date compare:planDateAfter] == NSOrderedAscending)
            {
                goalStep=[[[sportPlanArray objectAtIndex:i] valueForKey:@"goalStep"] intValue];
            }
        }

    }
    return goalStep;
    
            
}

-(void) addSportData:(NSManagedObject *)sportData
{
    @try {
        [_ctx beginTransaction];
        [_ctx insertObject:sportData];
        [_ctx commit];
    }
    @catch (NSException *exception) {
        [_ctx rollback];
    }

}


@end
