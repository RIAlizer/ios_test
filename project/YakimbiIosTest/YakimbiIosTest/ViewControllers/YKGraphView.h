//
//  YKGraphView.h
//  YakimbiIosTest
//
//  Created by andrea gonteri on 3/13/13.
//  Copyright (c) 2013 Andrea Gonteri. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YKGraphView : UIView
{
    double _capacity;
    double _value;
    
}

- (id)initWithFrame:(CGRect)frame andCapacity: (double)capacity andValue:(double)value;
-(void)setCurrentValue:(double)value;

@end
