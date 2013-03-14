//
//  YKInfoViewController.h
//  YakimbiIosTest
//
//  Created by andrea gonteri on 3/13/13.
//  Copyright (c) 2013 Andrea Gonteri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YKGraphView.h"
#import "YKSpace.h"
#import "YKDataManager.h"


@interface YKInfoViewController : UIViewController
{
    YKSpace * _currentSpace;
    YKGraphView * _graphView;
}
@property (MB_STRONG)YKSpace * currentSpace;
@property (MB_STRONG) IBOutlet UILabel *labelMainInfo;
@property (MB_STRONG) IBOutlet UILabel *labelTotal;
@property (MB_STRONG) IBOutlet UILabel *labelUsed;
@property (MB_STRONG) IBOutlet UILabel *labelAvailable;
@property (MB_STRONG) IBOutlet UILabel *labelPercent;
@property (MB_STRONG) IBOutlet UISlider *sliderTest;
@property (MB_STRONG) IBOutlet UIView *graphViewContainer;
@property (MB_STRONG) IBOutlet UIButton *btnErase;

- (IBAction)sliderValueChanged:(id)sender;
- (IBAction)eraseData:(id)sender;

@end
