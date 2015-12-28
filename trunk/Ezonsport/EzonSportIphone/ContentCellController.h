//
//  ContentCellController.h
//  EzonSportIphone
//
//  Created by apple on 12-7-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContentCellController : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *commonGoalsLabel;
@property (strong, nonatomic) IBOutlet UIImageView *commonSelectedImage;
@property (strong, nonatomic) IBOutlet UIButton *saveButton;

@property (copy,nonatomic) UIImage *commonSelected;
@property (copy,nonatomic) NSString *commonGoals;


@end
