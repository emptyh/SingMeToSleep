//
//  ClockController.h
//  SingMeToSleep
//
//  Created by Mike Hickman on 10/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MTHNumber.h"

@interface ClockController : UIViewController{
    MTHNumber *tenSecondsNumber;
    MTHNumber *secondsNumber;
    MTHNumber *tenMinutesNumber;
    MTHNumber *minutesNumber;
    MTHNumber *tensHourNumber;
    MTHNumber *hoursNumber;
    
}


@property (nonatomic,retain) MTHNumber *tenSecondsNumber;
@property (nonatomic,retain) MTHNumber *secondsNumber;
@property (nonatomic,retain) MTHNumber *tenMinutesNumber;
@property (nonatomic,retain) MTHNumber *minutesNumber;
@property (nonatomic,retain) MTHNumber *tenHoursNumber;
@property (nonatomic,retain) MTHNumber *hoursNumber;


-(NSTimer *)createTimer;
-(void) blink;
-(MTHNumber *) createNumberFromLabelArray:(NSArray *) labels;
-(void) initScreen;

@end
