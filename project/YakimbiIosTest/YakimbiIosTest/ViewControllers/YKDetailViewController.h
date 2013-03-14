//
//  YKDetailViewController.h
//  YakimbiIosTest
//
//  Created by andrea gonteri on 3/13/13.
//  Copyright (c) 2013 Andrea Gonteri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YKBaseViewController.h"


@interface YKDetailViewController : YKBaseViewController<UITableViewDataSource, UITableViewDelegate>
{
    UITableView * _tableView;
    int _numRows;

}

@property (MB_STRONG) IBOutlet UITableView *tableView;
@end
