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
@property (nonatomic,retain) NSString *highTemp;
@property (nonatomic,retain) NSString *lowTemp;
@property (nonatomic,retain) NSString *forecastIcon;
@property (nonatomic,retain) NSString *day;

@end
