//
//  YKDataManager.m
//  YakimbiIosTest
//
//  Created by andrea gonteri on 3/13/13.
//  Copyright (c) 2013 Andrea Gonteri. All rights reserved.
//

#import "YKDataManager.h"
#import "ISO8601DateFormatter.h"


@implementation YKDataManager

#define DATABASE_FILENAME @"YKFileManager.sqlite"

#pragma mark - Properties

@synthesize persistentStoreCoordinator =_persistentStoreCoordinator;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize managedObjectContext = _managedObjectContext;

SYNTHESIZE_SINGLETON_FOR_CLASS(YKDataManager);

#pragma mark - Data

//fill database with new data
-(void)fillCoreDataWithDictionary:(NSDictionary*)dictionary
{
    
    YKSpace *space = [NSEntityDescription insertNewObjectForEntityForName:@"YKSpace"inManagedObjectContext:self.managedObjectContext];
    
    space.availableSpace = [dictionary valueForKeyPath:@"availableSpace"];
    space.last_rev_id = [dictionary valueForKeyPath:@"last_rev_id"];
    space.mode = [dictionary valueForKeyPath:@"mode"];
    
    space.pendingRequests = [dictionary valueForKeyPath:@"pendingRequests"];
    space.rev_id = [dictionary valueForKeyPath:@"rev_id"];
    
    space.totalSpace = [dictionary valueForKeyPath:@"totalSpace"];
    space.usedSpace = [dictionary valueForKeyPath:@"usedSpace"];
    
    NSSet * set;
    YKFile * aFile;
    NSDictionary *fileDictionary = nil;
    NSMutableArray * files = nil;
    NSDictionary *fileContainerDictionary  = nil;
    
    //fill myFiles
    files = [[NSMutableArray alloc ] initWithCapacity:0];
    fileContainerDictionary = [dictionary valueForKeyPath:@"my_files"];
    
    YKFileContainer * fileContainer;
    
    fileContainer = [NSEntityDescription insertNewObjectForEntityForName:@"YKFileContainer"inManagedObjectContext:self.managedObjectContext];
    fileContainer.id = [fileContainerDictionary valueForKeyPath:@"id"];
    fileContainer.name = [fileContainerDictionary valueForKeyPath:@"name"];
    
    for (fileDictionary in [fileContainerDictionary valueForKeyPath:@"content"])
    {
        aFile = [self setYKFileWithDictionary:fileDictionary];
        [files addObject:aFile];
        
    }
  
    set = [NSSet setWithArray:files];
    [fileContainer addFiles:set];    
    
    space.myFiles = fileContainer;
    
    
    
    //fill sharedFiles
    files = [[NSMutableArray alloc ] initWithCapacity:0];
    fileContainerDictionary = [dictionary valueForKeyPath:@"shared_files"];
    
    fileContainer = [NSEntityDescription insertNewObjectForEntityForName:@"YKFileContainer"inManagedObjectContext:self.managedObjectContext];
    fileContainer.id = [fileContainerDictionary valueForKeyPath:@"id"];
    fileContainer.name = [fileContainerDictionary valueForKeyPath:@"name"];
    
    for (fileDictionary in [fileContainerDictionary valueForKeyPath:@"content"])
    {
        aFile = [self setYKFileWithDictionary:fileDictionary];
        [files addObject:aFile];
        
    }
    set = [NSSet setWithArray:files];
    [fileContainer addFiles:set];
    
    space.sharedFiles = fileContainer;
    
    
    BOOL success = [self saveContext];
    if(!success)
    {
        ULog(@"Unexpected Error during context save");
    }
    
    
}

//
- (BOOL)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil)
    {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            ULog(@"Error during context save %@, %@", error,[error localizedDescription]);
            
            abort();
            return NO;
        }
        return YES;
    }
    return NO;
}

