//
//  ImgCellController.m
//  EzonSportIphone
//
//  Created by apple on 12-7-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ImgCellController.h"

@implementation ImgCellController
@synthesize userImg;
@synthesize userNameLabel;
@synthesize userPhoto;
@synthesize  userName;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.userImg.userInteractionEnabled=YES;
        UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickImage)];
        [self.userImg addGestureRecognizer:singleTap];
    }
    return self;
}

-(void)onClickImage
{
    NSLog(@"image is clicked");
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void) setUserImg:(UIImageView *)uimg
{
    //userPhoto = [uimg copy];
    //self.userImg.image = userPhoto;
}
-(void) setUserName:(NSString *)uname
{
    userName = [uname copy];
    self.userNameLabel.text = userName;
}
@end
