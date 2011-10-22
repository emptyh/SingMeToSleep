//
//  MTHNumber.m
//  SingMeToSleep
//
//  Created by Mike Hickman on 10/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MTHNumber.h"

@implementation MTHNumber

#pragma mark - Properties
@synthesize topBar;
@synthesize middleBar;
@synthesize bottomBar;
@synthesize leftUpperBar;
@synthesize rightUpperBar;
@synthesize leftLowerBar;
@synthesize rightLowerBar;
 
- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}
#pragma mark - Methods
-(void)setNumber:(int) number{
    UIColor *on=[UIColor redColor];
    UIColor *off=[[UIColor alloc] initWithRed:255/255 green:0 blue:0 alpha:.1];
    if(number==0){
        
        [topBar setBackgroundColor:on];
        [middleBar setBackgroundColor:off];
        [bottomBar setBackgroundColor:on];
        [leftUpperBar setBackgroundColor:on];
        [rightUpperBar setBackgroundColor:on];
        [leftLowerBar setBackgroundColor:on];
        [rightLowerBar setBackgroundColor:on];
    }else if(number==1){
        [topBar setBackgroundColor:off];
        [middleBar setBackgroundColor:off];
        [bottomBar setBackgroundColor:off];
        [leftUpperBar setBackgroundColor:off];
        [rightUpperBar setBackgroundColor:on];
        [leftLowerBar setBackgroundColor:off];
        [rightLowerBar setBackgroundColor:on];
        
    }else if(number==2){
        [topBar setBackgroundColor:on];
        [middleBar setBackgroundColor:on];
        [bottomBar setBackgroundColor:on];
        [leftUpperBar setBackgroundColor:off];
        [rightUpperBar setBackgroundColor:on];
        [leftLowerBar setBackgroundColor:on];
        [rightLowerBar setBackgroundColor:off];
    }else if (number==3){
        [topBar setBackgroundColor:on];
        [middleBar setBackgroundColor:on];
        [bottomBar setBackgroundColor:on];
        [leftUpperBar setBackgroundColor:off];
        [rightUpperBar setBackgroundColor:on];
        [leftLowerBar setBackgroundColor:off];
        [rightLowerBar setBackgroundColor:on];
    }else if (number==4){
        [topBar setBackgroundColor:off];
        [middleBar setBackgroundColor:on];
        [bottomBar setBackgroundColor:off];
        [leftUpperBar setBackgroundColor:on];
        [rightUpperBar setBackgroundColor:on];
        [leftLowerBar setBackgroundColor:off];
        [rightLowerBar setBackgroundColor:on];
    }else if (number==5){
        [topBar setBackgroundColor:on];
        [middleBar setBackgroundColor:on];
        [bottomBar setBackgroundColor:on];
        [leftUpperBar setBackgroundColor:on];
        [rightUpperBar setBackgroundColor:off];
        [leftLowerBar setBackgroundColor:off];
        [rightLowerBar setBackgroundColor:on];
    }else if(number==6){
        [topBar setBackgroundColor:on];
        [middleBar setBackgroundColor:on];
        [bottomBar setBackgroundColor:on];
        [leftUpperBar setBackgroundColor:on];
        [rightUpperBar setBackgroundColor:off];
        [leftLowerBar setBackgroundColor:on];
        [rightLowerBar setBackgroundColor:on];
    }else if(number==7){
        [topBar setBackgroundColor:on];
        [middleBar setBackgroundColor:off];
        [bottomBar setBackgroundColor:off];
        [leftUpperBar setBackgroundColor:off];
        [rightUpperBar setBackgroundColor:on];
        [leftLowerBar setBackgroundColor:off];
        [rightLowerBar setBackgroundColor:on];
    }else if(number==8){
        [topBar setBackgroundColor:on];
        [middleBar setBackgroundColor:on];
        [bottomBar setBackgroundColor:on];
        [leftUpperBar setBackgroundColor:on];
        [rightUpperBar setBackgroundColor:on];
        [leftLowerBar setBackgroundColor:on];
        [rightLowerBar setBackgroundColor:on];
    }else if (number==9){
        [topBar setBackgroundColor:on];
        [middleBar setBackgroundColor:on];
        [bottomBar setBackgroundColor:on];
        [leftUpperBar setBackgroundColor:on];
        [rightUpperBar setBackgroundColor:on];
        [leftLowerBar setBackgroundColor:off];
        [rightLowerBar setBackgroundColor:on];
    }
    [off release];
    
}

@end
