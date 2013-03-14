//
//  YKViewController.m
//  YakimbiIosTest
//
//  Created by andrea gonteri on 3/13/13.
//  Copyright (c) 2013 Andrea Gonteri. All rights reserved.
//

#import "YKViewController.h"

#pragma mark - Defines

#define PULL_TO_REFRESH_VIEW_HEIGHT 65.0f
#define FOOTER_OFFSET 150.0f
#define ITEMS_PER_PAGE 20

#define CONTEXT_MY_FILES 0
#define CONTEXT_SHARED_FILES 1

#define LOADING_DELAY 1

@implementation YKViewController

#pragma mark - Properties

@synthesize tableView = _tableView;
@synthesize listFiles = _listFiles;
@synthesize totalFiles = _totalFiles;
@synthesize currentSpace = _currentSpace;

#pragma mark - Init

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle: nibBundleOrNil];
    if(self)
    {
        //register for notifications
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(emptyData) name:YKDATAMANAGER_DATABASE_CLEANEDUP object:nil];
        
        _currentPage = 0;
        _currentContext = CONTEXT_MY_FILES;

        
    }
    return self;
}

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupUI];
    
    //[self performSelector:@selector(loadData) withObject:nil afterDelay:LOADING_DELAY];
    [self loadData];
}

#pragma mark - private

-(void)setupUI
{
        
    self.navigationItem.title = LSTR(@"File Manager");
    
    [self.segmentedControl setTintColor:[UIColor darkGrayColor]];
    
    self.tableView.rowHeight = IS_IPAD? 80 : 60;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.opaque = NO;
    self.tableView.showsHorizontalScrollIndicator=NO;
    self.tableView.showsVerticalScrollIndicator=YES;
    
    
    UIButton * btnInfo = [UIButton buttonWithType:UIButtonTypeInfoLight];
    [btnInfo addTarget:self action:@selector(showInfoView) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnInfo];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    RELEASE_OBJ(rightBarButtonItem);
    
    [self addPullToRefreshView];
}


