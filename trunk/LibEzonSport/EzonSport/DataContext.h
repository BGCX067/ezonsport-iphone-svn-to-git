//
//  DataContext.h
//  EzonSportIphone
//
//  Created by apple on 12-7-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//  

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface DataContext : NSObject

@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;//事务上下文
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;//对象模型
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;//持久化协调器

@property (nonatomic, retain) NSString *coreDataModelName;//对象模型名
@property (nonatomic) BOOL isTransaction;//事务标识

//根据对象模型名称初始化
-(DataContext*) initWithCoreDataModelName:(NSString*)coreDataModelName;
//单例模式
+(DataContext *) instance;

//获取新的托管对象
-(NSManagedObject *)getManagedObjectWithEntityName:(NSString *)entityName;

//增删改
-(void)insertObject:(NSManagedObject *)object;
-(void)deleteObject:(NSManagedObject *)object;
-(void)updateObject:(NSManagedObject *)object;

//条件，排序，分段查询
-(NSArray*)queryWithEntityName:(NSString *)entityForName setPredicate:(NSPredicate *)predicate  setSortDescriptors:(NSArray *)sortDescriptors error:(NSError *)error;
-(NSArray*)queryWithEntityName:(NSString *)entityForName setPredicate:(NSPredicate *)predicate  setSortDescriptors:(NSArray *)sortDescriptors setFetchLimit:(NSUInteger)limit setFetchOffset:(NSUInteger)offset error:(NSError *)error;

//条件，分段查询
-(NSArray*)queryWithEntityName:(NSString *)entityForName setPredicate:(NSPredicate *)predicate error:(NSError *)error;
-(NSArray*)queryWithEntityName:(NSString *)entityForName setPredicate:(NSPredicate *)predicate setFetchLimit:(NSUInteger)limit setFetchOffset:(NSUInteger)offset error:(NSError *)error;

//查询所有
-(NSArray*)queryAllWithEntityName:(NSString *)entityForName  error:(NSError *)error;
-(NSArray*)queryAllWithEntityName:(NSString *)entityForName  setFetchLimit:(NSUInteger)limit setFetchOffset:(NSUInteger)offset error:(NSError *)error;

//事务管理
-(void)beginTransaction;
-(void)commit;
-(void)rollback;

@end
