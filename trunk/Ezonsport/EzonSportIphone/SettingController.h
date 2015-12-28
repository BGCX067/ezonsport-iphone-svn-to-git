//
//  SettingController.h
//  EzonSportIphone
//
//  Created by apple on 12-7-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingController : UITableViewController

@property(strong,nonatomic) NSArray *lists;
@property (strong, nonatomic) NSArray *controllerList;//用于保存跳转目的的controller
@end
