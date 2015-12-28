//
//  ContentCellController.m
//  EzonSportIphone
//
//  Created by apple on 12-7-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ContentCellController.h"

@implementation ContentCellController
@synthesize commonGoalsLabel;
@synthesize commonSelectedImage;
@synthesize saveButton;
@synthesize commonGoals;
@synthesize commonSelected;

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
    if(self.selected){
        self.commonSelectedImage.image = [UIImage imageNamed:@"goalsetting_choose.png"];
        if ([commonGoalsLabel.text isEqualToString:@"用户自定义"]) {
            self.saveButton.hidden=YES;
        }else {
            self.saveButton.hidden=NO;
        }
        
    }else {
        self.commonSelectedImage.image = [UIImage imageNamed:@"goalsetting_choose_normal.png"];
        self.saveButton.hidden=YES;
    }
    //NSLog(@"animatonedddd=====");
}

-(void) setCommonGoals:(NSArray *)c
{
    commonGoals = [c copy];
    self.commonGoalsLabel.text = commonGoals;
    
}
-(void)setCommonSelected:(UIImage *)com
{
    commonSelected = [com copy];
    self.commonSelectedImage.image = commonSelected;
}

@end
