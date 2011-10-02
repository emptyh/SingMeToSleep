//
//  MTHNumber.h
//  SingMeToSleep
//
//  Created by Mike Hickman on 10/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MTHNumber : NSObject{
    UILabel *topBar;
    UILabel *middleBar;
    UILabel *bottomBar;
    UILabel *leftUpperBar;
    UILabel *rightUpperBar;
    UILabel *leftLowerBar;
    UILabel *rightLowerBar;
    
}
@property (nonatomic, retain) UILabel *topBar;
@property (nonatomic, retain) UILabel *middleBar;
@property (nonatomic, retain) UILabel *bottomBar;
@property (nonatomic, retain) UILabel *leftUpperBar;
@property (nonatomic, retain) UILabel *rightUpperBar;
@property (nonatomic, retain) UILabel *leftLowerBar;
@property (nonatomic, retain) UILabel *rightLowerBar;


-(void)setNumber:(int) number;




@end
