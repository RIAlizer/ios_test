//
//  YKFileContainer.m
//  YakimbiIosTest
//
//  Created by andrea gonteri on 3/13/13.
//  Copyright (c) 2013 Andrea Gonteri. All rights reserved.
//

#import "YKFileContainer.h"


@implementation YKFileContainer

@dynamic id;
@dynamic name;
@dynamic files;
@dynamic myFileSpace;
@dynamic sharedFileSpace;

-(id)init
{
    self = [super init];
    if(self)
    {
        self.files = nil;
    }
    return self;
}

- (void)addFilesObject:(YKFile *)value
{
   //TODO: tbd 
}

- (void)removeFilesObject:(YKFile *)value
{
    //TODO: tbd
}

- (void)addFiles:(NSSet *)values
{
    self.files = values;
}

- (void)removeFiles:(NSSet *)values
{
    //TODO: tbd
}

- (void)dealloc
{
    SUPER_DEALLOC();
}

@end
