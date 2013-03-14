//
//  YKInfoViewController.m
//  YakimbiIosTest
//
//  Created by andrea gonteri on 3/13/13.
//  Copyright (c) 2013 Andrea Gonteri. All rights reserved.
//

#import "YKInfoViewController.h"



@implementation YKInfoViewController

@synthesize currentSpace = _currentSpace;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = LSTR(@"Space Info");
    [self.btnErase setTintColor:[UIColor redColor]];
}

-(void)setCurrentSpace:(YKSpace *)currentSpace
{
    _currentSpace = currentSpace;
    
    self.labelMainInfo.text = [NSString stringWithFormat:@"Space mode: %@ revision: %d", _currentSpace.mode, [_currentSpace.rev_id intValue]];
    
    
    self.sliderTest.maximumValue = 99.999;
    self.sliderTest.minimumValue = 0.1;

    double percentValue = ([_currentSpace.usedSpace longLongValue] *100)/[_currentSpace.totalSpace longLongValue];
    
    self.sliderTest.value = percentValue;
    [self updateUsedSpace:[NSNumber numberWithDouble:percentValue]];
    
    
    
    self.labelAvailable.text = [NSString stringWithFormat:@"Available %@", [YKAppManager showFileSize:_currentSpace.availableSpace] ];
    self.labelAvailable.textColor = [UIColor greenColor];
    
        
    self.labelTotal.text = [NSString stringWithFormat:@"Total %@", [YKAppManager showFileSize:_currentSpace.totalSpace] ];
    self.labelTotal.textColor = [UIColor whiteColor];
    
    NSNumber *usedSpace = [NSNumber numberWithLongLong: [_currentSpace.usedSpace longLongValue]];
    self.labelUsed.text = [NSString stringWithFormat:@"Used %@", [YKAppManager showFileSize:usedSpace] ];
    self.labelUsed.textColor = [UIColor redColor];
    
    _graphView = [[YKGraphView alloc] initWithFrame:self.graphViewContainer.frame andCapacity:[_currentSpace.totalSpace doubleValue] andValue:[usedSpace doubleValue]];
    _graphView.backgroundColor = [UIColor clearColor];
    [self.graphViewContainer addSubview:_graphView];
    
    RELEASE(_graphView);

    
}

-(void)updateUsedSpace:(NSNumber*) usedSpace
{
    self.labelPercent.text = [NSString stringWithFormat:@" %.2f %%", [usedSpace doubleValue] ];
}




#pragma mark - Actions

- (IBAction)sliderValueChanged:(id)sender
{
    float newValue = self.sliderTest.value;
    
    float percentValue = (newValue * [_currentSpace.totalSpace longLongValue])/100;
    
    [_graphView setCurrentValue:percentValue];
    
    [self updateUsedSpace:[NSNumber numberWithFloat:newValue]];
}

- (IBAction)eraseData:(id)sender
{
    [[YKDataManager sharedInstance] flushDatabase];
    
}


#pragma mark - Memory Management

- (void)viewDidUnload {
    [self setLabelTotal:nil];
    [self setLabelUsed:nil];
    [self setLabelAvailable:nil];
    [self setSliderTest:nil];
    [self setGraphViewContainer:nil];
    [self setLabelPercent:nil];
    [self setLabelMainInfo:nil];
    [self setBtnErase:nil];
    [super viewDidUnload];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    RELEASE_OBJ(_labelTotal);
    RELEASE_OBJ(_labelUsed);
    RELEASE_OBJ(_labelAvailable);
    RELEASE_OBJ(_sliderTest);
    RELEASE_OBJ(_graphViewContainer);
    RELEASE_OBJ(_labelPercent);
    RELEASE_OBJ(_labelMainInfo);
    RELEASE_OBJ(_btnErase);
    SUPER_DEALLOC();
}
@end
