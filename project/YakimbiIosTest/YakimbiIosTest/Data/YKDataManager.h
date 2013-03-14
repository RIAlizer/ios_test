//
//  YKDataManager.h
//  YakimbiIosTest
//
//  Created by andrea gonteri on 3/13/13.
//  Copyright (c) 2013 Andrea Gonteri. All rights reserved.
//


#import "SingletonHelper.h"
#import "YKFile.h"
#import "YKSpace.h"
#import "YKFileContainer.h"

/**
 `YKDataManager` is a singleton class that manage CoreData persisting behaviour.
 */

#define YKDATAMANAGER_DATABASE_CLEANEDUP @"DATABASE_CLEANEDUP"

@interface YKDataManager : NSObject
{

    NSPersistentStoreCoordinator *_persistentStoreCoordinator;
    NSManagedObjectModel *_managedObjectModel;
    NSManagedObjectContext *_managedObjectContext;
}


@property (MB_STRONG) NSPersistentStoreCoordinator * persistentStoreCoordinator;
@property (MB_STRONG) NSManagedObjectModel * managedObjectModel;
@property (MB_STRONG) NSManagedObjectContext * managedObjectContext;

///--------------
/// @name Class Methods
///--------------

/**
 Shared instance
 
 Return a singleton `YKDataManager`
 */

+ (YKDataManager *)sharedInstance;



-(void)fillCoreDataWithDictionary:(NSDictionary*)dictionary;

- (void)fetchRecords;

- (void)flushDatabase;

@end
