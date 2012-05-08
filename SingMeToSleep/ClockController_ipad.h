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
@property (nonatomic) IBOutletCollection(UILabel) NSArray *dotLabel;
@property (nonatomic) IBOutletCollection(UILabel) NSArray *tenSecondsLabel;
@property (nonatomic) IBOutletCollection(UILabel) NSArray *secondsLabel;
@property (nonatomic) IBOutletCollection(UILabel) NSArray *tensMinutesLabel;
@property (nonatomic) IBOutletCollection(UILabel) NSArray *minutesLabel;
@property (nonatomic) IBOutletCollection(UILabel) NSArray *hoursLabel;
@property (nonatomic) IBOutletCollection(UILabel) NSArray *tensHoursLabel;
@property ( nonatomic) IBOutlet UILabel *artistLabel;
@property ( nonatomic) IBOutlet UILabel *titleLabel;

@property ( nonatomic) IBOutlet UIButton *playPauseButton;

@property ( nonatomic) IBOutlet UISlider *volumeSlider;


@property ( nonatomic) IBOutlet UILabel *PMLabel;
@property ( nonatomic) IBOutlet UILabel *AMLabel;


#pragma mark - Actions
- (IBAction)previousPressed:(id)sender;
- (IBAction)playPausePressed:(id)sender;
- (IBAction)nextPressed:(id)sender;
- (IBAction)volumeMoved:(id)sender;
- (IBAction)startTimerPressed:(id)sender;
- (IBAction)configScreenPressed:(id)sender;
#pragma mark -Methods
-(void)updateScreen;


@end
