//
//  ConfigScreen.m
//  SingMeToSleep
//
//  Created by Mike Hickman on 4/13/12.
//  Copyright (c) 2012 Hobsons. All rights reserved.
//

#import "ConfigScreen.h"
#import "SingMeToSleepAppDelegate.h"



@implementation ConfigScreen

@synthesize minutesOfMusicSpinner;
@synthesize minutesOfMusicText;
@synthesize delegate;
@synthesize shuffleSwitch;
@synthesize floydProtectionSwitch;
@synthesize millitaryTime;
@synthesize currentAlarmLabel;
@synthesize SundayLabel;
@synthesize MondayLabel;
@synthesize TuesdayLabel;
@synthesize WedLabel;
@synthesize ThursdayLabel;
@synthesize FridayLabel;
@synthesize SaturdayLabel;
@synthesize timeSelector;
@synthesize alarmPicker;
@synthesize alarms;
@synthesize audioPlayer;
@synthesize alarmSound;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (IBAction)selectAlarmPressed:(id)sender {
    
    
    
    UIActionSheet *popupQuery = [[UIActionSheet alloc] 
                                 initWithTitle:@"Select Alarm" 
                                 delegate:self 
                                 cancelButtonTitle:nil 
                                 destructiveButtonTitle:@"Cancel" 
                                 otherButtonTitles:@"Done", nil];
    
    popupQuery.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    
    
    [popupQuery showInView:self.view];
    [popupQuery setFrame:CGRectMake(0,115,320, 680)];
    [popupQuery addSubview:alarmPicker];
    [[self alarmPicker] setFrame:CGRectMake(0, 150,320,300)];
    [popupQuery release];
}

- (IBAction)minutesOfMusicChanged:(id)sender {
    NSString *mins=[NSString stringWithFormat:@"%i",[minutesOfMusicSpinner value]];
    [[self minutesOfMusicText]setText:mins];
}

-(id)initWithDelegate:(id<DataChanged>)theDelegate{
    self = [super init];
    if (self) {
        [self setDelegate:theDelegate];
    }
    return self;
}

- (void)didReceiveMemoryWarning{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];

    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad{
    [super viewDidLoad];
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    NSMutableDictionary *config=[userDefault valueForKey:@"config"];
    BOOL floydProtection=[[config valueForKey:@"floydProtection"]boolValue];
    BOOL shuffle=[[config valueForKey:@"shuffle"]boolValue];
    BOOL isMillitaryTime=[[config valueForKey:@"millitaryTime"]boolValue];
    NSMutableDictionary *alarm=[config valueForKey:@"alarm"];
    NSMutableArray *daysActive=[alarm valueForKey:@"daysActive"];
    NSNumber *on=[[NSNumber alloc]initWithInt:1];
    NSString *alarmTime=[alarm valueForKey:@"alarmTime"];
    NSDateFormatter *formatter=[[[NSDateFormatter alloc]init]autorelease];
    [formatter setDateFormat:@"HH:mm"];
    if (!alarmTime) {//first time through, no values to read
        alarmTime=@"12:00";
    }
    NSDate *date=[formatter dateFromString:alarmTime];
    [timeSelector setDate:date];
    NSLog(@"%@",alarmTime);
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
    [[self millitaryTime]setOn:isMillitaryTime];
    [[self shuffleSwitch]setOn:shuffle];
    [[self floydProtectionSwitch]setOn:floydProtection];
    [self setAlarmSound:[config valueForKey:@"alarmSound"]];
    [[self currentAlarmLabel] setText:[NSString stringWithFormat:@"%@",alarmSound]];
    alarmPicker=[[UIPickerView alloc] init];
    [alarmPicker setDelegate:self];
    
    
    NSArray *array=[[NSArray arrayWithObjects:@"alarm1.mp3",@"alarm2.mp3",@"BurglarAlarm.mp3",@"robot_dog.mp3",@"School_Bell.mp3",@"Sub_Dive.mp3",@"Train.mp3", nil]autorelease];
    [self setAlarms:array];

}

- (void)viewDidUnload{
  //  [self setSelectAlarmButton:nil];
    [self setCurrentAlarmLabel:nil];
    [super viewDidUnload];
    [self setMinutesOfMusicText:nil];
    [self setMinutesOfMusicSpinner:nil];
    [self setShuffleSwitch:nil];
    [self setFloydProtectionSwitch:nil];
    [self setMillitaryTime:nil];

    [self setSundayLabel:nil];
    [self setMondayLabel:nil];
    [self setTuesdayLabel:nil];
    [self setWedLabel:nil];
    [self setThursdayLabel:nil];
    [self setFridayLabel:nil];
    [self setSaturdayLabel:nil];
    [self setTimeSelector:nil];
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
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
    [alarmPicker release];
    [audioPlayer release];
    [alarmSound release];
    [currentAlarmLabel release];
    [super dealloc];
}


- (IBAction)backPressed:(id)sender {
    NSString *mins=[[self minutesOfMusicText]text];
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    NSMutableDictionary *config=[[[NSMutableDictionary alloc]init]autorelease];
    [config setValue:mins forKey:@"minutesOfMusic"];
    BOOL shuffle=[[self shuffleSwitch] isOn];
    BOOL isMillitaryTime=[[self millitaryTime]isOn];
    BOOL floydProtection=[[self floydProtectionSwitch] isOn];
    [config setValue:[NSNumber numberWithBool:isMillitaryTime] forKey:@"millitaryTime"];
    [config setValue:[NSNumber numberWithBool:shuffle] forKey:@"shuffle"];
    [config setValue:[NSNumber numberWithBool:floydProtection] forKey:@"floydProtection"];

    NSMutableDictionary *alarm=[[[NSMutableDictionary alloc]init]autorelease];

    NSNumber *off=[[NSNumber alloc]initWithInt:0];
    NSNumber *on=[[NSNumber alloc]initWithInt:1];

    NSMutableArray *daysActive=[NSMutableArray arrayWithObjects:off,off,off,off,off,off,off,off, nil];
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
    [config setValue:alarmSound  forKey:@"alarmSound"];
    [userDefault setValue:config forKey:@"config"];
    [userDefault synchronize];
    [delegate configScreenDidUnload];
    [self dismissModalViewControllerAnimated:YES];
    [on release];
    [off release];
    
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
#pragma mark - Picker Delegage Methods
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [[self alarms]count];
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    return [[self alarms]objectAtIndex:row];
}
-(NSString *)pickerView:(UIPickerView*)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSString *selected=[[self alarms]objectAtIndex:row];
    NSLog([NSString stringWithFormat: @"%@/%@",[[NSBundle mainBundle] resourcePath],selected]);
    NSURL *url=[NSURL fileURLWithPath:[NSString stringWithFormat: @"%@/%@",[[NSBundle mainBundle] resourcePath],selected]];
    NSError *error=Nil;
    if(audioPlayer){
        [audioPlayer pause];
        [audioPlayer release];
    }
    audioPlayer=[[AVPlayer playerWithURL:url ]retain];
    [audioPlayer play];
    alarmSound=selected;
    [[self currentAlarmLabel]setText:[NSString stringWithFormat:@"%@",selected]];
    return selected;
}
@end
