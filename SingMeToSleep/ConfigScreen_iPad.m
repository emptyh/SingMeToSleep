//
//  ConfigScreen_iPad.m
//  SingMeToSleep
//
//  Created by Mike Hickman on 10/21/11.
//  Copyright (c) 2011 EmptyH Software. All rights reserved.
//

#import "ConfigScreen_iPad.h"
#import "SingMeToSleepAppDelegate.h"

@implementation ConfigScreen_iPad
@synthesize minutesOfMusicSpinner;
@synthesize minutesOfMusicText;
@synthesize delegate;
@synthesize shuffleSwitch;
@synthesize floydProtectionSwitch;


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
    SingMeToSleepAppDelegate *delagate=[[UIApplication sharedApplication]delegate];
    NSMutableDictionary *config=[delagate config];
    BOOL floydProtection=[[config valueForKey:@"floydProtection"]boolValue];
    BOOL shuffle=[[config valueForKey:@"shuffle"]boolValue];
    NSString *minutesOfMusic=[config valueForKey:@"minutesOfMusic"];
    [[self minutesOfMusicText]setText:minutesOfMusic];
    [[self minutesOfMusicSpinner]setValue:[minutesOfMusic intValue]];
    [[self shuffleSwitch]setOn:shuffle];
    [[self floydProtectionSwitch]setOn:floydProtection];
    
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setMinutesOfMusic:nil];
    [self setMinutesOfMusicText:nil];
    [self setMinutesOfMusicSpinner:nil];
    [self setShuffleSwitch:nil];
    [self setFloydProtectionSwitch:nil];
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
    [shuffleSwitch release];
    [floydProtectionSwitch release];
    [super dealloc];
}


- (IBAction)backPressed:(id)sender {
    NSString *mins=[[self minutesOfMusicText]text];
    SingMeToSleepAppDelegate *appDelegate=[[UIApplication sharedApplication]delegate];
    NSMutableDictionary *config=[appDelegate config];
    [config setValue:mins forKey:@"minutesOfMusic"];
    BOOL shuffle=[shuffleSwitch isOn];
    BOOL floydProtection=[floydProtectionSwitch isOn];
    [config setValue:[NSNumber numberWithBool:shuffle] forKey:@"shuffle"];
    [config setValue:[NSNumber numberWithBool:floydProtection] forKey:@"floydProtection"];
    [appDelegate setConfig:config];
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    [userDefault setValue:config forKey:@"config"];
    [delegate configScreenDidUnload];
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)minutesSpinnerChanged:(id)sender {
    int minF=[minutesOfMusicSpinner value];
    NSString *mins=[[NSString alloc] initWithFormat:@"%d",minF];
    [[self minutesOfMusicText] setText:mins];
}

@end
