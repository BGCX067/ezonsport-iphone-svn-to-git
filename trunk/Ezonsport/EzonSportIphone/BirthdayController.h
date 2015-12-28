//
//  BirthdayController.h
//  EzonSportIphone
//
//  Created by apple on 12-8-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BirthdayController : UIViewController
@property (strong, nonatomic) IBOutlet UISlider *finishNumber;

- (IBAction)nextButton:(id)sender;
@property (strong, nonatomic) IBOutlet UIDatePicker *selectedBirthday;

@end
