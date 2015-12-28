//
//  SportDataVisualizeService.h
//  EzonSportIphone
//
//  Created by apple on 12-7-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataContext.h"

@interface SportDataVisualizeService : NSObject

@property (nonatomic,retain)DataContext *ctx;

//初始化
-(SportDataVisualizeService *)init;
+(SportDataVisualizeService *)instance;

//获取托管对象
-(NSManagedObject *)getManagedObjectWithEntityName:(NSString *)entityName;

//获取所有运动记录（统计和详细）
-(NSArray *) getAllSportData;
-(NSArray *) getAllDetailSportData;

//获取指定时间段的运动记录(统计和详细)
-(NSArray *) getSportDataByDate:(NSDate *)from toDate:(NSDate *)to;
-(NSArray *) getDetailSportDataByDate:(NSDate *)from toDate:(NSDate *)to;

//获取指定日期的运动目标和统计步数
-(int)getStepByDate:(NSDate *)date;
-(int) getGoalStepByDate:(NSDate *) date;

//添加运动记录（测试数据）
-(void) addSportData:(NSManagedObject *)sportData;

@end
