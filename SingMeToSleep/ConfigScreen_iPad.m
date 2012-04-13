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
@synthesize millitaryTime;
@synthesize SundayLabel;
@synthesize MondayLabel;
@synthesize TuesdayLabel;
@synthesize WedLabel;
@synthesize ThursdayLabel;
@synthesize FridayLabel;
@synthesize SaturdayLabel;
@synthesize timeSelector;


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
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    NSMutableDictionary *config=[userDefault valueForKey:@"config"];
    BOOL floydProtection=[[config valueForKey:@"floydProtection"]boolValue];
    BOOL shuffle=[[config valueForKey:@"shuffle"]boolValue];
    BOOL millitaryTime=[[config valueForKey:@"millitaryTime"]boolValue];
    NSMutableDictionary *alarm=[config valueForKey:@"alarm"];
    NSMutableArray *daysActive=[alarm valueForKey:@"daysActive"];
    NSNumber *on=[[NSNumber alloc]initWithInt:1];
    NSString *alarmTime=[alarm valueForKey:@"alarmTime"];
    NSDateFormatter *formatter=[[[NSDateFormatter alloc]init]autorelease];
    [formatter setDateFormat:@"HH:mm"];
    NSDate *date=[formatter dateFromString:alarmTime];
    [timeSelector setDate:date];
    NSLog(alarmTime);
    if([[daysActive objectAtIndex:1] isEqual:on]){
        [[self SundayLabel] setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    }
    if([[daysActive objectAtIndex:2] isEqual:on]){
        [[self MondayLabel] setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    }
    if([[daysActive objectAtIndex:3] isEqual:on]){
        [[self TuesdayLabel] setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    }
    if([[daysActive objectAtIndex:4] isEqual:on]){
        [[self WedLabel] setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    }
    if([[daysActive objectAtIndex:5] isEqual:on]){
        [[self ThursdayLabel] setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    }
    if([[daysActive objectAtIndex:6] isEqual:on]){
        [[self FridayLabel] setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    }
    if([[daysActive objectAtIndex:7] isEqual:on]){
        [[self SaturdayLabel] setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    }
    
    NSString *minutesOfMusic=[config valueForKey:@"minutesOfMusic"];
    [[self minutesOfMusicText]setText:minutesOfMusic];
    [[self minutesOfMusicSpinner]setValue:[minutesOfMusic intValue]];
    [[self millitaryTime]setOn:millitaryTime];
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
    [self setMillitaryTime:nil];
    [self setDayPressed:nil];
    [self setSundayLabel:nil];
    [self setMondayLabel:nil];
    [self setTuesdayLabel:nil];
    [self setWedLabel:nil];
    [self setThursdayLabel:nil];
    [self setFridayLabel:nil];
    [self setSaturdayLabel:nil];
    [self setTimeSelector:nil];
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
    [millitaryTime release];
    [SundayLabel release];
    [MondayLabel release];
    [TuesdayLabel release];
    [WedLabel release];
    [ThursdayLabel release];
    [FridayLabel release];
    [SaturdayLabel release];
    [timeSelector release];
    [super dealloc];
}


- (IBAction)backPressed:(id)sender {
    NSString *mins=[[self minutesOfMusicText]text];
   NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    NSMutableDictionary *config=[userDefault valueForKey:@"config"];
    [config setValue:mins forKey:@"minutesOfMusic"];
    BOOL shuffle=[shuffleSwitch isOn];
    BOOL millitaryTime=[[self millitaryTime]isOn];
    BOOL floydProtection=[floydProtectionSwitch isOn];
    [config setValue:[NSNumber numberWithBool:millitaryTime] forKey:@"millitaryTime"];
    [config setValue:[NSNumber numberWithBool:shuffle] forKey:@"shuffle"];
    [config setValue:[NSNumber numberWithBool:floydProtection] forKey:@"floydProtection"];
    
    NSMutableDictionary *alarm=[[[NSMutableDictionary alloc]init]autorelease];
    
    NSNumber *off=[[NSNumber alloc]initWithInt:0];
    NSNumber *on=[[NSNumber alloc]initWithInt:1];
    
    NSMutableArray *daysActive=[[NSMutableArray arrayWithObjects:off,off,off,off,off,off,off,off, nil]autorelease];
    if([SundayLabel titleColorForState:UIControlStateNormal]==[UIColor greenColor]){
        [daysActive replaceObjectAtIndex:1 withObject:on];
    }
    if([MondayLabel titleColorForState:UIControlStateNormal]==[UIColor greenColor]){
        [daysActive replaceObjectAtIndex:2 withObject:on];
    }
    if([TuesdayLabel titleColorForState:UIControlStateNormal]==[UIColor greenColor]){
        [daysActive replaceObjectAtIndex:3 withObject:on];
    }
    if([WedLabel titleColorForState:UIControlStateNormal]==[UIColor greenColor]){
        [daysActive replaceObjectAtIndex:4 withObject:on];
    }
    if([ThursdayLabel titleColorForState:UIControlStateNormal]==[UIColor greenColor]){
        [daysActive replaceObjectAtIndex:5 withObject:on];
    }
    if([FridayLabel titleColorForState:UIControlStateNormal]==[UIColor greenColor]){
        [daysActive replaceObjectAtIndex:6 withObject:on];
    }
    if([SaturdayLabel titleColorForState:UIControlStateNormal]==[UIColor greenColor]){
        [daysActive replaceObjectAtIndex:7 withObject:on];
    }
    [alarm setValue:daysActive forKey:@"daysActive"];
    NSDate *date=[timeSelector date];
    NSDateFormatter *formatter=[[[NSDateFormatter alloc]init]autorelease];
    [formatter setDateFormat:@"HH:mm"];
    [formatter stringFromDate:date];
    NSString *alarmTime=[formatter stringFromDate:date];
    [alarm setValue:alarmTime forKey:@"alarmTime"];
    [config setValue:alarm forKey:@"alarm"];
    
    [userDefault setValue:config forKey:@"config"];
    [userDefault synchronize];
    [delegate configScreenDidUnload];
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)dayPressed:(id)sender {
    if([sender titleColorForState:UIControlStateNormal]==[UIColor greenColor]){
        [sender setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }else{
        [sender setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];   
    }
        
}

- (IBAction)minutesSpinnerChanged:(id)sender {
    int minF=[minutesOfMusicSpinner value];
    NSString *mins=[[NSString alloc] initWithFormat:@"%d",minF];
    [[self minutesOfMusicText] setText:mins];
    [mins release];
}

@end
