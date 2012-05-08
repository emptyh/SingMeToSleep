//
//  ClockController_iphone.m
//  SingMeToSleep
//
//  Created by Mike Hickman on 10/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ClockController_iphone.h"

@implementation ClockController_iphone
#pragma mark - Properties
@synthesize dotLabel;
@synthesize tenSecondsLabel;
@synthesize secondsLabel;
@synthesize tensMinutesLabel;
@synthesize minutesLabel;
@synthesize hoursLabel;
@synthesize tensHoursLabel;
@synthesize artistLabel;
@synthesize titleLabel;
@synthesize volumeSlider;
@synthesize playPauseButton;
@synthesize AMLabel;
@synthesize PMLabel;




#pragma mark - View lifecycle
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



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setArtistLabel:nil];
    [self setTitleLabel:nil];
    [self setVolumeSlider:nil];
    [self setPlayPauseButton:nil];
    [self setAMLabel:nil];
    [self setPMLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

#pragma mark - iPhone specific screen updates
-(void)initScreen{
    MTHNumber *num=[self createNumberFromLabelArray:tenSecondsLabel];
    [super setTenSecondsNumber:num];
    [super setSecondsNumber:[self createNumberFromLabelArray:secondsLabel]];
    [super setTenMinutesNumber:[self createNumberFromLabelArray:tensMinutesLabel]];
    [super setMinutesNumber:[self createNumberFromLabelArray:minutesLabel]];
    [super setTenHoursNumber:[self createNumberFromLabelArray:tensHoursLabel]];
    [super setHoursNumber:[self createNumberFromLabelArray:hoursLabel]];
}
- (IBAction)nextPressed:(id)sender {
    [super nextTrack];
}



- (IBAction)volumeChanged:(id)sender {
    float volume=[volumeSlider value];
    [super volumeChanged:volume];
}

- (IBAction)configScreenPressed:(id)sender {
    ConfigScreen_iPhone *config=[[ConfigScreen_iPhone alloc]initWithDelegate:self];
    [config setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    [self presentModalViewController:config animated:YES];
}

-(void)updateScreen{
    [super blink];
    [super weatherUpdate];
}


- (IBAction)startTimerPressed:(id)sender {
    [super startTimer];

}


- (IBAction)previousPressed:(id)sender {
    [super previousTrack];
}

- (IBAction)playPausePressed:(id)sender {
    [super playPause];
    [self changePlayPauseState];
}
-(void)changePlayPauseState{
    MPMusicPlaybackState playbackState=[[super musicPlayer] playbackState];
    if (playbackState==MPMusicPlaybackStatePlaying){
        UIImage *play=[UIImage imageNamed:@"playButton.png"];
        [[self playPauseButton] setImage:play forState:UIControlStateNormal];
    }else if(playbackState==MPMusicPlaybackStatePaused){
        UIImage *pause=[UIImage imageNamed:@"pauseButton.png"];
        [[self playPauseButton]setImage:pause forState:UIControlStateNormal];
    }
    
}
-(void)updateDisplayWithArtist:(NSString *)artist andTitle:(NSString *)title{
    [[self artistLabel] setText:artist];
    [[self titleLabel] setText:title];
}
-(void)isPM:(BOOL)pm{
    UIColor *on=[UIColor redColor];
    UIColor *off=[[UIColor alloc] initWithRed:255/255 green:0 blue:0 alpha:.1];
    if([super millitaryTime]){
        [[self PMLabel]setTextColor:off];
        [[self AMLabel]setTextColor:off];
    }else {
        
    
        if(pm){
            [[self PMLabel]setTextColor:on];
            [[self AMLabel]setTextColor:off];
        }else{
            [[self PMLabel]setTextColor:off];
            [[self AMLabel]setTextColor:on];
        }
    }
    // [on release];
}
-(void)moveVolumeSlider:(float)newValue{
    [volumeSlider setValue:newValue];
}

@end
