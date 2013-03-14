//
//  YKSpace
//  YakimbiIosTest
//
//  Created by andrea gonteri on 3/13/13.
//  Copyright (c) 2013 Andrea Gonteri. All rights reserved.
//
 
#import <CoreData/CoreData.h>

@class YKFileContainer;

@interface YKSpace : NSManagedObject
{
  
}


@property (MB_STRONG) NSNumber * availableSpace;
@property (MB_STRONG) NSNumber * last_rev_id;
@property (MB_STRONG) NSString * mode;
@property (MB_STRONG) NSNumber * pendingRequests;
@property (MB_STRONG) NSNumber * rev_id;
@property (MB_STRONG) NSNumber * totalSpace;
@property (MB_STRONG) NSNumber * usedSpace;
@property (MB_STRONG) YKFileContainer *myFiles;
@property (MB_STRONG) YKFileContainer *sharedFiles;

@end
