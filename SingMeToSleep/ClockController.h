//
//  ClockController.h
//  SingMeToSleep
//
//  Created by Mike Hickman on 10/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "MTHNumber.h"
#import <MediaPlayer/MediaPlayer.h>
#import "DataChanged.h"
#import "MTHAlarm.h"
#import <CoreLocation/CLGeocoder.h>
#import <MapKit/MapKit.h>

@interface ClockController : UIViewController<MPMediaPickerControllerDelegate,DataChanged,AVAudioPlayerDelegate,CLLocationManagerDelegate>{
    MTHNumber *tenSecondsNumber;
    MTHNumber *secondsNumber;
    MTHNumber *tenMinutesNumber;
    MTHNumber *minutesNumber;
    MTHNumber *tensHourNumber;
    MTHNumber *hoursNumber;
    
    AVAudioPlayer *audioPlayer;
    float oldVolume;
    
    
    NSString *zipcode;
    CLLocationManager *locationManager;
    CLGeocoder * geoCoder;
    NSMutableArray *songTimes;
    int currentIndex;
    int timeOfSongLeft;
    int totalTime;
    int totalSongs;
    Boolean isMusicDone;
    
}

#pragma mark - Properties
@property ( nonatomic) IBOutlet UIButton *SelectMusicButton;
@property (nonatomic) MTHNumber *tenSecondsNumber;
@property (nonatomic) MTHNumber *secondsNumber;
@property (nonatomic) MTHNumber *tenMinutesNumber;
@property (nonatomic) MTHNumber *minutesNumber;
@property (nonatomic) MTHNumber *tenHoursNumber;
@property (nonatomic) MTHNumber *hoursNumber;
@property (nonatomic) MPMusicPlayerController *musicPlayer;
@property (nonatomic) NSDate *timeTillSleep;
@property (nonatomic) NSDate *timeStarted;
@property (nonatomic)NSDate *lastWeatherUpdate;
@property int minutesOfMusic;
@property BOOL floydProtection;
@property BOOL millitaryTime;
@property (nonatomic) MTHAlarm *alarm;
@property Boolean hasAlarmStopped;

@property ( nonatomic) IBOutlet UIProgressView *timeLeftBar;
@property ( nonatomic) IBOutlet UILabel *currentTempLabel;
@property ( nonatomic) IBOutlet UILabel *todayHigh;
@property ( nonatomic) IBOutlet UILabel *todayLow;
@property ( nonatomic) IBOutlet UILabel *tomorrowHigh;
@property ( nonatomic) IBOutlet UILabel *tomorrowLow;
@property ( nonatomic) IBOutlet UIImageView *tomorrowIcon;
@property ( nonatomic) IBOutlet UIImageView *todayIcon;
@property ( nonatomic) IBOutlet UILabel *timeLeftLabel;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *days;

#pragma mark - Methods
- (IBAction)selectMusicPressed:(id)sender;
-(NSTimer *)createTimer;
-(void) blink;
-(MTHNumber *) createNumberFromLabelArray:(NSArray *) labels;
-(void) initScreen;
-(void) selectMusic;
-(void) playPause;
-(void)previousTrack;
-(void)nextTrack;
-(void)volumeChanged:(float)newValue;
-(void) registerMediaPlayerNotifications;
-(void) changePlayPauseState;
-(void) updateDisplayWithArtist:(NSString *)artist andTitle:(NSString *)title;
-(void) startTimer;
-(void) weatherUpdate;
-(void)setCurrentTemp:(NSString *)temp;
-(void)setWeatherCurrent:(NSString *)current todayHigh:(NSString*)todayHigh todayLow:(NSString*)todayLow todayIconUrl:(NSString*)todayIconUrl tomorrowHigh:(NSString*)tomorrowHigh tomorrowLow:(NSString*)tomorrowLow tomorrowIconUrl:(NSString*)tomorrowIconUrl;
-(void)applyConfig;
-(void)isPM:(BOOL)pm;
-(void)startWhiteNoise;
-(void)moveVolumeSlider:(float)newValue;
-(void)stopAlarm;
-(void)alarmSounding;
@end
