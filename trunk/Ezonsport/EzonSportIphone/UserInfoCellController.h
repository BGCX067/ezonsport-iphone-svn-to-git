//
//  UserInfoCellController.h
//  EzonSportIphone
//
//  Created by apple on 12-7-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserInfoCellController : UITableViewCell<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UITextField *contentLabel;





@property (copy,nonatomic) NSString *title;
@property (copy,nonatomic) NSString *content;
@end
