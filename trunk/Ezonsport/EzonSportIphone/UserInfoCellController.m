//
//  UserInfoCellController.m
//  EzonSportIphone
//
//  Created by apple on 12-7-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UserInfoCellController.h"

@implementation UserInfoCellController
@synthesize titleLabel;
@synthesize contentLabel;



@synthesize title;
@synthesize content;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    [self.contentLabel addTarget:self  action:@selector(textValueChanged:)  forControlEvents:UIControlEventValueChanged];
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    if(selected){
        NSLog(@"1111");
    }

    // Configure the view for the selected state
}

-(void) setTitle:(NSString *)t
{
    title = [t copy];
    self.titleLabel.text = title;
}
-(void) setContent:(NSString *)c
{
    content = [c copy];
    self.contentLabel.text = content;
}
-(void)textValueChanged:(id)sender
{
    NSLog(@"=======");
}

@end
