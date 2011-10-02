//
//  ClockController.m
//  SingMeToSleep
//
//  Created by Mike Hickman on 10/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ClockController.h"

@implementation ClockController
@synthesize tenSecondsNumber;
@synthesize secondsNumber;
@synthesize tenMinutesNumber;
@synthesize minutesNumber;
@synthesize tenHoursNumber;
@synthesize hoursNumber;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSTimer *timer=[self createTimer];
    [self initScreen];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
-(MTHNumber *) createNumberFromLabelArray:(NSArray *) labels{
    
    MTHNumber *number=[[MTHNumber alloc]init];
    
    for(UILabel *label in labels){
        if([label tag]==0){
            [number setTopBar:label];
        }else if([label tag]==1){
            [number setRightUpperBar:label];
        }else if([label tag]==2){
            [number setRightLowerBar:label];
        }else if([label tag]==3){
            [number setBottomBar:label];
        }else if([label tag]==4){
            [number setLeftLowerBar:label];
        }else if([label tag]==5){
            [number setLeftUpperBar:label];
        }else if([label tag]==6){
            [number setMiddleBar:label];
        }
    }
    
    return number;
}
-(void)blink{
    NSDateFormatter *dformat=[[NSDateFormatter alloc] init];
    [dformat setDateFormat:@"dd-MM-yyyy HH:mm:ss"];
    NSString *now=[dformat stringFromDate:[NSDate date]];
    NSArray *dateTime=[now componentsSeparatedByString:@" "];
    NSArray *parts=[[dateTime objectAtIndex:1] componentsSeparatedByString:@":"];
    NSString *hours=[parts objectAtIndex:0];
    NSString *minutes=[parts objectAtIndex:1];
    NSString *seconds=[parts objectAtIndex:2];
    
    int tenHours=[[hours substringWithRange:NSMakeRange(0,1)] intValue];
    int oneHours=[[hours substringFromIndex:1]intValue];
    
    int tenMinutes=[[minutes substringWithRange:NSMakeRange(0, 1)]intValue];
    int oneMinutes=[[minutes substringFromIndex:1]intValue];
    
    int tenSeconds=[[seconds substringWithRange:NSMakeRange(0, 1)] intValue];
    int oneSeconds=[[seconds substringFromIndex:1]intValue];
    
    [[self tenSecondsNumber]setNumber:tenSeconds];
    [[self secondsNumber]setNumber:oneSeconds];
    [[self tenMinutesNumber]setNumber:tenMinutes];
    [[self minutesNumber]setNumber:oneMinutes];
    [[self tenHoursNumber]setNumber:tenHours];
    [[self hoursNumber]setNumber:oneHours];
    
    
    [dformat release];
    
}
-(NSTimer *)createTimer{
    return [NSTimer scheduledTimerWithTimeInterval:.2 target:self selector:@selector(updateScreen) userInfo:nil repeats:YES];
    
}


@end
