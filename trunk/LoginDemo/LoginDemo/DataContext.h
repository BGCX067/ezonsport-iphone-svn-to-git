//
//  DataContext.h
//  LoginDemo
//
//  Created by apple on 12-7-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface DataContext : NSObject
{
    
@private
	NSManagedObjectContext *managedObjectContext_;
    NSManagedObjectModel *managedObjectModel_;
    NSPersistentStoreCoordinator *persistentStoreCoordinator_;
	
	NSString *coreDataModelName_;
    
    BOOL isTransaction_;
}

@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory;
-(DataContext*) initWithCoreDataModelName:(NSString*)coreDataModelName;

//获取新的托管对象
-(NSManagedObject *)getManagedObjectWithEntityName:(NSString *)entityName;

//添加对象
-(void) add:(NSManagedObject *)object;

//删除对象
-(void)delete:(NSManagedObject *)object;

//更新对象
-(void)update:(NSManagedObject *)object;

//返回上下文中的托管对象
-(NSSet *)getAllManagedObject;

//查询
-(NSArray*)queryWithEntityName:(NSString *)entityForName setPredicate:(NSPredicate *)predicate  setSortDescriptors:(NSArray *)sortDescriptors error:(NSError *)error;
-(NSArray*)queryWithEntityName:(NSString *)entityForName setPredicate:(NSPredicate *)predicate  setSortDescriptors:(NSArray *)sortDescriptors setFetchLimit:(NSUInteger)limit setFetchOffset:(NSUInteger)offset error:(NSError *)error;

-(NSArray*)queryWithEntityName:(NSString *)entityForName setPredicate:(NSPredicate *)predicate error:(NSError *)error;
-(NSArray*)queryWithEntityName:(NSString *)entityForName setPredicate:(NSPredicate *)predicate setFetchLimit:(NSUInteger)limit setFetchOffset:(NSUInteger)offset error:(NSError *)error;

-(NSArray*)queryAllWithEntityName:(NSString *)entityForName  error:(NSError *)error;
-(NSArray*)queryAllWithEntityName:(NSString *)entityForName  setFetchLimit:(NSUInteger)limit setFetchOffset:(NSUInteger)offset error:(NSError *)error;



//事务管理
-(void)beginTransaction;
-(void)commit;
-(void)rollback;


@end
