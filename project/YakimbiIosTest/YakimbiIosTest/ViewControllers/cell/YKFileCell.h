//
//  YKFileCell.h
//  YakimbiIosTest
//
//  Created by andrea gonteri on 3/13/13.
//  Copyright (c) 2013 Andrea Gonteri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YKFile.h"

@interface YKFileCell : UITableViewCell
{
    YKFile *_item;
    
}
@property (MB_STRONG) YKFile *item;
@property (MB_STRONG) IBOutlet UILabel *labelTitle;
@property (MB_STRONG) IBOutlet UILabel *labelSubtitle;
@property (MB_STRONG) IBOutlet UIImageView *imageViewStatus;

@end
