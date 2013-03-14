//
//  YKFile.h
//  YakimbiIosTest
//
//  Created by andrea gonteri on 3/13/13.
//  Copyright (c) 2013 Andrea Gonteri. All rights reserved.
//

 
#import <CoreData/CoreData.h>

@class YKFileContainer;

@interface YKFile : NSManagedObject
{

}

@property (MB_STRONG) NSDate * created_date;
@property (MB_STRONG) NSNumber * is_shared;
@property (MB_STRONG) NSNumber * item_id;
@property (MB_STRONG) NSString * last_updated_by;
@property (MB_STRONG) NSDate * last_updated_date;
@property (MB_STRONG) NSString * link;
@property (MB_STRONG) NSString * mime_type;
@property (MB_STRONG) NSString * name;
@property (MB_STRONG) NSNumber * parent_id;
@property (MB_STRONG) NSString * path;
@property (MB_STRONG) NSString * path_by_id;
@property (MB_STRONG) NSString * share_id;
@property (MB_STRONG) NSNumber * share_level;
@property (MB_STRONG) NSNumber * shared_by;
@property (MB_STRONG) NSDate * shared_date;
@property (MB_STRONG) NSNumber * size;
@property (MB_STRONG) NSString * status;
@property (MB_STRONG) NSString * type;
@property (MB_STRONG) NSNumber * user_id;
@property (MB_STRONG) YKFileContainer *fileContainer;    
 
@end
