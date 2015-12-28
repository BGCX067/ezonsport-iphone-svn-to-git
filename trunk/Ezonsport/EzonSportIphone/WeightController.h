//
//  WeightController.h
//  EzonSportIphone
//
//  Created by apple on 12-8-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EzonSport/SystemManageService.h>
#import "RegisterViewModel.h"
@interface WeightController : UIViewController
@property (weak, nonatomic) IBOutlet UIPickerView *myPickerView;
@property (strong, nonatomic) NSArray *myPickerData;
@property (strong, nonatomic) NSArray *myPickerData_2;
@property (strong, nonatomic) NSArray *myPickerData_3;
- (IBAction)commitRegister:(id)sender;

@property (strong,nonatomic) RegisterViewModel *registerModel;
@property (strong,nonatomic) SystemManageService *systemManager;
@property (copy,nonatomic) NSManagedObject *user;
@end
