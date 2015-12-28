//
//  DataDetailController.h
//  EzonSportIphone
//
//  Created by apple on 12-8-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CorePlot-CocoaTouch.h"
@protocol DataDetailControllerDelegate <NSObject>
- (void)dismissViewController:(UIViewController *)viewController;
@end
@interface DataDetailController : UIViewController <CPTPlotDataSource>{
    NSMutableArray *dataArray;
}
@property (strong, nonatomic) id<DataDetailControllerDelegate> delegate;

-(void) drawPlotArea;
- (IBAction)doneAction:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *caloriesLabel;
@property (strong, nonatomic) IBOutlet UILabel *stepsLabel;
@property (strong, nonatomic) IBOutlet UILabel *milesLabel;

@end
