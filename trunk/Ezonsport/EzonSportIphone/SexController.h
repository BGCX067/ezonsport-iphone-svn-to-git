//
//  SexController.h
//  EzonSportIphone
//
//  Created by apple on 12-8-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SexController : UIViewController
- (IBAction)nextButton:(id)sender;
- (IBAction)sexSelected:(id)sender;
@property (strong, nonatomic) IBOutlet UISegmentedControl *sex;
@property (strong, nonatomic) IBOutlet UIPickerView *myPickerView;


@property (strong,nonatomic) NSString *sexDefault;
@property (strong, nonatomic) IBOutlet UISlider *finishedNumber;
@property (strong, nonatomic) NSArray *myPickerData;//整数部分
//@property (strong, nonatomic) NSArray *myPickerData_2;//小数部分
@property (strong, nonatomic) NSArray *myPickerData_3;//单位
@end
