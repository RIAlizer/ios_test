//
//  YKAppManager.h
//  YakimbiIosTest
//
//  Created by andrea gonteri on 3/13/13.
//  Copyright (c) 2013 Andrea Gonteri. All rights reserved.
//


#import "SingletonHelper.h"
 
/**
 `VTAppManager` is a singleton class that perform all resources's download in background from SharePoint.
 */
@class YKDataManager, YKSpace;

@interface YKAppManager : NSObject
{
    NSArray * _spaces;
    YKSpace * _currentSpace;
  
}

@property (MB_STRONG) NSArray * spaces;
@property (MB_STRONG) YKSpace * currentSpace;

///--------------
/// @name Class Methods
///--------------

/**
 Shared instance
 
 Return a singleton `VTDownloadManager`
 */

+ (YKAppManager *)sharedInstance;

-(void)initAppData;
-(void)loadData:(NSString*)identifier completion:(void (^)(id))success failure:(void (^)(NSError *err, NSDictionary* dictResponse))failure;

+(NSString*)showFileSize:(id)value;
+(void)showError:(NSError*)error;
+(void)showException:(NSException*)exception;

@end
