//
//  TitleCellController.h
//  EzonSportIphone
//
//  Created by apple on 12-7-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TitleCellController : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *goalLabel;
@property (copy,nonatomic) NSString *goal;
@end
