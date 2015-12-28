//
//  ezonsportCell.h
//  HistoryShow
//
//  Created by apple on 12-7-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

//11111111,各种类哈哈哈哈
@interface HistoryTableCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *distanceLabel;
@property (strong, nonatomic) IBOutlet UILabel *stepLabel;
@property (strong, nonatomic) IBOutlet UILabel *calLabel;



//自己添加的属性
@property (copy,nonatomic) NSString *time;
@property (copy,nonatomic) NSString *distance;
@property (copy,nonatomic) NSString *step;
@property (copy,nonatomic) NSString *cal;
@end
