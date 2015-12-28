//
//  InformationController.h
//  EzonSportIphone
//
//  Created by apple on 12-7-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EzonSport/SystemManageService.h>
#import "EzonAppDelegate.h"
#import "ShowUserInfoViewModel.h"

@interface ShowUserInfoController : UITableViewController
                                    <UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    SystemManageService *systemManageService;
    ShowUserInfoViewModel *showUserInfoViewModel;
    UIImageView *userImgView;
}

@end
