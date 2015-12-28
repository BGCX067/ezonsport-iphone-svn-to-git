//
//  UserInfoViewModel.h
//  EzonSportIphone
//
//  Created by apple on 12-7-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoViewModel : NSObject
@property (strong,nonatomic) UIImage *photoOfUser;
@property (strong,nonatomic) NSString *nickNameOfUser;
@property (strong,nonatomic) NSNumber *heightOfUser;
@property (strong,nonatomic) NSNumber *weightOfUser;
@property (strong,nonatomic) NSDate *birthDayOfUser;
@end
