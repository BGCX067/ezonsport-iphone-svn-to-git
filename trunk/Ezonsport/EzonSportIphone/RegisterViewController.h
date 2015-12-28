//
//  RegisterViewController.h
//  EzonSportIphone
//
//  Created by tong chen on 12-7-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EzonSport/SystemManageService.h>
#import <EzonSport/SportDataVisualizeService.h>
#import "RegisterViewModel.h"
@interface RegisterViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *userNameTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *verifypasswordTextField;

@property (strong, nonatomic)RegisterViewModel *registerViewModel;
@property (strong, nonatomic)SystemManageService *systemManageService;
@property (strong, nonatomic)SportDataVisualizeService *sportDataVisualizeService;
- (IBAction)verifyRegister:(id)sender;
- (IBAction)cancleRegister:(id)sender;

-(IBAction)hideKeyboard:(id)sender;
@end
