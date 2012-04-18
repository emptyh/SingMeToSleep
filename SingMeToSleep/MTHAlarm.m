//
//  MTHAlarm.m
//  SingMeToSleep
//
//  Created by Mike Hickman on 11/19/11.
//  Copyright (c) 2011 Hobsons. All rights reserved.
//

#import "MTHAlarm.h"

@implementation MTHAlarm
@synthesize active;
@synthesize alarmSoundName;
@synthesize alarmVolumeShouldRise;
@synthesize alarmTime;
@synthesize nextAlarmTime;

-(id)init{
    if(self=[super init]){
        NSNumber *off=[[[NSNumber alloc]initWithInt:0]autorelease];
        activeDays=[[NSMutableArray alloc]initWithObjects:off,off,off,off,off,off,off,off, nil];
        nextAlarmTime=[[NSDate alloc]init];
        active=NO;
    }
    return self;
}

-(void)dealloc{
    [activeDays release];
    [alarmSoundName release];
    [nextAlarmTime release];
    
}
-(void)calcNextAlarmTime{
   // NSDate *alarm=[[NSDate alloc]init];
   long oneDay=86400;
    for (int i=1; i<8; i++) {
        if([self shouldSetOnDay:i]){
            NSLog(@"today %d",i);
            break;
        }
    }
   // [alarm release];
    
}
-(Boolean)shouldSetOnDay:(WeekDay)day{
    NSCalendar *gregorian = [[[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar]autorelease];
    NSDate *date = [[[NSDate alloc]init]autorelease];
    NSDateComponents *weekdayComponents = [gregorian components:NSWeekdayCalendarUnit fromDate:date];
    WeekDay today = [weekdayComponents weekday];
    if (today==Saturday) {
        today=Wrap;
    }
    NSDateFormatter *formatter=[[[NSDateFormatter alloc]init]autorelease];
    [formatter setDateFormat:@"HH:mm"];
    NSString *currentTime=[formatter stringFromDate:date];
    int nowTimeSeconds= [self convertStringTimeToIntSeconds:currentTime];
    int alarmTimeSeconds=[self convertStringTimeToIntSeconds:alarmTime];
    
   
    NSNumber *on=[[[NSNumber alloc]initWithInt:1]autorelease];
    if([[activeDays objectAtIndex:day] isEqual:on]){
        if (day>today || (day==today && alarmTimeSeconds>nowTimeSeconds)){
            int daysAdd=0;
            if(today==Wrap){
                daysAdd=7-(today-day);
            }else{
                daysAdd=day-today;
            }
            if (daysAdd>0) {
                date=[date dateByAddingTimeInterval:daysAdd*20*60*60];
            }
            NSDateComponents *components=[[NSCalendar currentCalendar] components:(NSHourCalendarUnit | NSMinuteCalendarUnit |NSDayCalendarUnit | NSMonthCalendarUnit |NSYearCalendarUnit) fromDate:date];
            NSArray *parts=[alarmTime componentsSeparatedByString:@":"];
            int hours=[[parts objectAtIndex:0]intValue];
            int minutes=[[parts objectAtIndex:1]intValue];
            
            [components setHour:hours];
            [components setMinute:minutes];
            [components setSecond:0];
            NSDate *results=[gregorian dateFromComponents:components];
            
            [self setNextAlarmTime:results];
            active=YES;
            return YES;
        }
    }else {
        return NO;
    }
}
-(Boolean)shouldAlarmSound{
    if(active && nextAlarmTime && [nextAlarmTime timeIntervalSinceNow]<0){
        NSDateFormatter *formatter=[[[NSDateFormatter alloc]init]autorelease];
        [formatter setDateFormat:@"HH:mm"];
        NSLog(@"time set %@",[formatter stringFromDate:nextAlarmTime]);
        return YES;
    }else {
        return NO;
    }
}
-(void)soundAlarm{
    NSLog(@"alarm");
    
}
-(void)stopAlarm{
    NSLog(@"alarm off");
    
}
-(void)addActiveDay:(WeekDay)day{
    NSNumber *on=[[[NSNumber alloc]initWithInt:1]autorelease];
    [activeDays replaceObjectAtIndex:day withObject:on];
    
}
-(void)removeActiveDay:(WeekDay)day{
    NSNumber *off=[[[NSNumber alloc]initWithInt:0]autorelease];
    [activeDays replaceObjectAtIndex:day withObject:off];
}
-(int)convertStringTimeToIntSeconds:(NSString*)time{
    NSArray *parts=[time componentsSeparatedByString:@":"];
    int hours=[[parts objectAtIndex:0]intValue]*60*60;
    int minutes=[[parts objectAtIndex:1]intValue]*60;
    int seconds=hours+minutes;
    
    return seconds;
}

@end
