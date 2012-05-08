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
@property (nonatomic)NSString *city;
@property (nonatomic)NSString *conditionIcon;
@property (nonatomic)NSString *temp;
@property (nonatomic)NSString *humidity;
@property (nonatomic)NSString *wind;
@property (nonatomic)MTHForecast *conditions;
@property (nonatomic)NSMutableArray *forecasts;

@end
