//
//  YKBaseViewController.h
//  YakimbiIosTest
//
//  Created by andrea gonteri on 3/11/13.
//  Copyright (c) 2013 Andrea Gonteri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface YKBaseViewController : UIViewController <MBProgressHUDDelegate>
{
    
    MBProgressHUD *_HUD;
}


@property (MB_STRONG) MBProgressHUD * HUD;

- (void)showActivity;

- (void)hideActivity;


@end
