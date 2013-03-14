//
//  YKBaseViewController.m
//  YakimbiIosTest
//
//  Created by andrea gonteri on 3/11/13.
//  Copyright (c) 2013 Andrea Gonteri. All rights reserved.
//

#import "YKBaseViewController.h"

#define DEFAULT_HUD_MESSAGE								LSTR(@"Loading")
#define DEFAULT_HUD_DETAILED_MESSAGE					LSTR(@"Retrieving Data")
#define DEFAULT_HUD_PROGRESS_MODE						MBProgressHUDModeIndeterminate
#define MINIMUM_ACTIVITY_TIME_PRESENCE 1


@implementation YKBaseViewController



#pragma mark - Properties

@synthesize HUD = _HUD;


#pragma mark - Init

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    //custom init Universal Apps
    //self = [super initWithNibName: [self chooseNibName:nibNameOrNil] bundle:nibBundleOrNil];
    self = [super initWithNibName: nibNameOrNil bundle:nibBundleOrNil];
   

    if (self) {
        // Custom initialization
    }
    
    return self;
}


#pragma mark - View LifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - Private

- (NSString*)chooseNibName:(NSString*)nibName
{
    BOOL useIpadNib = NO;
    NSString * ipadNibName = nil;
    
	if (IS_IPAD)
	{
        ipadNibName = [NSString stringWithFormat:@"%@-iPad",nibName];
        //check if exist
        useIpadNib = [[NSBundle mainBundle] pathForResource:ipadNibName ofType:@"xib"] != nil;
        
    }
    
    if(useIpadNib)
    {
        return ipadNibName;
        
		
	}
	else
	{
		return nibName;
	}
}

#pragma mark Activity methods
- (void)showActivity
{
    [self showActivityWithMessage:DEFAULT_HUD_MESSAGE withDetailedMessage:DEFAULT_HUD_DETAILED_MESSAGE andProgressMode:DEFAULT_HUD_PROGRESS_MODE];
}

- (void)showActivityWithMessage:(NSString *)inputText withDetailedMessage:(NSString *)inputDetailedText andProgressMode:(MBProgressHUDMode)inputHUDMode
{
    
    if (self.HUD!=nil)
    {
        [self.HUD hide:YES];
    }
    
    
    
	
    self.HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.HUD.animationType = MBProgressHUDAnimationFade;
    [self.view addSubview:self.HUD ];
	[self.view  bringSubviewToFront:self.HUD ];
	
	// Set mode
	self.HUD.mode = inputHUDMode;
    
    // self.HUD.dimBackground = YES;
    
	self.HUD.delegate = self;
	self.HUD.labelText = inputText;
	//self.HUD.detailsLabelText = inputDetailedText;
    self.HUD.minShowTime= MINIMUM_ACTIVITY_TIME_PRESENCE;
   
    
    [ self.view  bringSubviewToFront:self.HUD];
    
    
    
}
#pragma mark MBProgressHUDDelegate

- (void)hudWasHidden
{
	// Remove HUD from screen when the HUD was hidded
    if(_HUD){
        [_HUD removeFromSuperview];
        RELEASE_OBJ(_HUD);
    }
    
}


- (void)hideActivity
{
    
    [self.HUD hide:YES];
}

#pragma mark - Memory Management

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
