//
//  DataViewController.m
//  EzonSportIphone
//
//  Created by apple on 12-7-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//





#import "DataViewController.h"
#import "DataViewDraw.h"
#import "SportDataViewModel.h"
#import "SportDataVisualizeService.h"
#import "GroupSportData.h"

@interface DataViewController ()

@end

@implementation DataViewController
@synthesize dataDetailViewController;
@synthesize drawView;
@synthesize curDate;
@synthesize theDayBeforeDate;
@synthesize the3DayBeforeDate;
@synthesize swipeLeftRecognizer;
@synthesize swipeRightRecognizer;
@synthesize tapRecognizer;

@synthesize sportDataViewModel=_sportDataViewModel;
@synthesize sportDataVisualizeService=_sportDataVisualizeService;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.dataDetailViewController.delegate = self;
    //初始化model和service
    _sportDataViewModel=[[SportDataViewModel alloc] init];
    _sportDataVisualizeService=[SportDataVisualizeService instance];
    
    NSTimeInterval twoDaysInterval = 2 * 24 * 60 * 60;
    NSDate *currentDate=[self transformGeneralDateToFormattingDate:[NSDate date] setFormat:@"yyyy-MM-dd"];
    NSDate *theDayBeforeYesterday = [currentDate dateByAddingTimeInterval:-twoDaysInterval];
    
    _sportDataViewModel.sportDataArray=[self getSportDataByDate:currentDate toDate:theDayBeforeYesterday];
    _sportDataViewModel.location=0;

    
    [self.view addGestureRecognizer:swipeLeftRecognizer];
    [self.view addGestureRecognizer:swipeRightRecognizer];
    [self.view addGestureRecognizer:tapRecognizer];
    drawView = (DataViewDraw *)self.view;
    [self updateView];
    //[self previousPage];
    [self nextPage];
}

//显示最近3天的运动记录
-(void)updateView
{
    int index=_sportDataViewModel.location;
    //步数
    [drawView setStep1:[[[_sportDataViewModel.sportDataArray objectAtIndex:index] valueForKey:@"step"] intValue]];
    [drawView setStep2:[[[_sportDataViewModel.sportDataArray objectAtIndex:index+1] valueForKey:@"step"] intValue]];
    [drawView setStep3:[[[_sportDataViewModel.sportDataArray objectAtIndex:index+2] valueForKey:@"step"] intValue]];
    
    //日期
    drawView.date1=[self transformDateToString:[[_sportDataViewModel.sportDataArray objectAtIndex:index] valueForKey:@"collectionTime"] setFormat:@"yyyy-MM-dd"];
    drawView.date2=[self transformDateToString:[[_sportDataViewModel.sportDataArray objectAtIndex:index+1] valueForKey:@"collectionTime"] setFormat:@"yyyy-MM-dd"];
    drawView.date3=[self transformDateToString:[[_sportDataViewModel.sportDataArray objectAtIndex:index+2] valueForKey:@"collectionTime"] setFormat:@"yyyy-MM-dd"];
    
    //运动目标
    [drawView setGoal1:[[[_sportDataViewModel.sportDataArray objectAtIndex:index] valueForKey:@"goalStep"] intValue]];
    [drawView setGoal2:[[[_sportDataViewModel.sportDataArray objectAtIndex:index+1] valueForKey:@"goalStep"] intValue]];
    [drawView setGoal3:[[[_sportDataViewModel.sportDataArray objectAtIndex:index+2] valueForKey:@"goalStep"] intValue]];

    for (id sportData in _sportDataViewModel.sportDataArray) {
        NSDate *collectionTime=[sportData valueForKey:@"collectionTime"];
        NSNumber *steps=[sportData valueForKey:@"step"];
        NSNumber *goalStep=[sportData valueForKey:@"goalStep"];
        NSLog(@"collection time: %@ step:%d  goalStep:%d",collectionTime,[steps intValue],[goalStep intValue]);
    }
}

//向前翻页
-(void)previousPage
{
    _sportDataViewModel.location+=3;
    int index=_sportDataViewModel.location;
    
    @try {
        [self updateView];
        NSLog(@"not need load");
    }
    @catch (NSException *exception) {
        //如果model中没有对应的数据，则从数据库中获取
        if ([[exception name] isEqualToString:@"NSRangeException"]) {
            int dayInterval=24*60*60;
            NSDate *currentDate=[[[_sportDataViewModel.sportDataArray objectAtIndex:index-1] valueForKey:@"collectionTime"] dateByAddingTimeInterval:-dayInterval];
            NSLog(@"current date:%@",currentDate);
            NSMutableArray *newThreeDaysSportDatas=[self getThreeDaysSportDataFromCurrentDate:currentDate];
            [_sportDataViewModel.sportDataArray addObjectsFromArray:newThreeDaysSportDatas];
            [self updateView];
            NSLog(@"loading...");
        }
    }
}

