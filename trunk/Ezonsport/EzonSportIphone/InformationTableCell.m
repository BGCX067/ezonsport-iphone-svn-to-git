//
//  InformationTableCell.m
//  EzonSportIphone
//
//  Created by apple on 12-7-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//   

#import "InformationTableCell.h"

@implementation InformationTableCell
@synthesize titleLabel;
@synthesize contentLabel;


//add myself 
@synthesize title;
@synthesize content;

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





//getter  and setter  function
-(void) setTitle:(NSString *)t
{
    title = [t copy];
    self.textLabel.text = title;
}
-(void) setContent:(NSString *)c
{
    content = [c copy];
    self.contentLabel.text = content;
}
@end
