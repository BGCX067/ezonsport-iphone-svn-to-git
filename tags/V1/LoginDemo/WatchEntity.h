//
//  WatchEntity.h
//  LoginDemo
//
//  Created by apple on 12-7-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class UserEntity;

@interface WatchEntity : NSManagedObject

@property (nonatomic, retain) NSNumber * watchID;
@property (nonatomic, retain) NSString * watchType;
@property (nonatomic, retain) UserEntity *user;

@end
