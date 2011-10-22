//
//  ClockController_ipad.m
//  SingMeToSleep
//
//  Created by Mike Hickman on 10/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ClockController_ipad.h"
#import "MTHNumber.h"
#import "ConfigScreen_iPad.h"

@implementation ClockController_ipad
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
@synthesize playPauseButton;
@synthesize volumeSlider;
@synthesize currentTempLabel;
@synthesize todayHigh;
@synthesize todayLow;
@synthesize tomorrowHigh;
@synthesize tomorrowLow;
@synthesize tomorrowIcon;
@synthesize todayIcon;

#pragma mark - View lifecycle
- (void)dealloc {
    [dotLabel release];
    [tenSecondsLabel release];
    [secondsLabel release];
    [tensMinutesLabel release];
    [minutesLabel release];
    [hoursLabel release];
    [tensHoursLabel release];
    [artistLabel release];
    [titleLabel release];
    [volumeSlider release];
    [playPauseButton release];
    [volumeSlider release];
    [titleLabel release];
    [currentTempLabel release];
    [currentTempLabel release];
    [todayHigh release];
    [todayLow release];
    [tomorrowHigh release];
    [tomorrowLow release];
    [tomorrowIcon release];
    [todayIcon release];
    [super dealloc];
}


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
    [self setVolumeSlider:nil];
    [self setTitleLabel:nil];
    [self setCurrentTempLabel:nil];
    [self setCurrentTempLabel:nil];
    [self setTodayHigh:nil];
    [self setTodayLow:nil];
    [self setTomorrowHigh:nil];
    [self setTomorrowLow:nil];
    [self setTomorrowIcon:nil];
    [self setTodayIcon:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}
#pragma mark - iPad specific screen updates

-(void)initScreen{
    MTHNumber *num=[self createNumberFromLabelArray:tenSecondsLabel];
    [super setTenSecondsNumber:num];
    [super setSecondsNumber:[self createNumberFromLabelArray:secondsLabel]];
    [super setTenMinutesNumber:[self createNumberFromLabelArray:tensMinutesLabel]];
    [super setMinutesNumber:[self createNumberFromLabelArray:minutesLabel]];
    [super setTenHoursNumber:[self createNumberFromLabelArray:tensHoursLabel]];
    [super setHoursNumber:[self createNumberFromLabelArray:hoursLabel]];
}
-(void)updateScreen{
    
        [self blink];
    [super weatherUpdate];
   
}
-(void)updateDisplayWithArtist:(NSString *)artist andTitle:(NSString *)title{
    [[self artistLabel] setText:artist];
    [[self titleLabel] setText:title];
}
- (IBAction)selectMusicPressed:(id)sender {
    [super selectMusic];
}

- (IBAction)previousPressed:(id)sender {
    [super previousTrack];
}

- (IBAction)playPausePressed:(id)sender {
    [super playPause];
    [self changePlayPauseState];
}

- (IBAction)nextPressed:(id)sender {
    [super nextTrack];
}

- (IBAction)volumeMoved:(id)sender {
    float volume=[volumeSlider value];
    [super volumeChanged:volume];
}

- (IBAction)startTimerPressed:(id)sender {
    [super startTimer];
}

- (IBAction)configScreenPressed:(id)sender {
    ConfigScreen_iPad *config=[[ConfigScreen_iPad alloc]initWithDelegate:self];
    [self setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    [self presentModalViewController:config animated:YES];
    [config release];                                                        
                                                    
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
-(void)setCurrentTemp:(NSString *)temp{
    [[self currentTempLabel] setText:temp];
}
-(void)setWeatherCurrent:(NSString *)current 
               todayHigh:(NSString *)todayHigh 
                todayLow:(NSString *)todayLow 
            todayIconUrl:(NSString *)todayIconUrl
            tomorrowHigh:(NSString *)tomorrowHigh 
             tomorrowLow:(NSString *)tomorrowLow
            tomorrowIconUrl:(NSString *)tomorrowIconUrl{
    [[self currentTempLabel] setText:current];
    [[self todayHigh] setText:todayHigh];
    [[self todayLow] setText:todayLow];
    [[self tomorrowHigh] setText:tomorrowHigh];
    [[self tomorrowLow] setText:tomorrowLow];
    NSString *base=@"http://www.google.com";
    todayIconUrl=[base stringByAppendingString:todayIconUrl];
    tomorrowIconUrl=[base stringByAppendingString:tomorrowIconUrl];
    UIImage *todayImage =    [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:todayIconUrl]]];
    UIImage *tomorrowImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:tomorrowIconUrl]]];
    [[self todayIcon]setImage:todayImage];
    [[self tomorrowIcon]setImage:tomorrowImage];
}
@end
