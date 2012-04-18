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
    
}

#pragma mark - Properties
@property (retain, nonatomic) IBOutlet UIButton *SelectMusicButton;
@property (retain, nonatomic) IBOutlet UILabel *timeLeftLabel;
@property (nonatomic,retain) MTHNumber *tenSecondsNumber;
@property (nonatomic,retain) MTHNumber *secondsNumber;
@property (nonatomic,retain) MTHNumber *tenMinutesNumber;
@property (nonatomic,retain) MTHNumber *minutesNumber;
@property (nonatomic,retain) MTHNumber *tenHoursNumber;
@property (nonatomic,retain) MTHNumber *hoursNumber;
@property (nonatomic,retain) MPMusicPlayerController *musicPlayer;
@property (nonatomic,retain) NSDate *timeTillSleep;
@property (nonatomic,retain) NSDate *timeStarted;
@property (nonatomic, retain)NSDate *lastWeatherUpdate;
@property int minutesOfMusic;
@property BOOL floydProtection;
@property BOOL millitaryTime;
@property (nonatomic, retain) MTHAlarm *alarm;
@property Boolean hasAlarmStopped;

@property (retain, nonatomic) IBOutlet UILabel *currentTempLabel;
@property (retain, nonatomic) IBOutlet UILabel *todayHigh;
@property (retain, nonatomic) IBOutlet UILabel *todayLow;
@property (retain, nonatomic) IBOutlet UILabel *tomorrowHigh;
@property (retain, nonatomic) IBOutlet UILabel *tomorrowLow;
@property (retain, nonatomic) IBOutlet UIImageView *tomorrowIcon;
@property (retain, nonatomic) IBOutlet UIImageView *todayIcon;


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
