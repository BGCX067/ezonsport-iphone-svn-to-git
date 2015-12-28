//
//  UserInfoViewController.h
//  EzonSportIphone
//
//  Created by apple on 12-7-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SystemManageService.h"
#import "UserInfoViewModel.h"
@interface UserInfoViewController : UITableViewController<UITextFieldDelegate>
@property (strong, nonatomic) NSArray *listData;
@property (copy,nonatomic)NSString *heightOfUser;
@property (copy,nonatomic)NSString *weightOfUser;
@property (copy,nonatomic)NSString *birthdayOfUser;
@property (copy,nonatomic)UIImage *imageOfUser;
@property (copy,nonatomic)NSString *nickNameOfUser;
@property (copy,nonatomic) NSManagedObject *user;

@property (copy,nonatomic)SystemManageService *systemManageService;
@property (strong,nonatomic) UserInfoViewModel *userInfoModel;
@end
