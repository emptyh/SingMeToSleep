//
//  ClockController.m
//  SingMeToSleep
//
//  Created by Mike Hickman on 10/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ClockController.h"

#import "MTHWeather.h"
#import "MTHForecast.h"
#import "MTHWeatherFactory.h"
#import "SingMeToSleepAppDelegate.h"

@implementation ClockController
#pragma mark - Properties
@synthesize SelectMusicButton;
@synthesize tenSecondsNumber;
@synthesize secondsNumber;
@synthesize tenMinutesNumber;
@synthesize minutesNumber;
@synthesize tenHoursNumber;
@synthesize hoursNumber;
@synthesize musicPlayer;
@synthesize timeTillSleep;
@synthesize timeStarted;
@synthesize minutesOfMusic;
@synthesize lastWeatherUpdate;
@synthesize floydProtection;
@synthesize millitaryTime;
@synthesize alarm;
@synthesize hasAlarmStopped;

@synthesize currentTempLabel;
@synthesize todayHigh;
@synthesize todayLow;
@synthesize tomorrowHigh;
@synthesize tomorrowLow;
@synthesize tomorrowIcon;
@synthesize todayIcon;
@synthesize timeLeftLabel;

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
    
    locationManager = [[CLLocationManager alloc] init] ;
    [locationManager setDelegate: self];
    [locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    [locationManager startUpdatingLocation];
    
    [self applyConfig];
    
    NSTimer *timer=[self createTimer];
    musicPlayer=[MPMusicPlayerController iPodMusicPlayer];
    songTimes=[[NSMutableArray alloc]init];
    //[musicPlayer setShuffleMode:MPMusicShuffleModeSongs]; 
    [self registerMediaPlayerNotifications];
    [self initScreen];
    
    
    
    //debug alarm
   
    
    [self moveVolumeSlider:[musicPlayer volume]];
    //end debug
    //[self setMinutesOfMusic:15];
}
- (void)dealloc {
    [SelectMusicButton release];
    [timeLeftLabel release];
    [geoCoder release];
    
    [currentTempLabel release];
    [currentTempLabel release];
    [todayHigh release];
    [todayLow release];
    [tomorrowHigh release];
    [tomorrowLow release];
    [tomorrowIcon release];
    [todayIcon release];
    [songTimes release];
    [timeLeftLabel release];
    [super dealloc];
}


