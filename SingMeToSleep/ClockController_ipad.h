//
//  ClockController_ipad.h
//  SingMeToSleep
//
//  Created by Mike Hickman on 10/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ClockController.h"

@interface ClockController_ipad : ClockController{
NSArray *dotLabel;
NSArray *tenSecondsLabel;
NSArray *secondsLabel;
NSArray *tensMinutesLabel;
NSArray *minutesLabel;
NSArray *hoursLabel;
NSArray *tensHoursLabel;
}
#pragma mark - Properties
@property (nonatomic, retain) IBOutletCollection(UILabel) NSArray *dotLabel;
@property (nonatomic, retain) IBOutletCollection(UILabel) NSArray *tenSecondsLabel;
@property (nonatomic, retain) IBOutletCollection(UILabel) NSArray *secondsLabel;
@property (nonatomic, retain) IBOutletCollection(UILabel) NSArray *tensMinutesLabel;
@property (nonatomic, retain) IBOutletCollection(UILabel) NSArray *minutesLabel;
@property (nonatomic, retain) IBOutletCollection(UILabel) NSArray *hoursLabel;
@property (nonatomic, retain) IBOutletCollection(UILabel) NSArray *tensHoursLabel;
@property (retain, nonatomic) IBOutlet UILabel *artistLabel;
@property (retain, nonatomic) IBOutlet UILabel *titleLabel;

@property (retain, nonatomic) IBOutlet UIButton *playPauseButton;
@property (retain, nonatomic) IBOutlet UISlider *volumeSlider;
@property (retain, nonatomic) IBOutlet UILabel *currentTempLabel;
@property (retain, nonatomic) IBOutlet UILabel *todayHigh;
@property (retain, nonatomic) IBOutlet UILabel *todayLow;
@property (retain, nonatomic) IBOutlet UILabel *tomorrowHigh;
@property (retain, nonatomic) IBOutlet UILabel *tomorrowLow;
@property (retain, nonatomic) IBOutlet UIImageView *tomorrowIcon;
@property (retain, nonatomic) IBOutlet UIImageView *todayIcon;
@property (retain, nonatomic) IBOutlet UILabel *PMLabel;
@property (retain, nonatomic) IBOutlet UILabel *AMLabel;


#pragma mark - Actions
- (IBAction)selectMusicPressed:(id)sender;
- (IBAction)previousPressed:(id)sender;
- (IBAction)playPausePressed:(id)sender;
- (IBAction)nextPressed:(id)sender;
- (IBAction)volumeMoved:(id)sender;
- (IBAction)startTimerPressed:(id)sender;
- (IBAction)configScreenPressed:(id)sender;
#pragma mark -Methods
-(void)updateScreen;

@end
