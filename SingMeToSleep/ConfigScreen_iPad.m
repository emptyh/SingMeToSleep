//
//  ConfigScreen_iPad.m
//  SingMeToSleep
//
//  Created by Mike Hickman on 10/21/11.
//  Copyright (c) 2011 EmptyH Software. All rights reserved.
//

#import "ConfigScreen_iPad.h"

@implementation ConfigScreen_iPad
@synthesize minutesOfMusicSpinner;
@synthesize minutesOfMusic;
@synthesize delegate;
@synthesize minutesOfMusicText;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (IBAction)minutesOfMusicChanged:(id)sender {
    NSString *mins=[NSString stringWithFormat:@"%i",[minutesOfMusicSpinner value]];
    [[self minutesOfMusicText]setText:mins];
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
    if([[self minutesOfMusicSpinner] value]==0){
        [[self minutesOfMusicSpinner]setValue:15];
        [[self minutesOfMusicText]setText:@"15"];
    }
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setMinutesOfMusic:nil];
    [self setMinutesOfMusicText:nil];
    [self setMinutesOfMusicSpinner:nil];
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
    [minutesOfMusicText release];
    [minutesOfMusicSpinner release];
    [super dealloc];
    [minutesOfMusic release];
}


- (IBAction)backPressed:(id)sender {
    NSString *mins=[[self minutesOfMusicText]text];
    [[self delegate]dataDidChange:@"minutesOfMusic" withValue:mins];
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)minutesSpinnerChanged:(id)sender {
    int minF=[minutesOfMusicSpinner value];
    NSString *mins=[[NSString alloc] initWithFormat:@"%d",minF];
    [[self minutesOfMusicText] setText:mins];
}

@end
