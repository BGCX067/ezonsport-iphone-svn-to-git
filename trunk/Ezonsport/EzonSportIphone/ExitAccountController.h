//
//  ExitAccountController.h
//  EzonSportIphone
//
//  Created by apple on 12-7-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SystemManageService.h"
@interface ExitAccountController : UIViewController
- (IBAction)cancleCurrentAccount:(id)sender;
@property (strong,nonatomic) SystemManageService * systemManageService;
@end