-(void)showInfoView
{
    YKInfoViewController * infoViewController = [[YKInfoViewController alloc] initWithNibName:@"YKInfoViewController" bundle:nil];
    
    if(IS_IPAD)
    {
        UINavigationController *popoverNavigationController = AUTORELEASE([[UINavigationController alloc] initWithRootViewController:infoViewController]);
        _infoViewPopover = [[UIPopoverController alloc] initWithContentViewController:popoverNavigationController];
        [_infoViewPopover presentPopoverFromBarButtonItem:self.navigationItem.rightBarButtonItem permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        
    }
    else
    {
        [self.navigationController pushViewController:infoViewController animated:YES];
    }
    
    [infoViewController setCurrentSpace:self.currentSpace];
    
    RELEASE_OBJ(infoViewController);
}

-(void)addPullToRefreshView
{
    //refresh header
	_refreshHeaderView = [[PullToRefreshHeaderView alloc] initWithFrame: CGRectMake(0.0f, 0.0f - self.view.bounds.size.height, self.view.bounds.size.width, self.view.bounds.size.height)];
    _refreshHeaderView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
	[self.tableView addSubview:_refreshHeaderView];
	self.tableView.showsVerticalScrollIndicator = YES;
    
    RELEASE(_refreshHeaderView);
}

-(void)emptyData
{
    [_infoViewPopover dismissPopoverAnimated:YES];
    
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    [self.listFiles removeAllObjects ];
    [self.tableView reloadData];

    self.labelEmpty.hidden = NO;
   
}

-(void)loadData
{
    [self showActivity];
    
    NSString * context;
    
    if(_currentContext == CONTEXT_MY_FILES){
        context = [NSString stringWithFormat:@"my_files"];
    }
    else{
        context = [NSString stringWithFormat:@"shared_files"];
    }
    
    
    [[YKAppManager sharedInstance] loadData:context
                                 completion:^(id responseObject){
                                     
                                     @try
                                     {
                                         NSString *className = NSStringFromClass([responseObject class]);
                                         ALog(@"%@", className);
                                         
                                         if([responseObject isKindOfClass:[YKSpace class]])
                                         {
                                             
                                             self.currentSpace = (YKSpace*)responseObject;
                                             
                                             self.navigationItem.rightBarButtonItem.enabled = YES;
                                             
                                             [self updateDataSource];
                                             
                                         }
                                         else
                                         {
                                             [[NSException exceptionWithName:@"Unexpected" reason:@"Type not defined" userInfo:responseObject] raise];
                                             
                                         }
                                         
                                     }
                                     @catch (NSException *exception)
                                     {
                                         [YKAppManager showException:exception];
                                     }
                                     
                                     [self hideActivity];
                                     [self dataSourceDidFinishLoadingNewData ];
                                     
                                 }
                                    failure:^(NSError *err, NSDictionary *dictResponse){
                                        [self hideActivity];
                                        [self dataSourceDidFinishLoadingNewData ];
                                        
                                        ULog(@"Error during loading remote data\n%@", [err localizedDescription]);
                                    }];
    
    
    
}

-(YKFileContainer*)getFileContainerFromSpace
{
    switch (self.segmentedControl.selectedSegmentIndex)
    {
        case CONTEXT_MY_FILES:
            return self.currentSpace.myFiles;
            break;
        case CONTEXT_SHARED_FILES:
            return self.currentSpace.sharedFiles;
            break;
            
    }
    return nil;
}

-(void)updateDataSource
{
    
    
    YKFileContainer * currentFileContainer = [self getFileContainerFromSpace];
    
    NSSet * currentSet = currentFileContainer.files;
    
   // self.totalFiles = [[NSArray alloc ] initWithArray: [currentSet allObjects] ];
    
    NSSortDescriptor* desc = [[NSSortDescriptor alloc] initWithKey:@"last_updated_date" ascending:NO];
    NSArray * sortedFiles = [[currentSet allObjects] sortedArrayUsingDescriptors:[NSArray arrayWithObject:desc]];
    RELEASE_OBJ(desc);
    
    self.totalFiles = [[NSArray alloc ] initWithArray: sortedFiles ];
    
    _currentPage = 1;
    
    if([self.totalFiles count] > ITEMS_PER_PAGE)
    {
        
        
        self.listFiles = [[NSMutableArray alloc] initWithArray:[self.totalFiles subarrayWithRange:NSMakeRange(0, ITEMS_PER_PAGE)]];
    }
    else
    {
        self.listFiles = [[NSMutableArray alloc] initWithArray:self.totalFiles];
    }
    
    ALog(@"%d items", [self.listFiles count]);
    
    [self.tableView reloadData];
    
    BOOL isEmpty =  [self.listFiles count]==0;
    self.labelEmpty.hidden = !isEmpty;
   
    
}

-(void)loadNextPage
{
    int nextStartIndex = _currentPage * ITEMS_PER_PAGE;
    if([self.totalFiles count] > nextStartIndex)
    {
        [self showActivity];
        
        _currentPage +=1;
        NSDictionary * item;
        
        int totalCount = MIN([self.totalFiles count] - nextStartIndex, ITEMS_PER_PAGE);
        
        NSArray * nextSubset = [self.totalFiles subarrayWithRange:NSMakeRange(nextStartIndex, totalCount)];
        
        for (item in nextSubset)
        {
            [self.listFiles addObject:item];
        }
        
        ALog(@"%d items", [self.listFiles count]);
        
        [self.tableView reloadData];
        [self.tableView setNeedsDisplay];
        [self.tableView flashScrollIndicators];
        
        // [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_currentPage * ITEMS_PER_PAGE inSection:1] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
        
        [self hideActivity];
        
    }
    
}

#pragma mark - UITableViewDataSource



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return [self.listFiles count];
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"YKFileCell";
    
    YKFileCell *customCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (customCell == nil)
    {
        customCell = [[[NSBundle mainBundle] loadNibNamed:@"YKFileCell" owner:self options:nil] objectAtIndex:0];
    }
    
    YKFile *item = [self.listFiles objectAtIndex:indexPath.row];
    
    [customCell setItem:item];
    
    
    
    return customCell;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   // YKFile *item = [self.listFiles objectAtIndex:indexPath.row];
    
    YKDetailViewController * detailViewController = [[YKDetailViewController alloc] initWithNibName:@"YKDetailViewController" bundle:nil];
    
    if(!IS_IPAD)
    {
        [self.navigationController pushViewController:detailViewController animated:YES];
        
        
    }
    else
    {
        UINavigationController *popoverNavigationController = AUTORELEASE([[UINavigationController alloc] initWithRootViewController:detailViewController]);
        
        UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:popoverNavigationController];
        
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        CGRect rect=CGRectMake(cell.bounds.origin.x+600, cell.bounds.origin.y+10, 50, 30);
        [popover presentPopoverFromRect:rect inView:cell permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        
        
        
        
    }
    RELEASE_OBJ(detailViewController);
    
}




