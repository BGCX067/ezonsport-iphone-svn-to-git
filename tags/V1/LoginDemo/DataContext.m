//
//  DataContext.m
//  LoginDemo
//
//  Created by apple on 12-7-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DataContext.h"

@implementation DataContext

-(DataContext*) initWithCoreDataModelName:(NSString*)coreDataModelName
{
	self=[super init];
	if(self)
	{
		coreDataModelName_=[[NSString alloc] initWithFormat:@"%@",coreDataModelName];
        isTransaction_=NO;
	}
	return self;
    
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

/**
 添加托管对象到上下文中
 */
-(void) add:(NSManagedObject *)object
{
	
    //获取当前上下文
    NSManagedObjectContext *context=[self managedObjectContext];
    
    if (isTransaction_) {
        
        //如果对象不在当前上下文中，则将其插入
        if (![object isInserted]) {
            [context insertObject:object];
        }
    }
    		
}

-(void)delete:(NSManagedObject *)object
{
    NSManagedObjectContext *context=[self managedObjectContext];
    
    if (isTransaction_) {
        
        //将托管对象从上下文中移除
        [context deleteObject:object];
    }
}

-(void)update:(NSManagedObject *)object
{
    NSManagedObjectContext *context=[self managedObjectContext];
    
    if (isTransaction_) {
        //更新对象
        [context refreshObject:object mergeChanges:YES];
    }
    
    

}

-(NSSet *)getAllManagedObject
{
    return [managedObjectContext_ registeredObjects];
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
	
	if (![self.managedObjectContext save:&error])
    {
        NSLog(@"Whoops,queryWithEntityName couldn't fetch: %@", [error localizedDescription]);
    }
	
	[request release];
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
	
	//if (![self.managedObjectContext save:&error])
    //{
        //NSLog(@"Whoops,queryWithEntityName couldn't fetch: %@", [error localizedDescription]);
    //}
	
	[request release];
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
	
	if (![self.managedObjectContext save:&error])
    {
        NSLog(@"Whoops,queryWithEntityName couldn't fetch: %@", [error localizedDescription]);
    }
	
	[request release];
	return result;
}


//开始事务
-(void)beginTransaction
{   
    isTransaction_=YES;
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
    [managedObjectContext_ rollback];
    
}


/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *)managedObjectContext {
    
    if (managedObjectContext_ != nil) {
        return managedObjectContext_;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        managedObjectContext_ = [[NSManagedObjectContext alloc] init];
        [managedObjectContext_ setPersistentStoreCoordinator:coordinator];
    }
    return managedObjectContext_;
}


/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
- (NSManagedObjectModel *)managedObjectModel {
    
    if (managedObjectModel_ != nil) {
        return managedObjectModel_;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:coreDataModelName_ withExtension:@"momd"];
    managedObjectModel_ = [[NSManagedObjectModel alloc] initWithContentsOfURL: modelURL] ;    
    return managedObjectModel_;
}


/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    
    if (persistentStoreCoordinator_ != nil) {
        return persistentStoreCoordinator_;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"LoginCoreData.sqlite"];
    NSLog(@"%@",[storeURL path]);
    NSError *error = nil;
    persistentStoreCoordinator_ = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![persistentStoreCoordinator_ addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
		
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return persistentStoreCoordinator_;
}


/**
 Returns the URL to the application's Documents directory.
 */
- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


@end
