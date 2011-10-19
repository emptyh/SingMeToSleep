//
//  MTHWeatherFactory.h
//  SingMeToSleep
//
//  Created by Mike Hickman on 10/18/11.
//  Copyright (c) 2011 Hobsons. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HSUStack.h"
#import "MTHWeather.h"
#import "MTHForecast.h"
@interface MTHWeatherFactory : NSObject<NSXMLParserDelegate>
@property (nonatomic,retain) HSUStack *tags;
@property (nonatomic,retain) MTHWeather *weather;
@property (nonatomic,retain) MTHForecast *forcast;
#pragma mark - Properties

#pragma mark - Static Methods
-(MTHWeather*)getWeatherFromURL:(NSURL *)url;
@end
