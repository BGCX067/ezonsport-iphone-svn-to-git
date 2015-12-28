//
//  MoreOperationsCellController.m
//  EzonSportIphone
//
//  Created by apple on 12-7-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MoreOperationsCellController.h"

@implementation MoreOperationsCellController
@synthesize iconImageView;
@synthesize optLabel;
@synthesize image;
@synthesize optName;

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

- (void)setImage:(UIImage *)img {
    if (![img isEqual:image]) {
        image = [img copy];
        self.iconImageView.image = image;
    }
}
-(void)setOptName:(NSString *)name {
    if (![name isEqualToString:optName]) {
        optName = [name copy];
        self.optLabel.text = optName;
    }
}



@end
