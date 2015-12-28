//
//  InformationTableCell.h
//  EzonSportIphone
//
//  Created by apple on 12-7-14.
//  Copyright (c) 2012年 __scl__. All rights reserved.
//   add file

#import <UIKit/UIKit.h>

@interface InformationTableCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *contentLabel;


//添加自己的内容
@property (copy,nonatomic) NSString *title;
@property (copy,nonatomic) NSString *content;

@end
