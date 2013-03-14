//
//  VTAppManager.m
//  YakimbiIosTest
//
//  Created by andrea gonteri on 3/13/13.
//  Copyright (c) 2013 Andrea Gonteri. All rights reserved.
//

#import "YKAppManager.h"
#import "YKDataManager.h"


@implementation YKAppManager

#pragma mark - Properties

@synthesize spaces = _spaces;
@synthesize currentSpace = _currentSpace;



SYNTHESIZE_SINGLETON_FOR_CLASS(YKAppManager);

-(void)initAppData
{
    self.currentSpace = nil;
    
}

#pragma mark - Data

-(void)loadData:(NSString*)identifier completion:(void (^)(id))success failure:(void (^)(NSError *err, NSDictionary* dictResponse))failure
{
     NSError *error = nil;
    
    [[YKDataManager sharedInstance]fetchRecords];
    
    if(IsEmpty( self.spaces))
    {
       
        
        
        
        NSData* responseData = [NSData dataWithContentsOfURL: [NSURL URLWithString:ENDPOINT]];
        
        if (!responseData) {
            
            
            error = [NSError errorWithDomain:@"com.joinpad.yk" code:100 userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"Uops! Verify your internet connection!", @"localizedDescription", nil]];
            failure(error,nil);
            return;
        }
        
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
        
        
        if(error)
        {
            ALog(@"ERROR %@",[error localizedDescription]);
        }
        else
        {
            
            //[[YKDataManager sharedInstance] fetchRecords];
            
            [[YKDataManager sharedInstance] fillCoreDataWithDictionary:json];
            
        }
    }
    
     [[YKDataManager sharedInstance]fetchRecords];
    
    if(error)
    {
        ALog(@"Error during loading remote data\n%@", [error localizedDescription]);
        failure(error,nil);
    }
    else
    {
        
        
        success(self.currentSpace);
    }
    
}

-(void)setCurrentSpace:(YKSpace *)currentSpace
{
    _currentSpace = currentSpace;
    
}

-(void)setSpaces:(NSArray *)spaces
{
    _spaces = [[NSArray alloc] initWithArray:spaces];
    if(!IsEmpty(_spaces))
    {
        [self setCurrentSpace:[_spaces objectAtIndex:0]];
    }
}


#pragma mark - Private Methods

-(void)loadRemoteData:(NSString*)identifier error:(NSError **)error;
{
    NSError * innerError = nil;
    
    NSData* responseData = [NSData dataWithContentsOfURL: [NSURL URLWithString:ENDPOINT]];
    
    
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&innerError];
    
    /*
     NSDictionary * my_files = [json objectForKey:identifier];
     
     NSArray *listFiles = [my_files objectForKey:@"content"];
     
     NSLog(@"loans: %@", listFiles);
     */
    
    if(innerError)
    {
        ALog(@"ERROR %@",[innerError localizedDescription]);
    }
    else
    {
        
        //[[YKDataManager sharedInstance] fetchRecords];
        
        [[YKDataManager sharedInstance] fillCoreDataWithDictionary:json];
        
    }
}

#pragma mark - Static Methods


+(NSString*)showFileSize:(id)value
{
    double convertedValue = [value doubleValue];
    int multiplyFactor = 0;
    
    NSArray *tokens = [NSArray arrayWithObjects:@"bytes",@"Kb",@"Mb",@"Gb",@"Tb",nil];
    
    while (convertedValue > 1024) {
        convertedValue /= 1024;
        multiplyFactor++;
    }
    
    return [NSString stringWithFormat:@"%4.2f %@",convertedValue, [tokens objectAtIndex:multiplyFactor]];
}


+(void)showError:(NSError*)error
{
    //ULog(@" ************* NSError: Caught %@:", error);
    
    [YKAppManager showException:[NSException exceptionWithName:@"Error" reason:[error localizedDescription] userInfo:[error userInfo]]];
}

+(void)showException:(NSException*)exception
{
    ULog(@" ************* NSException: Caught %@: %@", [exception name], [exception reason]);
    
    /*
     #if ENABLE_BUGSENSE
     BUGSENSE_LOG(exception, data);
     #endif
     */
}


#pragma mark - Object lifecycle

- (void)dealloc
{
    RELEASE_OBJ(_spaces);
    RELEASE_OBJ(_currentSpace);
    SUPER_DEALLOC();
}

@end
