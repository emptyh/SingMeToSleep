//
//  AlarmPopover.m
//  SingMeToSleep
//
//  Created by Mike Hickman on 4/18/12.
//  Copyright (c) 2012 Hobsons. All rights reserved.
//

#import "AlarmPopover.h"

@interface AlarmPopover ()

@end

@implementation AlarmPopover
@synthesize alarmPicker;
@synthesize alarms;
@synthesize audioPlayer;
@synthesize delegate;
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
    // Do any additional setup after loading the view from its nib.
    NSArray *array=[NSArray arrayWithObjects:@"alarm1.mp3",@"alarm2.mp3",@"BurglarAlarm.mp3",@"robot_dog.mp3",@"Sci_Fi.mp3",@"School_Bell.mp3",@"Sub_Dive.mp3",@"Train.mp3", nil];
    [self setAlarms:array];
    [alarmPicker setDelegate:self];
}

- (void)viewDidUnload
{
    [self setAlarmPicker:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
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
    }
    audioPlayer=[AVPlayer playerWithURL:url ];
    [audioPlayer play];
    [delegate setAlarmSound:selected];
   [[delegate currentAlarmLabel]setText:[NSString stringWithFormat:@"%@",selected]];
    return selected;
}
- (IBAction)donePressed:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}
@end
