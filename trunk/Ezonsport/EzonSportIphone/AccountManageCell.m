//
//  AccountManageCell.m
//  EzonSportIphone
//
//  Created by apple on 12-7-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AccountManageCell.h"

@implementation AccountManageCell
@synthesize statusImage;
@synthesize userNameLabel;
@synthesize image;
@synthesize userName;

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

-(void)setImage:(UIImage *)img{
    if(![img isEqual:self.image]){
        image = [img copy];
        self.statusImage.image = image;
    }
}
-(void)setUserName:(NSString *)name{
    if(![name isEqual:userName] ){
        userName = [name copy];
        self.userNameLabel.text = userName;
    }
}



@end