- (void)viewDidUnload
{
    [self setSelectMusicButton:nil];
    [self setTimeLeftLabel:nil];
    [self setTimeLeftLabel:nil];
    [super viewDidUnload];
    [musicPlayer release];
    [[NSNotificationCenter defaultCenter] removeObserver: self
                                                    name: MPMusicPlayerControllerNowPlayingItemDidChangeNotification
                                                  object: musicPlayer];
    
    [[NSNotificationCenter defaultCenter] removeObserver: self
                                                    name: MPMusicPlayerControllerPlaybackStateDidChangeNotification
                                                  object: musicPlayer];
    
    [[NSNotificationCenter defaultCenter] removeObserver: self
                                                    name: MPMusicPlayerControllerVolumeDidChangeNotification
                                                  object: musicPlayer];
    
    [musicPlayer endGeneratingPlaybackNotifications];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
#pragma mark Clock Methods
-(void)blink{
    if([[self alarm]active] && [[self alarm]shouldAlarmSound]){
    //    [alarm setActive:NO];
        NSLog(@"bong");
        [[self alarm]calcNextAlarmTime];
        oldVolume=[[self musicPlayer]volume];
        [[self musicPlayer] setVolume:.1];
        [self soundAlarm];
    }
    if (timeOfSongLeft>0) {
        int currentProgress=[musicPlayer currentPlaybackTime];
        int timeLeft=timeOfSongLeft-currentProgress;
        int minutesLeft=timeLeft/60;
        int secondsLeft=timeLeft % 60;
        [[self timeLeftLabel]setText:[NSString stringWithFormat:@"Time Left: %d:%d",minutesLeft,secondsLeft]];
    }else {
        [[self timeLeftLabel]setText:@""];
    }
    NSDateFormatter *dformat=[[NSDateFormatter alloc] init];
    [dformat setDateFormat:@"dd-MM-yyyy HH:mm:ss"];
    NSString *now=[dformat stringFromDate:[NSDate date]];
    NSArray *dateTime=[now componentsSeparatedByString:@" "];
    NSArray *parts=[[dateTime objectAtIndex:1] componentsSeparatedByString:@":"];
    NSString *hours=[parts objectAtIndex:0];
    NSString *minutes=[parts objectAtIndex:1];
    NSString *seconds=[parts objectAtIndex:2];
    int hoursInt=[hours intValue];
    if(!millitaryTime && hoursInt>12){
        hoursInt=hoursInt-12;
        hours=[NSString stringWithFormat:@"%d",hoursInt];
        if([hours length]==1){
            hours=[@"0" stringByAppendingString:hours];
        }
        [self isPM:YES];
    }else if (hoursInt==0){
        hours=@"12";
        [self isPM:NO];
    }else{
        [self isPM:NO];
    }
    int tenHours=[[hours substringWithRange:NSMakeRange(0,1)] intValue];
    int oneHours=[[hours substringFromIndex:1]intValue];
    
    int tenMinutes=[[minutes substringWithRange:NSMakeRange(0, 1)]intValue];
    int oneMinutes=[[minutes substringFromIndex:1]intValue];
    
    int tenSeconds=[[seconds substringWithRange:NSMakeRange(0, 1)] intValue];
    int oneSeconds=[[seconds substringFromIndex:1]intValue];
    if(tenHours==0){
        tenHours=-1;
    }
    [[self tenSecondsNumber]setNumber:tenSeconds];
    [[self secondsNumber]setNumber:oneSeconds];
    [[self tenMinutesNumber]setNumber:tenMinutes];
    [[self minutesNumber]setNumber:oneMinutes];
    [[self tenHoursNumber]setNumber:tenHours];
    [[self hoursNumber]setNumber:oneHours];
    
    
    [dformat release];
    
}
-(MTHNumber *) createNumberFromLabelArray:(NSArray *) labels{
    MTHNumber *tempNumber=[[[MTHNumber alloc]init]autorelease];
    MTHNumber *number=tempNumber;
    
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
   // [tempNumber release];
    return number;
}
#pragma mark - Alarm Methods
-(void)alarmSounding{
    [[self SelectMusicButton]setTitle:@"I'm Up Damnit" forState:UIControlStateNormal];
}
-(void)soundAlarm{
    MPMusicPlaybackState playbackState=[musicPlayer playbackState];
    if(playbackState==MPMusicPlaybackStatePlaying){
        [musicPlayer pause];
    }
        
    [self alarmSounding];
    [audioPlayer play];
}
-(void)stopAlarm{
    [audioPlayer pause];
    [self setHasAlarmStopped:YES];
    [musicPlayer setVolume:oldVolume];
  //  [alarm setActive:NO];
}
-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    if ([musicPlayer volume]<1) {
        [musicPlayer setVolume:[musicPlayer volume]+.1];
    }
    if([self hasAlarmStopped]){
        
    }else{
        [audioPlayer play];
    }
    NSLog(@"hi there");
}

#pragma Universal Screen Updates




