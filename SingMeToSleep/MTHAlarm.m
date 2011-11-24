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
        NSNumber *off=[[NSNumber alloc]initWithInt:0];
        activeDays=[[NSMutableArray alloc]initWithObjects:off,off,off,off,off,off,off,off, nil];
        nextAlarmTime=[[NSDate alloc]init];
    }
    return self;
}

-(void)dealloc{
    [activeDays release];
    [alarmSoundName release];
    [nextAlarmTime release];
    
}
-(void)calcNextAlarmTime{
    NSDate *alarm=[[NSDate alloc]init];
   long oneDay=86400;
    for (int i=0; i<7; i++) {
       
        if([self shouldSetOnDay:alarm]){
            break;
        }
         alarm=[alarm addTimeInterval:oneDay];
    }
   // [alarm release];
    
}
-(Boolean)shouldSetOnDay:(NSDate *)date{
    NSDate *now=[[NSDate alloc]init];
    
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"MM/dd/yyyy HH:mm"];
    NSDateFormatter *dayFormatter=[[NSDateFormatter alloc]init];
    [dayFormatter setDateFormat:@"MM/dd/yyyy"];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *weekdayComponents =[gregorian components:NSWeekdayCalendarUnit fromDate:date];
    NSInteger weekday = [weekdayComponents weekday];
    // weekday 1 = Sunday for Gregorian calendar
    if ([[activeDays objectAtIndex:weekday]intValue]==1) {
        NSString *testDateString=[NSString stringWithFormat:@"%@ %@",[dayFormatter stringFromDate:date],alarmTime];
        NSDate *testDate=[formatter dateFromString:testDateString];
        if ([testDate timeIntervalSinceNow]>0) {
            [self setNextAlarmTime:testDate];
            return YES;
        }
    }
    [gregorian release];
    [now release];
    [formatter release];
    return NO;
}
-(Boolean)shouldAlarmSound{
    if([nextAlarmTime timeIntervalSinceNow]<0){
        return YES;
    }
}
-(void)soundAlarm{
    NSLog(@"alarm");
    
}
-(void)stopAlarm{
    NSLog(@"alarm off");
    
}
-(void)addActiveDay:(WeekDay)day{
    NSNumber *on=[[NSNumber alloc]initWithInt:1];
    [activeDays replaceObjectAtIndex:day withObject:on];
    
}
-(void)removeActiveDay:(WeekDay)day{
    NSNumber *off=[[NSNumber alloc]initWithInt:0];
    [activeDays replaceObjectAtIndex:day withObject:off];
}

@end
