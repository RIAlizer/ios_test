//
//  YKFileContainer.h
//  YakimbiIosTest
//
//  Created by andrea gonteri on 3/13/13.
//  Copyright (c) 2013 Andrea Gonteri. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class YKFile, YKSpace;

@interface YKFileContainer : NSManagedObject

@property (MB_STRONG) NSString * id;
@property (MB_STRONG) NSString * name;
@property (MB_STRONG) NSSet *files;
@property (MB_STRONG) YKSpace *myFileSpace;
@property (MB_STRONG) YKSpace *sharedFileSpace;

@end

@interface YKFileContainer (CoreDataGeneratedAccessors)

- (void)addFilesObject:(YKFile *)value;
- (void)removeFilesObject:(YKFile *)value;
- (void)addFiles:(NSSet *)values;
- (void)removeFiles:(NSSet *)values;

@end