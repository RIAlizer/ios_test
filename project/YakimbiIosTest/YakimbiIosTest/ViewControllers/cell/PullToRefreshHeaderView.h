//
//  PullToRefreshHeaderView.h
 
//
//  Created by andrea gonteri on 10/19/11.
//  Copyright 2011 /*
 
//

#import <Foundation/Foundation.h>
#define kReleaseToReloadStatus	0
#define kPullToReloadStatus		1
#define kLoadingStatus			2

@interface PullToRefreshHeaderView : UIView {
	
	UILabel *lastUpdatedLabel;
	UILabel *statusLabel;
	UIImageView *arrowImage;
	UIActivityIndicatorView *activityView;
	
	BOOL isFlipped;
	
	NSDate *lastUpdatedDate;
}
@property BOOL isFlipped;

@property (MB_STRONG) NSDate *lastUpdatedDate;

- (void)flipImageAnimated:(BOOL)animated;
- (void)toggleActivityView:(BOOL)isON;
- (void)setStatus:(int)status;

@end