#pragma mark State Changes

- (void)showReloadAnimationAnimated:(BOOL)animated
{
	_reloading = YES;
	[_refreshHeaderView toggleActivityView:YES];
	
	if (animated)
	{
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.2];
		self.tableView.contentInset = UIEdgeInsetsMake(60.0f, 0.0f, 0.0f,
                                                       0.0f);
		[UIView commitAnimations];
	}
	else
	{
		self.tableView.contentInset = UIEdgeInsetsMake(60.0f, 0.0f, 0.0f,
                                                       0.0f);
	}
}


#pragma mark - PullTorefresh

- (void)dataSourceDidFinishLoadingNewData
{
	_reloading = NO;
	[_refreshHeaderView flipImageAnimated:NO];
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.3];
	[self.tableView setContentInset:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f)];
	[_refreshHeaderView setStatus:kPullToReloadStatus];
	[_refreshHeaderView toggleActivityView:NO];
	[UIView commitAnimations];
    
}


#pragma mark Scrolling Overrides

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
	if (!_reloading)
	{
		_checkForRefresh = YES;  //  only check offset when dragging
	}
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	if (_reloading) return;
	
	if (_checkForRefresh) {
		if (_refreshHeaderView.isFlipped
			&& scrollView.contentOffset.y > - PULL_TO_REFRESH_VIEW_HEIGHT
			&&  scrollView.contentOffset.y < 0.0f
			&&  !_reloading) {
			[_refreshHeaderView flipImageAnimated:YES];
			[_refreshHeaderView setStatus:kPullToReloadStatus];
            
			
		} else if (!_refreshHeaderView.isFlipped
                   &&  scrollView.contentOffset.y > -65.0f) {
			[_refreshHeaderView flipImageAnimated:YES];
			[_refreshHeaderView setStatus:kReleaseToReloadStatus];
            
		}
	}
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView
				  willDecelerate:(BOOL)decelerate
{
	if (_reloading) return;
	
	if (scrollView.contentOffset.y <= - PULL_TO_REFRESH_VIEW_HEIGHT)
    {
		if([self.tableView.dataSource respondsToSelector:@selector(loadData)])
        {
			[self showReloadAnimationAnimated:YES];
            
			[self performSelector:@selector(loadData) withObject:nil afterDelay:LOADING_DELAY];
		}
	}
    
	_checkForRefresh = NO;
}

- (void)scrollViewDidEndDecelerating:(UITableView *)tableView
{
    if (self.tableView.contentOffset.y > FOOTER_OFFSET) {
        // Fetch data
        [self loadNextPage];
    }
}



#pragma mark - Actions

- (IBAction)segmentedControlChange:(id)sender
{
    if(_currentContext == self.segmentedControl.selectedSegmentIndex) return;
    
    _currentContext = self.segmentedControl.selectedSegmentIndex;
    
    switch (_currentContext) {
        case CONTEXT_MY_FILES:{
            [self updateDataSource];
            break;
        }
        case CONTEXT_SHARED_FILES:{
            [self updateDataSource];
            break;
        }
    }
    
    
}

#pragma mark - Memory Management

-(void)viewDidUnload
{
    [self setTableView:nil];
    [self setSegmentedControl:nil];
    [self setLabelEmpty:nil];
    [super viewDidUnload];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:YKDATAMANAGER_DATABASE_CLEANEDUP object:nil];
    RELEASE_OBJ(_refreshHeaderView);
    RELEASE_OBJ(_tableView);
    RELEASE_OBJ(_segmentedControl);
    RELEASE_OBJ(_labelEmpty );
    SUPER_DEALLOC();
}


@end
