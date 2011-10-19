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
    [self registerMediaPlayerNotifications];
    [self initScreen];
    [self setMinutesOfMusic:15];
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
-(void)handle_nowPlayingChanged:(id)notification{
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd/yyyy hh:mma"];
    NSDate *now=[[NSDate alloc] init];
    NSString *nowString=[formatter stringFromDate:now];
    NSLog(nowString);
    NSString *stop=[formatter stringFromDate:timeTillSleep];
    NSLog(stop);
    int foo=[[self timeTillSleep] timeIntervalSinceNow];
    if([self timeTillSleep] && [[self timeTillSleep] timeIntervalSinceNow]<0){
        [musicPlayer stop];
        MPMediaPropertyPredicate *whiteNoisePredicate=[MPMediaPropertyPredicate predicateWithValue:@"Whitenoise" forProperty:MPMediaItemPropertyArtist];
        MPMediaQuery *query=[[MPMediaQuery alloc] init];
        [query addFilterPredicate:whiteNoisePredicate];

        NSArray *whiteNoise=[query items];
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
        [musicPlayer setQueueWithItemCollection:[[MPMediaItemCollection alloc]initWithItems:playList]];
        [musicPlayer play];
        [self setTimeTillSleep:nil];
    }
    MPMediaItem *song=[musicPlayer nowPlayingItem];
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
    
}
#pragma mark - Music related methods
-(void)startTimer{
    [self setTimeStarted:[[NSDate alloc] init]];
    NSTimeInterval seconds=minutesOfMusic*60;
    NSDate *newDate= [[self timeStarted]dateByAddingTimeInterval:seconds];
    [self setTimeTillSleep:newDate];
    
    
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd/yyyy hh:mma"];
    NSString *start=[formatter stringFromDate:timeStarted];
    NSLog(start);
    NSString *stop=[formatter stringFromDate:timeTillSleep];
    NSLog(stop);
    
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
    [musicPlayer skipToNextItem];
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
#pragma mark - weather methods
-(void)weatherUpdate{
    if(!lastWeatherUpdate || [lastWeatherUpdate timeIntervalSinceNow]>10*60){
        
        NSTimeInterval tenMinutes=10*60;
        lastWeatherUpdate=[[NSDate alloc]init];
        MTHWeatherFactory *factory=[[MTHWeatherFactory alloc]init];
        NSURL *weatherURL=[[NSURL alloc] initWithString:@"http://www.google.com/ig/api?weather=41042"];//should be dynamic
        MTHWeather *weather=[factory getWeatherFromURL:weatherURL];
        NSString *temp=[weather temp];
   //     MTHForecast *tomorrow=[[weather forecasts] getObjects:0];
        [self setCurrentTemp:temp];
        
        
    }
    
}

@end
