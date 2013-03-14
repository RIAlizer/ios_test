//
//  YKViewController.h
//  YakimbiIosTest
//
//  Created by andrea gonteri on 3/13/13.
//  Copyright (c) 2013 Andrea Gonteri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YKBaseViewController.h"
#import "YKDetailViewController.h"
#import "YKFileCell.h"
#import "PullToRefreshHeaderView.h"
#import "YKFileContainer.h"
#import "YKFile.h"
#import "YKSpace.h"
#import "YKInfoViewController.h"

@interface YKViewController : YKBaseViewController<UITableViewDataSource, UITableViewDelegate, UIPopoverControllerDelegate>
{
    UITableView * _tableView;
    NSMutableArray * _listFiles;
    NSArray * _totalFiles;
    
    PullToRefreshHeaderView * _refreshHeaderView;
    BOOL _reloading;
    BOOL _checkForRefresh;
    int _currentPage;
    int _currentContext;
    YKSpace * _currentSpace;
    UIPopoverController * _infoViewPopover;

}

@property (MB_STRONG) IBOutlet UILabel *labelEmpty;
@property (MB_STRONG) IBOutlet UITableView *tableView;
@property (MB_STRONG) IBOutlet UISegmentedControl *segmentedControl;
@property (MB_STRONG) NSMutableArray * listFiles;
@property (MB_STRONG) YKSpace * currentSpace;
@property (MB_STRONG) NSArray * totalFiles;

- (IBAction)segmentedControlChange:(id)sender;

@end
