//
//  DataViewController.h
//  EzonSportIphone
//
//  Created by apple on 12-7-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataViewDraw.h"
#import "DataDetailController.h"

@class SportDataViewModel;
@class GroupSportData;
@class SportDataVisualizeService;

@interface DataViewController : UIViewController <DataDetailControllerDelegate>
@property (strong, nonatomic) DataViewDraw *drawView;
@property (strong, nonatomic) NSDate *curDate;
@property (strong, nonatomic) NSDate *theDayBeforeDate;
@property (strong, nonatomic) NSDate *the3DayBeforeDate;

@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *swipeLeftRecognizer;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *swipeRightRecognizer;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *tapRecognizer;

@property (strong, nonatomic) SportDataViewModel *sportDataViewModel;//model
@property (strong, nonatomic) SportDataVisualizeService *sportDataVisualizeService;//service

- (IBAction)handleLeftSwipeFrom:(UISwipeGestureRecognizer *)recognizer;

- (IBAction)handleRightSwipeFrom:(UISwipeGestureRecognizer *)recognizer;
- (IBAction)handleTapFrom:(UITapGestureRecognizer *)recognizer;
@property (strong, nonatomic) IBOutlet DataDetailController *dataDetailViewController;


@end
