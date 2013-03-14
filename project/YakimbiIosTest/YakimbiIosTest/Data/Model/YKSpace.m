//
//  YKSpace
//  YakimbiIosTest
//
//  Created by andrea gonteri on 3/13/13.
//  Copyright (c) 2013 Andrea Gonteri. All rights reserved.
//

#import "YKSpace.h"



@implementation YKSpace

#pragma mark - Properties

@dynamic availableSpace;
@dynamic last_rev_id;
@dynamic mode;
@dynamic pendingRequests;
@dynamic rev_id;
@dynamic totalSpace;
@dynamic usedSpace;
@dynamic myFiles;
@dynamic sharedFiles;

#pragma mark - Object lifecycle



- (void)dealloc
{

    SUPER_DEALLOC();
}

@end
