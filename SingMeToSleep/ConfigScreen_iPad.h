//
//  ConfigScreen_iPad.h
//  SingMeToSleep
//
//  Created by Mike Hickman on 10/21/11.
//  Copyright (c) 2011 EmptyH Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataChanged.h"

@interface ConfigScreen_iPad : UIViewController
- (IBAction)minutesChanged:(id)sender;
- (IBAction)backPressed:(id)sender;
- (IBAction)minutesSpinnerChanged:(id)sender;
@property (retain, nonatomic) IBOutlet UITextField *minutesOfMusic;
@property (retain, nonatomic)id<DataChanged>delegate;
@property (retain, nonatomic) IBOutlet UISwitch *shuffleSwitch;
@property (retain, nonatomic) IBOutlet UISwitch *floydProtectionSwitch;

- (IBAction)minutesOfMusicChanged:(id)sender;
@property (retain, nonatomic) IBOutlet UITextField *minutesOfMusicText;
@property (retain, nonatomic) IBOutlet UIStepper *minutesOfMusicSpinner;
-(id)initWithDelegate:(id<DataChanged>)delegate;
@end
