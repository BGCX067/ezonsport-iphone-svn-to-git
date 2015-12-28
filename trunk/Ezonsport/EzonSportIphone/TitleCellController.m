//
//  TitleCellController.m
//  EzonSportIphone
//
//  Created by apple on 12-7-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TitleCellController.h"

@implementation TitleCellController
@synthesize goalLabel;
@synthesize goal;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



-(void) setGoal:(NSString *)g
{
    goal = [g copy];
    self.goalLabel.text = goal;
}
@end
