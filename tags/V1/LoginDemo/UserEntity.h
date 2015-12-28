//
//  UserEntity.h
//  LoginDemo
//
//  Created by apple on 12-7-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface UserEntity : NSManagedObject

@property (nonatomic, retain) NSString * userName;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSSet *watchSet;
@end

@interface UserEntity (CoreDataGeneratedAccessors)

- (void)addWatchSetObject:(NSManagedObject *)value;
- (void)removeWatchSetObject:(NSManagedObject *)value;
- (void)addWatchSet:(NSSet *)values;
- (void)removeWatchSet:(NSSet *)values;

@end
