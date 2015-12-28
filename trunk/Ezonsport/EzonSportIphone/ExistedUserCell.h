//
//  ExistedUserCell.h
//  EzonSportIphone
//
//  Created by apple on 12-7-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExistedUserCell : UITableViewCell
//@property (strong,nonatomic) NSArray* userLists;
@property (strong, nonatomic) IBOutlet UILabel *userNameLabel;

@property (strong, nonatomic) IBOutlet UIImageView *statusImage;


@property (copy, nonatomic) UIImage *image;
@property (copy, nonatomic) NSString *userName;
@end
