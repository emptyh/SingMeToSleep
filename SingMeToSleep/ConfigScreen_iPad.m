//
//  ConfigScreen_iPad.m
//  SingMeToSleep
//
//  Created by Mike Hickman on 10/21/11.
//  Copyright (c) 2011 Hobsons. All rights reserved.
//

#import "ConfigScreen_iPad.h"

@implementation ConfigScreen_iPad
@synthesize minutesOfMusic;
@synthesize delegate;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(id)initWithDelegate:(id<DataChanged>)delegate{
    self = [super init];
    if (self) {
        [self setDelegate:delegate];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setMinutesOfMusic:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}


- (void)dealloc {    
    [super dealloc];
    [minutesOfMusic release];
}
- (IBAction)minutesChanged:(id)sender {
}

- (IBAction)backPressed:(id)sender {
    [[self delegate]dataDidChange:@"minutesOfMusic" withValue:[[self minutesOfMusic]text]];
    [self dismissModalViewControllerAnimated:YES];
}
@end
