//
//  MTHForecast.m
//  SingMeToSleep
//
//  Created by Mike Hickman on 10/18/11.
//  Copyright (c) 2011 EmptyH Software. All rights reserved.
//

#import "MTHForecast.h"

@implementation MTHForecast
@synthesize highTemp;
@synthesize lowTemp;
@synthesize forecastIcon;
@synthesize day;

-(void)dealloc{
    [highTemp release];
    [lowTemp release];
    [forecastIcon release];
    [day release];
    [super dealloc];
}

@end
