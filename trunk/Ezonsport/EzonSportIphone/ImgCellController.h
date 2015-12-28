//
//  ImgCellController.h
//  EzonSportIphone
//
//  Created by apple on 12-7-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImgCellController : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *userImg;
@property (strong, nonatomic) IBOutlet UITextField *userNameLabel;


@property (copy,nonatomic) UIImage *userPhoto;
@property (copy,nonatomic) NSString *userName;

@end
