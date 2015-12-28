//
//  ezonsportCell.m
//  HistoryShow
//
//  Created by apple on 12-7-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "HistoryTableCell.h"

@implementation HistoryTableCell

@synthesize timeLabel;
@synthesize distanceLabel;
@synthesize stepLabel;
@synthesize calLabel;


//添加自己的属性
@synthesize time;
@synthesize distance;
@synthesize step;
@synthesize cal;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}




//添加新增的方法
-(void) setTime:(NSString *)t
{
    time = [t copy];
    self.timeLabel.text = time;
}
-(void) setDistance:(NSString *)dis
{
    distance = [dis copy];
    self.distanceLabel.text = distance;
}
-(void) setStep:(NSString *)s
{
    step = [s copy];
    self.stepLabel.text = step;
}
-(void) setCal:(NSString *)c
{
    cal = [c copy];
    self.calLabel.text = cal;
}


@end
