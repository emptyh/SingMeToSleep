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
#pragma mark - properties
@property (nonatomic) UILabel *topBar;
@property (nonatomic) UILabel *middleBar;
@property (nonatomic) UILabel *bottomBar;
@property (nonatomic) UILabel *leftUpperBar;
@property (nonatomic) UILabel *rightUpperBar;
@property (nonatomic) UILabel *leftLowerBar;
@property (nonatomic) UILabel *rightLowerBar;

#pragma mark - Methods
-(void)setNumber:(int) number;




@end
