//
//  YKGraphView.m
//  YakimbiIosTest
//
//  Created by andrea gonteri on 3/13/13.
//  Copyright (c) 2013 Andrea Gonteri. All rights reserved.
//

#import "YKGraphView.h"

@implementation YKGraphView

- (id)initWithFrame:(CGRect)frame andCapacity: (double)capacity andValue:(double)value
{
    self = [super initWithFrame:frame];
    if (self) {
        _capacity= capacity;
        _value = value;
    }
    return self;
}

-(void)setCurrentValue:(double)value
{
    _value = value;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    
	CGRect parentViewBounds = self.bounds;
	CGFloat x = CGRectGetWidth(parentViewBounds)/2;
	CGFloat y = CGRectGetHeight(parentViewBounds)*0.55;
    
    // Get the graphics context and clear it
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextClearRect(ctx, rect);
    
	// define stroke color
	CGContextSetRGBStrokeColor(ctx, 1, 1, 1, 1.0);
    
	// define line width
	CGContextSetLineWidth(ctx, 4.0);
    

    double snapshotValue = _value;
    double rawCapacity = _capacity;
    
   // double snapshotValue =50;
   // double rawCapacity = 100;
    double systemCapacity = 1;
    
	int offset = 0;
	
	double system_finish = systemCapacity*360.0/rawCapacity;
    
    
    double snapshot_start = 315.0;
    double snapshot_finish = snapshotValue *360.0/rawCapacity;;
    
 
    
    ALog(@"snapshot_start: %f \n snapshot_finish: %f", snapshot_start,snapshot_finish );
    //available space
    CGContextSetFillColor(ctx, CGColorGetComponents( [[UIColor redColor] CGColor]));
    CGContextMoveToPoint(ctx, x+2*offset, y);
    CGContextAddArc(ctx, x+2*offset, y, 100,  DEGREES_TO_RADIANS(snapshot_start), DEGREES_TO_RADIANS(snapshot_start+snapshot_finish), 0);
    CGContextClosePath(ctx);
    CGContextFillPath(ctx);
   
    
	 //used space
    CGContextSetFillColor(ctx, CGColorGetComponents( [[UIColor greenColor] CGColor]));

    CGContextMoveToPoint(ctx, x+2*offset, y);
    CGContextAddArc(ctx, x+2*offset, y, 100,  DEGREES_TO_RADIANS(snapshot_start+snapshot_finish+offset), DEGREES_TO_RADIANS(snapshot_start+system_finish+offset), 0);
    CGContextClosePath(ctx);
    CGContextFillPath(ctx);
   

}

@end
