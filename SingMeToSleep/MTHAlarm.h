//
//  MTHAlarm.h
//  SingMeToSleep
//
//  Created by Mike Hickman on 11/19/11.
//  Copyright (c) 2011 Hobsons. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTHAlarm : NSObject{
    NSMutableArray *activeDays;
    
}
typedef enum{
    Wrap=0,
    Sunday=1,
    Monday=2,
    Tuesday=3,
    Wednesday=4,
    Thursday=5,
    Friday=6,
    Saturday=7
}WeekDay;

@property (nonatomic, retain)NSString *alarmSoundName;
@property Boolean active;
@property Boolean alarmVolumeShouldRise;
@property (nonatomic, retain)NSString *alarmTime;
@property (nonatomic, retain)NSDate *nextAlarmTime;




-(Boolean)shouldAlarmSound;
-(void)soundAlarm;
-(void)calcNextAlarmTime;
-(void)stopAlarm;
-(void)addActiveDay:(WeekDay) day;
-(void)removeActiveDay:(WeekDay)day;
-(Boolean)shouldSetOnDay:(WeekDay)day;
-(int)convertStringTimeToIntSeconds:(NSString*)time;


@end
