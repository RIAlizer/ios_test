//
//  YKFile.m
//  YakimbiIosTest
//
//  Created by andrea gonteri on 3/13/13.
//  Copyright (c) 2013 Andrea Gonteri. All rights reserved.
//

#import "YKFile.h"



@implementation YKFile

#pragma mark - Properties

@dynamic created_date;
@dynamic is_shared;
@dynamic item_id;
@dynamic last_updated_by;
@dynamic last_updated_date;
@dynamic link;
@dynamic mime_type;
@dynamic name;
@dynamic parent_id;
@dynamic path;
@dynamic path_by_id;
@dynamic share_id;
@dynamic share_level;
@dynamic shared_by;
@dynamic shared_date;
@dynamic size;
@dynamic status;
@dynamic type;
@dynamic user_id;
@dynamic fileContainer;

#pragma mark - Object lifecycle

- (void)dealloc
{

    SUPER_DEALLOC();
}

@end