//Create new YKFile from NSDictionary
-(YKFile*)setYKFileWithDictionary:(NSDictionary*)dictionary
{
    
    
    YKFile *file = [NSEntityDescription insertNewObjectForEntityForName:@"YKFile" inManagedObjectContext:self.managedObjectContext];
    
    ISO8601DateFormatter * dateFormatter = [[ISO8601DateFormatter alloc] init];
    
    file.created_date = [ dateFormatter dateFromString:[dictionary valueForKeyPath:@"created_date"]];
    file.is_shared = [NSNumber numberWithBool:[[dictionary valueForKeyPath:@"is_shared"] boolValue]];
    file.item_id = [dictionary valueForKeyPath:@"item_id"];
    file.last_updated_by = [dictionary valueForKeyPath:@"last_updated_by"];
    file.last_updated_date = [ dateFormatter dateFromString:[dictionary valueForKeyPath:@"last_updated_date"]];
    file.link = [dictionary valueForKeyPath:@"link"];
    file.mime_type = [dictionary valueForKeyPath:@"mime_type"];
    file.name = [dictionary valueForKeyPath:@"name"];
    id parentId = [dictionary valueForKeyPath:@"parent_id"];
    file.parent_id = ([parentId isKindOfClass:[NSNull class]]) ? nil : parentId;
    file.path = [dictionary valueForKeyPath:@"path"];
    file.path_by_id = [dictionary valueForKeyPath:@"path_by_id"];
    file.share_id = [dictionary valueForKeyPath:@"share_id"];
    id shareLevel = [dictionary valueForKeyPath:@"share_level"];
    file.share_level = ([shareLevel isKindOfClass:[NSNumber class]]) ? shareLevel : nil;
    file.shared_by = [dictionary valueForKeyPath:@"shared_by"];
    file.shared_date = [ dateFormatter dateFromString:[dictionary valueForKeyPath:@"shared_date"]];
    
    file.size = [dictionary valueForKeyPath:@"size"];
    file.status = [dictionary valueForKeyPath:@"status"];
    file.type = [dictionary valueForKeyPath:@"type"];
    file.user_id = [dictionary valueForKeyPath:@"user_id"];
    
    
    RELEASE_OBJ(dateFormatter);
    
    return file;
    
}

//Featch database records
- (void)fetchRecords
{
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"YKSpace" inManagedObjectContext:self.managedObjectContext];
    
    //Setup the fetch request
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    
    //  NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(lastName like %@) AND (birthday > %@)", lastNameSearchString, birthdaySearchDate];
    
    //apply sort
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"last_rev_id" ascending:NO];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    [request setSortDescriptors:sortDescriptors];
    RELEASE(sortDescriptor );
    // Fetch the records and handle an error
    NSError *error = nil;
    NSMutableArray *mutableFetchResults = [[self.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    if (error)
    {
        // Handle the error.
        // This is a serious error and should advise the user to restart the application
        ULog(@"ERROR during fetchRecords %@", [error localizedDescription]);
    }
    // Save our fetched data to an array
    [[YKAppManager sharedInstance] setSpaces:mutableFetchResults];
    
    
    
    RELEASE(mutableFetchResults);
    RELEASE(request);
}


//Erase the persistent store from coordinator
- (void)flushDatabase
{
        
    NSPersistentStore *store = [ self.managedObjectContext.persistentStoreCoordinator.persistentStores lastObject];
    NSError *error = nil;
    NSURL *storeURL = store.URL;
    [ self.managedObjectContext.persistentStoreCoordinator removePersistentStore:store error:&error];
    [[NSFileManager defaultManager] removeItemAtURL:storeURL error:&error];
    
    if(![ self.managedObjectContext.persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error])
    {
        ULog(@"Database clear unexpected error ");
    }    
     
    if (error)
    {
        ULog(@"Database clear error %@", [error localizedDescription]);
    }
    else
    {
        ULog(@"Local data erased succesfully");
        
        [[NSNotificationCenter defaultCenter] postNotificationName:YKDATAMANAGER_DATABASE_CLEANEDUP object:nil];
    }
    
    
}


//Returns the managed object context for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil)
    {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil)
    {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil)
    {
        return _managedObjectModel;
    }
    //    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"YKFileManager" withExtension:@"pkg"];
    //    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    //_managedObjectModel = [[NSManagedObjectModel mergedModelFromBundles:nil] retain];
    _managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil)
    {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:DATABASE_FILENAME];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
    
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        ULog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

#pragma mark - Object lifecycle

- (void)dealloc
{
    RELEASE_OBJ(_persistentStoreCoordinator);
    RELEASE_OBJ(_managedObjectContext);
    RELEASE_OBJ(_managedObjectModel);
    SUPER_DEALLOC();
}

@end
