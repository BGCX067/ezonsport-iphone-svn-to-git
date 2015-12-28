//
//  AccountManageViewController.h
//  EzonSportIphone
//
//  Created by apple on 12-7-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SystemManageService.h"
@interface AccountManageViewController : UITableViewController

@property (strong,nonatomic) SystemManageService *systemManageSerivce;
@property (strong,nonatomic) NSArray *userArray;
@end