-(NSTimer *)createTimer{
    return [NSTimer scheduledTimerWithTimeInterval:.2 target:self selector:@selector(updateScreen) userInfo:nil repeats:YES];
    
}
#pragma mark - Media Player Notification
-(void)registerMediaPlayerNotifications{
    NSNotificationCenter *notificationCenter=[NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self 
                           selector:@selector(handle_nowPlayingChanged:) 
                        name:MPMusicPlayerControllerNowPlayingItemDidChangeNotification
                             object:musicPlayer];
    [notificationCenter addObserver:self
                           selector:@selector(handle_playbackStateChanged:)
                        name:MPMusicPlayerControllerPlaybackStateDidChangeNotification 
                        object:musicPlayer];
    [notificationCenter addObserver:self
                           selector:@selector(handle_VolumeChanged:) 
                        name:MPMusicPlayerControllerVolumeDidChangeNotification 
                             object:musicPlayer];
    [musicPlayer beginGeneratingPlaybackNotifications];
}
-(void)mediaPicker:(MPMediaPickerController *) mediaPicker didPickMediaItems:(MPMediaItemCollection *)mediaItemCollection{
    if(mediaItemCollection){
        [songTimes removeAllObjects];
        totalSongs=[mediaItemCollection count];
        for(int i=0;i< totalSongs;i++ ){
            MPMediaItem *item=[[mediaItemCollection items]objectAtIndex:i];
            int time=[[item valueForProperty:MPMediaItemPropertyPlaybackDuration]intValue];
            [songTimes addObject:[[NSNumber alloc]initWithInt:time]];
        }
        [musicPlayer setQueueWithItemCollection:mediaItemCollection];
        [musicPlayer play];
    }
    [self dismissModalViewControllerAnimated:YES];
}
-(void)mediaPickerDidCancel:(MPMediaPickerController *) mediaPicker{
    [self dismissModalViewControllerAnimated:YES];
}
-(void)startWhiteNoise{
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd/yyyy hh:mma"];
    [musicPlayer stop];
    MPMediaPropertyPredicate *whiteNoisePredicate=[MPMediaPropertyPredicate predicateWithValue:@"Whitenoise" forProperty:MPMediaItemPropertyArtist];
    MPMediaQuery *query=[[MPMediaQuery alloc] init];
    [query addFilterPredicate:whiteNoisePredicate];
    
    
    NSArray *whiteNoise=[query items];
    [query release];
    int totalSeconds=0;
    for(MPMediaItem *item in whiteNoise){
        NSNumber *duruation= [item valueForProperty:MPMediaItemPropertyPlaybackDuration];
        int seconds = [duruation intValue];
        
        totalSeconds=totalSeconds+seconds;
    }
    int eightHours=28800;
    int numberOfPlays=eightHours/totalSeconds;
    NSMutableArray *playList=[[NSMutableArray alloc] init];
    for (int i=0; i<numberOfPlays; i++) {
        for (MPMediaItem *item in whiteNoise){
            [playList addObject:item];
        }
    }
    MPMediaItemCollection *collection=[[MPMediaItemCollection alloc]initWithItems:playList];
    
    [musicPlayer setQueueWithItemCollection:collection];
    [musicPlayer play];
    [collection release];
    [playList release];
    [formatter release];
    
    [self setTimeTillSleep:nil];
}
-(void)handle_nowPlayingChanged:(id)notification{
    
   
    
    MPMediaItem *song=[musicPlayer nowPlayingItem];
    
    if(([self timeTillSleep] && [[self timeTillSleep] timeIntervalSinceNow]<0) || !song){
        [self startWhiteNoise];

    }
    
    NSString *artist=@"Unknown";
    NSString *title=@"Unknown";
    if([song valueForProperty:MPMediaItemPropertyTitle]){
        title=[song valueForProperty:MPMediaItemPropertyTitle];
    }
    if([song valueForProperty:MPMediaItemPropertyArtist]){
        artist=[song valueForProperty:MPMediaItemPropertyArtist];
    }
    [self updateDisplayWithArtist:artist andTitle:title];
    currentIndex=[musicPlayer indexOfNowPlayingItem];
    timeOfSongLeft=0;
    for (int i=currentIndex; i<[songTimes count]; i++) {
        timeOfSongLeft=timeOfSongLeft + [[songTimes objectAtIndex:i]intValue];
    }
}
-(void)handle_playbackStateChanged:(id) notification{
    MPMusicPlaybackState playbackState = [musicPlayer playbackState];
    
    if (playbackState == MPMusicPlaybackStatePaused) {
        
    } else if (playbackState == MPMusicPlaybackStatePlaying) {
        
       
    }
    
}
-(void)handle_VolumeChanged:(id)notification{
    
    [self moveVolumeSlider:[musicPlayer volume]];
}
#pragma mark - Music related methods
- (IBAction)selectMusicPressed:(id)sender {
    //  UIButton *button=(UIButton*)sender;
    NSLog([[SelectMusicButton titleLabel]text]);
    if([[SelectMusicButton titleForState:UIControlStateNormal] isEqualToString: @"I'm Up Damnit"]){
        [self stopAlarm];
        [[self SelectMusicButton]setTitle:@"Select Music" forState:UIControlStateNormal];
    }else{
        [self selectMusic];
    }
}
-(void)startTimer{
    NSDate *date=[[NSDate alloc] init];
    [self setTimeStarted:date];
    [date release];
    NSTimeInterval seconds=minutesOfMusic*60;
    NSDate *newDate= [[self timeStarted]dateByAddingTimeInterval:seconds];
    [self setTimeTillSleep:newDate];
    
    
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd/yyyy hh:mma"];
    NSString *start=[formatter stringFromDate:timeStarted];
    NSLog(@"%@",start);
    NSString *stop=[formatter stringFromDate:timeTillSleep];
    NSLog(@"%@",stop);
    [formatter release];
    
}
-(void)playPause{
    MPMusicPlaybackState playbackState=[musicPlayer playbackState];
    if(playbackState==MPMusicPlaybackStatePaused || playbackState==MPMusicPlaybackStateInterrupted){
        [musicPlayer play];
    }else if(playbackState==MPMusicPlaybackStatePlaying){
        [musicPlayer pause];
    }
}
-(void)nextTrack{
    [[self musicPlayer] skipToNextItem];
}
-(void)previousTrack{
    [musicPlayer skipToPreviousItem];
}
-(void)volumeChanged:(float)newValue{
    [musicPlayer setVolume:newValue];
    
}
-(void)selectMusic{
    MPMediaPickerController *mediaPicker=[[MPMediaPickerController alloc]init];
    
    [mediaPicker setDelegate:self];
    [mediaPicker setAllowsPickingMultipleItems:YES];
    [mediaPicker setPrompt:@"Pick songs to sleep to"];
    [self presentModalViewController:mediaPicker animated:YES];
    [mediaPicker release];
}
#pragma mark Config Methods
-(void)configScreenDidUnload{
    [self applyConfig];
}
-(void)applyConfig{
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    NSMutableDictionary *config=[userDefault valueForKey:@"config"];
    BOOL shuffle= [[config valueForKey:@"shuffle"]boolValue];
    BOOL isFloydProtection=[[config valueForKey:@"floydProtection"]boolValue];
    BOOL isMillitaryTime=[[config valueForKey:@"millitaryTime"]boolValue];
    int minutes=[[config valueForKey:@"minutesOfMusic"] intValue];
    [self setMillitaryTime:isMillitaryTime];
    [self setMinutesOfMusic:minutes];
    if(shuffle){
        [musicPlayer setShuffleMode:MPMusicShuffleModeSongs];
    }else{
        [musicPlayer setShuffleMode:MPMusicShuffleModeOff];
    }
    [self setFloydProtection:isFloydProtection];
    
    NSMutableDictionary *newAlarm=[config valueForKey:@"alarm"];
    BOOL isAlarmActive=[[newAlarm valueForKey:@"active"]boolValue];
    NSString *newAlarmTime=[newAlarm valueForKey:@"alarmTime"];
    NSMutableArray *activeDays=[newAlarm valueForKey:@"daysActive"];
    MTHAlarm *tempAlarm=[[[MTHAlarm alloc]init]autorelease];
    [self setAlarm:tempAlarm];
    [[self alarm] setAlarmTime:newAlarmTime];
   // NSNumber *off=[[NSNumber alloc]initWithInt:0];
    NSNumber *on=[[[NSNumber alloc]initWithInt:1]autorelease];
    
    if([activeDays objectAtIndex:1]==on){
        [[self alarm] addActiveDay:Sunday];
    }
    if([activeDays objectAtIndex:2]==on){
        [[self alarm] addActiveDay:Monday];
    }
    if([activeDays objectAtIndex:3]==on){
        [[self alarm] addActiveDay:Tuesday];
    }
    if([activeDays objectAtIndex:4]==on){
        [[self alarm] addActiveDay:Wednesday];
    }
    if([activeDays objectAtIndex:5]==on){
        [[self alarm] addActiveDay:Thursday];
    }
    if([activeDays objectAtIndex:6]==on){
        [[self alarm] addActiveDay:Friday];
    }
    if([activeDays objectAtIndex:7]==on){
        [[self alarm] addActiveDay:Saturday];
    }
    [[self alarm]setActive:isAlarmActive];
    [[self alarm] calcNextAlarmTime];
    
    NSString *alarmSound=[config valueForKey:@"alarmSound"];
    if(!alarmSound){
        alarmSound=@"alarm1.mp3";
    }
    NSURL *url=[NSURL fileURLWithPath:[NSString stringWithFormat: @"%@/%@",[[NSBundle mainBundle] resourcePath],alarmSound]];
    NSError *error=Nil;
    if(audioPlayer){
        [audioPlayer release];
    }
    audioPlayer=[[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
    [audioPlayer setDelegate:self];
}
#pragma mark - weather methods
-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    
    [locationManager stopUpdatingLocation];
    
    geoCoder = [[[CLGeocoder alloc] init]autorelease];
    [geoCoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        for (CLPlacemark * placemark in placemarks) {
            zipcode=[placemark postalCode];
        }    
    }];
    
}
-(void)weatherUpdate{
    if (!zipcode) {
        return;
    }
    if(!lastWeatherUpdate || [lastWeatherUpdate timeIntervalSinceNow]<10*60*-1){
        [lastWeatherUpdate release];
        lastWeatherUpdate=[[NSDate alloc]init];
        MTHWeatherFactory *factory=[[MTHWeatherFactory alloc]init];
        NSString *urlString=[NSString stringWithFormat: @"http://www.google.com/ig/api?weather=%@",zipcode];
        NSURL *weatherURL=[[NSURL alloc] initWithString:urlString];//should be dynamic
        MTHWeather *weather=[factory getWeatherFromURL:weatherURL];
        
        NSString *temp=[weather temp];
        MTHForecast *today=[[weather forecasts] objectAtIndex:0];
        MTHForecast *tomorrow=[[weather forecasts] objectAtIndex:1];
        NSString *todayHigh=[[[NSString alloc]initWithFormat:@"%@",[today highTemp]]autorelease];
        NSString *todayLow= [[[NSString alloc]initWithFormat:@"%@",[today lowTemp]]autorelease];
        NSString *todayIconUrl=[[[NSString alloc]initWithFormat:@"%@",[today forecastIcon]]autorelease];
        
        NSString *tomorrowHigh=[[[NSString alloc]initWithFormat:@"%@",[tomorrow highTemp]]autorelease];
        NSString *tomorrowLow=[[[NSString alloc]initWithFormat:@"%@",[tomorrow lowTemp]]autorelease];
        NSString *tomorrowIconUrl=[[[NSString alloc] initWithFormat:@"%@",[tomorrow forecastIcon]]autorelease];
        
        [self setWeatherCurrent: temp todayHigh:todayHigh todayLow:todayLow todayIconUrl:todayIconUrl tomorrowHigh:tomorrowHigh tomorrowLow:tomorrowLow tomorrowIconUrl:tomorrowIconUrl];
 //       [self setCurrentTemp:temp];
       
        [factory release];
        [weatherURL release];
    //    [weather release];
        
    }
    
}
-(void)dataDidChange:(NSString *)source withValue:(NSString *)value{
    if([source isEqualToString:@"minutesOfMusic"]){
        [self setMinutesOfMusic:[value intValue]];
    }

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
