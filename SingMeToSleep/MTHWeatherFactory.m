//
//  MTHWeatherFactory.m
//  SingMeToSleep
//
//  Created by Mike Hickman on 10/18/11.
//  Copyright (c) 2011 EmptyH Software. All rights reserved.
//

#import "MTHWeatherFactory.h"

@implementation MTHWeatherFactory
@synthesize tags;
@synthesize weather;
@synthesize forcast;

-(id)init{
    if( self=[super init] ){
        tags=[[HSUStack alloc]init];
        weather=[[MTHWeather alloc]init];
        forcast=[[MTHForecast alloc]init];
    }
    return self;
}
-(void)dealloc{
    [tags release];
    [forcast release];
    [weather release];
}
-(MTHWeather*)getWeatherFromURL:(NSURL*)url{
    
    NSXMLParser *parser=[[NSXMLParser alloc]initWithContentsOfURL:url];
    [parser setDelegate:self];
    [parser parse];
    [parser release];
    return weather;
}
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
  
}
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    
     
    
    
    
}
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    [tags push:elementName];
    NSString *currentData=[attributeDict valueForKey:@"data"];
    
    if([tags containsString:@"forcast_information"] ){
        if([elementName isEqualToString:@"city"]){
            [weather setCity:currentData];
        }
   // }else if([elementName isEqualToString:@"current_conditions"]){
   //     forcast=[[MTHForecast alloc]init];
   //     [weather setConditions:forcast];
    
    }else if([elementName isEqualToString:@"forecast_conditions"]){
        [forcast release];
        forcast=[[MTHForecast alloc]init];
        [[weather forecasts]addObject:forcast];
      
    }else if([elementName isEqualToString:@"day_of_week"]){
        [forcast setDay:currentData];
    }else if([elementName isEqualToString:@"low"]){
        [forcast setLowTemp:currentData];
    }else if([elementName isEqualToString:@"high"]){
        [forcast setHighTemp:currentData];
    }else if([elementName isEqualToString:@"icon"]){
        [forcast setForecastIcon:currentData];
    }else if([elementName isEqualToString:@"temp_f"]){
        [weather setTemp:currentData];
    }else if([elementName isEqualToString:@"humidity"]){
        [weather setHumidity:currentData];
    }else if([elementName isEqualToString:@"icon"]){
        [weather setConditionIcon:currentData];
    }else if([elementName isEqualToString:@"wind_conditions"]){
        [weather setConditionIcon:currentData];
    }
  //  [currentData release];
  //  [elementName release];
    

    
}

@end
