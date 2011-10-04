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
#import <MediaPlayer/MediaPlayer.h>

@interface ClockController : UIViewController{
    MTHNumber *tenSecondsNumber;
    MTHNumber *secondsNumber;
    MTHNumber *tenMinutesNumber;
    MTHNumber *minutesNumber;
    MTHNumber *tensHourNumber;
    MTHNumber *hoursNumber;
    
}

#pragma mark - Properties
@property (nonatomic,retain) MTHNumber *tenSecondsNumber;
@property (nonatomic,retain) MTHNumber *secondsNumber;
@property (nonatomic,retain) MTHNumber *tenMinutesNumber;
@property (nonatomic,retain) MTHNumber *minutesNumber;
@property (nonatomic,retain) MTHNumber *tenHoursNumber;
@property (nonatomic,retain) MTHNumber *hoursNumber;

#pragma mark - Methods
-(NSTimer *)createTimer;
-(void) blink;
-(MTHNumber *) createNumberFromLabelArray:(NSArray *) labels;
-(void) initScreen;
-(void) selectMusic;

@end
