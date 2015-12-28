//
//  GoalSettingViewController.h
//  EzonSportIphone
//
//  Created by apple on 12-7-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SystemManageService.h"
@interface GoalSettingViewController : UITableViewController<UITableViewDelegate,UITableViewDataSource>
{
    UITextField *textField;
    NSInteger lastestGoal;//定义一个全局变量用于保存最新的运动计划
}
@property (strong,nonatomic) SystemManageService *systemManageService;
@property (strong,nonatomic) NSArray * listsData;
@property (strong,nonatomic) NSString *currentGoal;
@property (strong,nonatomic) NSArray *listsSelectedImage;
@property (strong,nonatomic) UIButton *saveButton;
@end
