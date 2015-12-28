//
//  HistoryController.m
//  EzonSportIphone
//
//  Created by apple on 12-7-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "HistoryController.h"
#import "HistoryTableCell.h"

@interface HistoryController ()

@end

@implementation HistoryController

@synthesize sportDataVisualizeService=_sportDataVisualizeService;
@synthesize historyViewModel=_historyViewModel;

//添加自己的内容
@synthesize timeList;
@synthesize distanceList;
@synthesize stepList;
@synthesize calList;



- (void)viewDidLoad
{
    [super viewDidLoad];

    _sportDataVisualizeService=[SportDataVisualizeService instance];
    _historyViewModel=[[HistoryViewModel alloc] init];
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];

    //获取指定时间段的计步数据

    NSDate *fromDate=[NSDate dateWithTimeIntervalSinceNow: -(24 * 60 * 60*6)];
    NSDate *toDate=[NSDate date];

    

    NSArray *sportDatas=[_sportDataVisualizeService getSportDataByDate:fromDate toDate:toDate];
    _historyViewModel.PresentMinDates = fromDate;//记录当前model中保存数据的最早日期
    _historyViewModel.sportDataArray=[[NSMutableArray alloc] initWithArray:sportDatas];

    self.timeList=[[NSMutableArray alloc] init];
    self.distanceList=[[NSMutableArray alloc] init];
    self.stepList=[[NSMutableArray alloc] init];
    self.calList=[[NSMutableArray alloc] init];
    int i=0;

    for (id sportData in _historyViewModel.sportDataArray) {
        [self.timeList insertObject: [dateFormatter stringFromDate:[sportData valueForKey:@"collectTime"]] atIndex:i];
        [self.distanceList insertObject:[[NSString alloc] initWithFormat:@"%@",[sportData valueForKey:@"distance"] ] atIndex:i];
        [self.stepList insertObject:[[NSString alloc] initWithFormat:@"%@",[sportData valueForKey:@"steps"] ] atIndex:i];
        [self.calList insertObject:[[NSString alloc] initWithFormat:@"%@",[sportData valueForKey:@"calorie"] ] atIndex:i];
        i=i+1;
    }
    
}
- (void)viewDidUnload
{
    self.timeList = nil;
    self.distanceList = nil;
    self.stepList = nil;
    self.calList = nil;

    [super viewDidUnload];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
//添加自己的
#pragma mark -
#pragma mark Table Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.timeList count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *HistoryTableCellIdentifier = @"HistoryTableCellIdentifier";
    
    static BOOL nibsRegistered = NO;
    if (!nibsRegistered) {
        UINib *nib = [UINib nibWithNibName:@"HistoryTableCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:HistoryTableCellIdentifier];
        nibsRegistered = YES;
    }
    HistoryTableCell *cell = [tableView dequeueReusableCellWithIdentifier:HistoryTableCellIdentifier];
    NSUInteger row = [indexPath row];
    
    cell.time = [timeList objectAtIndex:row];
    cell.distance = [distanceList objectAtIndex:row];
    cell.step = [stepList objectAtIndex:row];
    cell.cal = [calList objectAtIndex:row];
        cell.backgroundColor = [UIColor redColor];
    return cell;

}
#pragma mark Table Delegate Methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 73.5;
}


//动态刷新操作
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{    
    // 下拉到最底部时显示更多数据
    if(!_loadingMore && scrollView.contentOffset.y > ((scrollView.contentSize.height - scrollView.frame.size.height)))
    {
        [self loadDataBegin];
    }
}
// 开始加载数据
- (void) loadDataBegin
{
    if (_loadingMore == NO) 
    {
        _loadingMore = YES;
        UIActivityIndicatorView *tableFooterActivityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(75.0f, 10.0f, 20.0f, 20.0f)];
        [tableFooterActivityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
        [tableFooterActivityIndicator startAnimating];
        [self.tableView.tableFooterView addSubview:tableFooterActivityIndicator];
        
        [self loadDataing];
    }
}
// 加载数据中
- (void) loadDataing
{
    dataNumber = [stepList count];
    
    
    //访问数据库
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    NSDate *toDate=[[_historyViewModel PresentMinDates] dateByAddingTimeInterval:-(24 * 60 * 60)];
    NSDate *fromDate= [toDate dateByAddingTimeInterval:-(24 * 60 * 60*6) ];

    NSArray *sportDatas=[_sportDataVisualizeService getSportDataByDate:fromDate toDate:toDate];
    _historyViewModel.PresentMinDates = fromDate;//记录当前model中保存数据的最早日期
    [_historyViewModel.sportDataArray addObjectsFromArray:sportDatas ];
    self.timeList=[[NSMutableArray alloc] init];
    self.distanceList=[[NSMutableArray alloc] init];
    self.stepList=[[NSMutableArray alloc] init];
    self.calList=[[NSMutableArray alloc] init];
    int i=0;
    
    for (id sportData in _historyViewModel.sportDataArray) {
        [self.timeList insertObject: [dateFormatter stringFromDate:[sportData valueForKey:@"collectTime"]] atIndex:i];
        [self.distanceList insertObject:[[NSString alloc] initWithFormat:@"%@",[sportData valueForKey:@"distance"] ] atIndex:i];
        [self.stepList insertObject:[[NSString alloc] initWithFormat:@"%@",[sportData valueForKey:@"steps"] ] atIndex:i];
        [self.calList insertObject:[[NSString alloc] initWithFormat:@"%@",[sportData valueForKey:@"calorie"] ] atIndex:i];
        i=i+1;
    }
    [[self tableView] reloadData];
    
    [self loadDataEnd];
}

// 加载数据完毕
- (void) loadDataEnd
{
    _loadingMore = NO;
    [self createTableFooter];
}
// 创建表格底部
- (void) createTableFooter
{
//    self.tableView.tableFooterView = nil;
//    UIView *tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.tableView.bounds.size.width, 60.0f)]; 
//    UILabel *loadMoreText = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 116.0f, 40.0f)];
//    [loadMoreText setCenter:tableFooterView.center];
//    [loadMoreText setFont:[UIFont fontWithName:@"Helvetica Neue" size:14]];
//    [loadMoreText setText:@"更多"];
//    [tableFooterView addSubview:loadMoreText];    
    
//    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"updateing.gif"]];
//    [tableFooterView addSubview:imageView]; 
    //self.tableView.tableFooterView = tableFooterView;
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}


@end
