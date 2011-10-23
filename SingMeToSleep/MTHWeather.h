//
//  MTHWeather.h
//  SingMeToSleep
//
//  Created by Mike Hickman on 10/18/11.
//  Copyright (c) 2011 EmptyH Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MTHForecast.h"

@interface MTHWeather : NSObject

#pragma mark - Properties
@property (nonatomic,retain)NSString *city;
@property (nonatomic,retain)NSString *conditionIcon;
@property (nonatomic,retain)NSString *temp;
@property (nonatomic,retain)NSString *humidity;
@property (nonatomic,retain)NSString *wind;
@property (nonatomic,retain)MTHForecast *conditions;
@property (nonatomic,retain)NSMutableArray *forecasts;

@end
