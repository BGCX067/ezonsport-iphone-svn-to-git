//
//  HistoryController.h
//  EzonSportIphone
//
//  Created by apple on 12-7-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HistoryViewModel.h"
#import "SportDataVisualizeService.h"

@interface HistoryController : UITableViewController
{
    NSInteger dataNumber;//记录当前数据的长度
    BOOL _loadingMore;//判断是否需要加载
}
@property(nonatomic,retain) SportDataVisualizeService *sportDataVisualizeService;
@property(nonatomic,retain) HistoryViewModel *historyViewModel;

@property(nonatomic,retain) NSMutableArray *timeList;
@property(nonatomic,retain) NSMutableArray *distanceList;
@property(nonatomic,retain) NSMutableArray *stepList;
@property(nonatomic,retain) NSMutableArray *calList;


// 创建表格底部
- (void) createTableFooter;
// 开始加载数据
- (void) loadDataBegin;
// 加载数据中
- (void) loadDataing;
// 加载数据完毕
- (void) loadDataEnd;
@end
