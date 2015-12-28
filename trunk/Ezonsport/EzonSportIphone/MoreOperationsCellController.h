//
//  MoreOperationsCellController.h
//  EzonSportIphone
//
//  Created by apple on 12-7-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoreOperationsCellController : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *iconImageView;
@property (strong, nonatomic) IBOutlet UILabel *optLabel;

@property (copy, nonatomic) UIImage *image;
@property (copy, nonatomic) NSString *optName;
@end
