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

@property (nonatomic, retain) IBOutletCollection(UILabel) NSArray *dotLabel;
@property (nonatomic, retain) IBOutletCollection(UILabel) NSArray *tenSecondsLabel;

@property (nonatomic, retain) IBOutletCollection(UILabel) NSArray *secondsLabel;

@property (nonatomic, retain) IBOutletCollection(UILabel) NSArray *tensMinutesLabel;

@property (nonatomic, retain) IBOutletCollection(UILabel) NSArray *minutesLabel;

@property (nonatomic, retain) IBOutletCollection(UILabel) NSArray *hoursLabel;


-(void)updateScreen;

@property (nonatomic, retain) IBOutletCollection(UILabel) NSArray *tensHoursLabel;
@end
