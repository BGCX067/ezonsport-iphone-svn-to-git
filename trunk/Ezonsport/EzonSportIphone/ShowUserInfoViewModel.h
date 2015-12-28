//
//  ShowUserInfoViewModel.h
//  EzonSportIphone
//
//  Created by apple on 12-7-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface ShowUserInfoViewModel : NSObject

@property (nonatomic,retain) NSManagedObject *user;
@property (nonatomic,retain)  NSArray *userInfoArray;

@end
