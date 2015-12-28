//
//  DataDetailPlotDraw.h
//  EzonSportIphone
//
//  Created by apple on 12-8-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CorePlot-CocoaTouch.h"

@interface DataDetailPlotDraw : UIView <CPTPlotDataSource>{
    NSInteger maxStep;
}
@property (strong, nonatomic) NSMutableArray *stepDataArray;
@property (strong, nonatomic) NSDate *benginTime;
@property (strong, nonatomic) NSDate *endTime;
-(void) setMaxStep:(NSInteger)value;
-(NSInteger) getMaxStep;
@end
