//
//  YKFileCell.m
//  YakimbiIosTest
//
//  Created by andrea gonteri on 3/13/13.
//  Copyright (c) 2013 Andrea Gonteri. All rights reserved.
//

#import "YKFileCell.h"
#import "ISO8601DateFormatter.h"

@implementation YKFileCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
	{
        // Initialization code
        
    }
    return self;
}

-(void)setItem:(YKFile *)item
{
    NSParameterAssert(item);
    
    self.labelTitle.text = item.name;
    
    if(IS_IPAD)
    {
        ISO8601DateFormatter *dateFormatter = [[ISO8601DateFormatter alloc] init];
        
        NSString * formattedDate = [dateFormatter stringFromDate:item.last_updated_date];
        RELEASE_OBJ(dateFormatter);
        
        self.labelSubtitle.text = [NSString stringWithFormat:@"%@\t updated %@\t by %@", [YKAppManager showFileSize:item.size], formattedDate , item.last_updated_by ];
    }
    else
    {
        self.labelSubtitle.text = [NSString stringWithFormat:@"%@", [YKAppManager showFileSize:item.size] ];
    }
    
    
    NSString * statusImage = @"cubeGray.png";
    
    NSString * status = item.status;
    
    if([status isEqualToString:@"new"])
    {
        statusImage = @"cubeGreen.png";
    }
    else if([status isEqualToString:@"update"]|| [status isEqualToString:@"move"])
    {
        statusImage = @"cubeOrange.png";
    }
    else if([status isEqualToString:@"remove"])
    {
        statusImage = @"cubeRed.png";
    }
    
    self.imageViewStatus.image = [UIImage imageNamed:statusImage];
    
}

- (void)dealloc
{
    RELEASE_OBJ(_labelTitle);
    RELEASE_OBJ(_labelSubtitle);
    RELEASE_OBJ(_imageViewStatus);
    SUPER_DEALLOC();

}

@end
