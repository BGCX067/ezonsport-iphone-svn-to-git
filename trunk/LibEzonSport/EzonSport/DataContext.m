//
//  DataContext.m
//  EzonSportIphone
//
//  Created by apple on 12-7-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DataContext.h"

@implementation DataContext

@synthesize managedObjectModel=_managedObjectModel;
@synthesize managedObjectContext=_managedObjectContext;
@synthesize persistentStoreCoordinator=_persistentStoreCoordinator;

@synthesize coreDataModelName=_coreDataModelName;
@synthesize isTransaction=_isTransaction;

-(DataContext*) initWithCoreDataModelName:(NSString*)coreDataModelName
{
	self=[super init];
	if(self)
	{
		_coreDataModelName=[[NSString alloc] initWithFormat:@"%@",coreDataModelName];
        _isTransaction=NO;
	}
	return self;
    
}

+(DataContext *)instance
{
    //一个静态局部变量作用域存在于函数内，但是生命周期是整个程序，在下一次该函数调用时仍可使用。
    static DataContext *ctx;
    
    //保证线程安全
    @synchronized(self)
    {
        if (! ctx ) {
            ctx=[[DataContext alloc] initWithCoreDataModelName:@"EzonSport"];
        }
    }
    return ctx;
}

-(NSManagedObject *)getManagedObjectWithEntityName:(NSString *)entityName
{
	//存放托管对象的上下文
    NSManagedObjectContext *context = [self managedObjectContext];
	NSManagedObject *managedObject=[NSEntityDescription
									insertNewObjectForEntityForName:entityName
									inManagedObjectContext:context];
	return managedObject;
	
}

-(void) insertObject:(NSManagedObject *)object
{
	
    //获取当前上下文
    NSManagedObjectContext *context=[self managedObjectContext];
    
    if (_isTransaction) {
        
        //如果对象不在当前上下文中，则将其插入
        if (![object isInserted]) {
            [context insertObject:object];
        }
    }
    		
}

-(void)deleteObject:(NSManagedObject *)object
{
    NSManagedObjectContext *context=[self managedObjectContext];
    
    if (_isTransaction) {
        //将托管对象从上下文中移除
        [context deleteObject:object];
    }
}

-(void)updateObject:(NSManagedObject *)object
{
    NSManagedObjectContext *context=[self managedObjectContext];

    if (_isTransaction) {
        //更新对象
        [context refreshObject:object mergeChanges:YES];
    }
    
    

}

//查询
-(NSArray*)queryWithEntityName:(NSString *)entityForName setPredicate:(NSPredicate *)predicate  setSortDescriptors:(NSArray *)sortDescriptors error:(NSError *)error
{
	return [self queryWithEntityName:entityForName setPredicate:predicate setSortDescriptors:sortDescriptors setFetchLimit:0 setFetchOffset:0 error:error];
}

-(NSArray*)queryWithEntityName:(NSString *)entityForName setPredicate:(NSPredicate *)predicate  setSortDescriptors:(NSArray *)sortDescriptors setFetchLimit:(NSUInteger)limit setFetchOffset:(NSUInteger)offset error:(NSError *)error
{
	NSFetchRequest *request=[[NSFetchRequest alloc] init];
	NSEntityDescription *entityDes=[NSEntityDescription entityForName:entityForName inManagedObjectContext:self.managedObjectContext];
	
	[request setEntity:entityDes]; 
	[request setPredicate:predicate];
	[request setSortDescriptors:sortDescriptors];
	[request setFetchLimit:limit];
	[request setFetchOffset:offset];
	
	//执行查询
	NSArray *result=[self.managedObjectContext executeFetchRequest:request error:&error];
	
	return result;
}



-(NSArray*)queryWithEntityName:(NSString *)entityForName setPredicate:(NSPredicate *)predicate error:(NSError *)error
{
    return [self queryWithEntityName:entityForName setPredicate:predicate setFetchLimit:0 setFetchOffset:0 error:error];
}

-(NSArray*)queryWithEntityName:(NSString *)entityForName setPredicate:(NSPredicate *)predicate setFetchLimit:(NSUInteger)limit setFetchOffset:(NSUInteger)offset error:(NSError *)error
{
	NSFetchRequest *request=[[NSFetchRequest alloc] init];
	NSEntityDescription *entityDes=[NSEntityDescription entityForName:entityForName inManagedObjectContext:self.managedObjectContext];
	
	[request setEntity:entityDes]; 
	[request setPredicate:predicate];
	[request setFetchLimit:limit];
	[request setFetchOffset:offset];
	
	//执行查询
	NSArray *result=[self.managedObjectContext executeFetchRequest:request error:&error];

	return result;
}


-(NSArray*)queryAllWithEntityName:(NSString *)entityForName  error:(NSError *)error
{
	
	return [self queryAllWithEntityName:entityForName setFetchLimit:0 setFetchOffset:0 error:error];
}


-(NSArray*)queryAllWithEntityName:(NSString *)entityForName  setFetchLimit:(NSUInteger)limit setFetchOffset:(NSUInteger)offset error:(NSError *)error
{
	NSFetchRequest *request=[[NSFetchRequest alloc] init];
	NSEntityDescription *entityDes=[NSEntityDescription entityForName:entityForName inManagedObjectContext:self.managedObjectContext];
	
	[request setEntity:entityDes]; 
	[request setFetchLimit:limit];
	[request setFetchOffset:offset];
	
	//执行查询
	NSArray *result=[self.managedObjectContext executeFetchRequest:request error:&error];

	return result;
}


//开始事务
-(void)beginTransaction
{   
    _isTransaction=YES;
}

//提交事务
-(void)commit
{
    NSError *error;
    NSManagedObjectContext *context=[self managedObjectContext];
    
    //提交
    BOOL result=[context save:&error];
    
    //如果提交失败，则抛异常信息，否则不作处理   
    if (!result) {
        @throw [NSException exceptionWithName:@"Exception" reason:[error localizedDescription] userInfo:nil];
    }

}

//回滚事务
-(void)rollback
{
    [self.managedObjectContext rollback];
    
}


/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *)managedObjectContext {
    
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}


/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
- (NSManagedObjectModel *)managedObjectModel {
    
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:_coreDataModelName withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL: modelURL] ;    
    return _managedObjectModel;
}


/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"ezonsport.sqlite"];
    NSLog(@"%@",[storeURL path]);
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
		
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return _persistentStoreCoordinator;
}


/**
 Returns the URL to the application's Documents directory.
 */
- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


@end
