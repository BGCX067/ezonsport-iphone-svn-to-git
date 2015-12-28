//
//  MoreOperationsController.h
//  EzonSportIphone
//
//  Created by apple on 12-7-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoreOperationsController : UITableViewController<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) NSArray *dataList;
@property (strong, nonatomic) NSArray *imageList;
@property (strong, nonatomic) NSArray *controllerList;

@end
