//
//  MTHForecast.h
//  SingMeToSleep
//
//  Created by Mike Hickman on 10/18/11.
//  Copyright (c) 2011 EmptyH Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTHForecast : NSObject
#pragma mark - Properties
@property (nonatomic) NSString *highTemp;
@property (nonatomic) NSString *lowTemp;
@property (nonatomic) NSString *forecastIcon;
@property (nonatomic) NSString *day;

@end
