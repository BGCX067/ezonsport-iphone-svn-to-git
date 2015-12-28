//
//  DataViewDraw.h
//  EzonSportIphone
//
//  Created by apple on 12-7-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DataViewDraw : UIView{
    NSInteger step1;
    NSInteger step2;
    NSInteger step3;
    NSInteger goal1;
    NSInteger goal2;
    NSInteger goal3;
    
}
-(void)setStep1:(NSInteger) value;
-(NSInteger) getStep1;

-(void)setStep2:(NSInteger) value;
-(NSInteger) getStep2;

-(void)setStep3:(NSInteger) value;
-(NSInteger) getStep3;

-(void)setGoal1:(NSInteger) value;
-(NSInteger)getGoal1;

-(void)setGoal2:(NSInteger) value;
-(NSInteger)getGoal2;

-(void)setGoal3:(NSInteger) value;
-(NSInteger)getGoal3;

-(NSInteger)checkPointPosIndex:(CGPoint) location;


@property (strong, nonatomic) NSString *date1;
@property (strong, nonatomic) NSString *date2;
@property (strong, nonatomic) NSString *date3;


@end