//向后翻页
-(void)nextPage
{
    //如果当前页不是第一页
    if (_sportDataViewModel.location!=0) {
        
        _sportDataViewModel.location-=3;
        [self updateView];    
        
    }else {
        NSLog(@"已经是第一页了！");
    }
    
    
}

//将一般格式日期转换为特定格式日期
-(NSDate *)transformGeneralDateToFormattingDate:(NSDate *)generalDate setFormat:(NSString *)formatString
{
    //日期格式
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatString];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];//北京时间
    NSString *stringDate=[dateFormatter stringFromDate:generalDate];
    NSDate *formattingDate=[dateFormatter dateFromString:stringDate];
    return formattingDate;
}

//将日期转换为特定格式的字符串
-(NSString *)transformDateToString:(NSDate *)date setFormat:(NSString *)formatString
{
    //日期格式
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatString];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];//北京时间
    NSString *stringDate=[dateFormatter stringFromDate:date];
    return stringDate;
}

//将 日期，步数，运动目标 封装为对象
-(GroupSportData *)getGroupSportData:(NSDate *)date
{
    GroupSportData *groupSportData=[[GroupSportData alloc] init];
    
    int sumStepsofDay=[_sportDataVisualizeService getStepByDate:date];
    int goalStep=[_sportDataVisualizeService getGoalStepByDate:date];
    
    [groupSportData setStep:[NSNumber numberWithInt:sumStepsofDay]];
    [groupSportData setCollectionTime:date];
    [groupSportData setGoalStep:[NSNumber numberWithInt:goalStep]];
    
    return groupSportData;
    
}

-(NSMutableArray *)getSportDataByDate:(NSDate *)from toDate:(NSDate *)to
{
    NSMutableArray *sportDatas=[[NSMutableArray alloc] init];
    GroupSportData *groupSportData=[[GroupSportData alloc] init];
    
    int dayInterval=24*60*60;//一天＝24*60*60秒，即每天的间隔时间 
    for (NSDate *tempDate=from; [tempDate compare:to] != NSOrderedAscending; ) {
        groupSportData=[self getGroupSportData:tempDate];
        tempDate=[tempDate dateByAddingTimeInterval:-dayInterval];
        [sportDatas addObject:groupSportData];
    }
    return sportDatas;
}

//获取最近三天的运动数据（如currentDate＝2012－7－10,则获取10,9,8号的数据）
-(NSMutableArray *)getThreeDaysSportDataFromCurrentDate:(NSDate *)currentDate
{
    NSMutableArray *sportDatas=[[NSMutableArray alloc] init];
    int twoDaysInterval=2*24*60*60;//一天＝86400秒，即每天的间隔时间
    NSDate *from=currentDate;
    NSDate *to=[currentDate dateByAddingTimeInterval:-twoDaysInterval];
    sportDatas=[self getSportDataByDate:from toDate:to];
    NSLog(@"sport data count:%d",[sportDatas count]);
    return sportDatas;

}

- (void)viewDidUnload
{
    [self setSwipeLeftRecognizer:nil];
    [self setSwipeRightRecognizer:nil];
    [self setTapRecognizer:nil];
    [self setDataDetailViewController:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)handleLeftSwipeFrom:(UISwipeGestureRecognizer *)recognizer{
    if(recognizer.direction == UISwipeGestureRecognizerDirectionLeft){
        //[drawView setStep1:100];
        [self nextPage];
        [self.view setNeedsDisplay];
    }


}

- (IBAction)handleRightSwipeFrom:(UISwipeGestureRecognizer *)recognizer{
    if(recognizer.direction == UISwipeGestureRecognizerDirectionRight){
        //[drawView setStep1:200];
        [self previousPage];
        [self.view setNeedsDisplay];
    }
}

- (IBAction)handleTapFrom:(UITapGestureRecognizer *)recognizer{
    
    CGPoint location = [recognizer locationInView:self.view];
    NSInteger index = [drawView checkPointPosIndex:location];
    NSLog(@"%d",index);
    if(index>=1&&index<=3)
        [self presentModalViewController:self.dataDetailViewController animated:YES];
}

#pragma mark - LandscapeViewController delegate methods

- (void)dismissViewController:(UIViewController *)viewController
{
    if(self.modalViewController == viewController)
        [self dismissModalViewControllerAnimated:YES];
}


@end
