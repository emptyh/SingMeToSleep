//
//  MTHWeather.m
//  SingMeToSleep
//
//  Created by Mike Hickman on 10/18/11.
//  Copyright (c) 2011 EmptyH Software. All rights reserved.
//

#import "MTHWeather.h"

@implementation MTHWeather
@synthesize city;
@synthesize conditionIcon;
@synthesize humidity;
@synthesize temp;
@synthesize wind;
@synthesize conditions;
@synthesize forecasts;

-(id)init{
    if( self=[super init] ){
        forecasts=[[NSMutableArray alloc]init];
        conditions=[[MTHForecast alloc]init];
    }
    return self;
}
@end
