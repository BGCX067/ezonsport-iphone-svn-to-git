//
//  AccountManageCell.h
//  EzonSportIphone
//
//  Created by apple on 12-7-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountManageCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *statusImage;
@property (strong, nonatomic) IBOutlet UILabel *userNameLabel;
@property (copy, nonatomic) UIImage *image;
@property (copy, nonatomic) NSString *userName;

@end
