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
    NSTimer *timer=[self createTimer];
    musicPlayer=[MPMusicPlayerController iPodMusicPlayer];
    //[musicPlayer setShuffleMode:MPMusicShuffleModeSongs]; 
    [self registerMediaPlayerNotifications];
    [self initScreen];
    [self applyConfig];
    
    
    //debug alarm
    MTHAlarm *alarm=[[MTHAlarm alloc]init];
    [alarm setAlarmTime:@"22:00"];
    [alarm addActiveDay:Thursday];
    [alarm calcNextAlarmTime];
    
    [self moveVolumeSlider:[musicPlayer volume]];
    //end debug
    //[self setMinutesOfMusic:15];
}


- (void)viewDidUnload
{
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
#pragma Universal Screen Updates
-(void)blink{
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
    NSLog(start);
    NSString *stop=[formatter stringFromDate:timeTillSleep];
    NSLog(stop);
    [formatter release];
    
}
-(void)playPause{
    MPMusicPlaybackState playbackState=[musicPlayer playbackState];
    if(playbackState==MPMusicPlaybackStatePaused){
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
-(void)configScreenDidUnload{
    [self applyConfig];
}
-(void)applyConfig{
    SingMeToSleepAppDelegate *delgate=[[UIApplication sharedApplication]delegate];
    NSMutableDictionary *config=[delgate config];
    BOOL shuffle= [[config valueForKey:@"shuffle"]boolValue];
    BOOL floydProtection=[[config valueForKey:@"floydProtection"]boolValue];
    BOOL millitaryTime=[[config valueForKey:@"millitaryTime"]boolValue];
    int minutes=[[config valueForKey:@"minutesOfMusic"] intValue];
    [self setMillitaryTime:millitaryTime];
    [self setMinutesOfMusic:minutes];
    if(shuffle){
        [musicPlayer setShuffleMode:MPMusicShuffleModeSongs];
    }else{
        [musicPlayer setShuffleMode:MPMusicShuffleModeOff];
    }
    [self setFloydProtection:floydProtection];
}
#pragma mark - weather methods
-(void)weatherUpdate{
    if(!lastWeatherUpdate || [lastWeatherUpdate timeIntervalSinceNow]<10*60*-1){
        [lastWeatherUpdate release];
        lastWeatherUpdate=[[NSDate alloc]init];
        MTHWeatherFactory *factory=[[MTHWeatherFactory alloc]init];
        NSURL *weatherURL=[[NSURL alloc] initWithString:@"http://www.google.com/ig/api?weather=41042"];//should be dynamic
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
@end
