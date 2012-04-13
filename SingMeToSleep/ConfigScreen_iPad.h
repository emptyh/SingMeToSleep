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
//- (IBAction)minutesChanged:(id)sender;
- (IBAction)backPressed:(id)sender;
- (IBAction)dayPressed:(id)sender;

//@property (retain, nonatomic) IBOutlet UITextField *minutesOfMusic;
@property (retain, nonatomic)id<DataChanged>delegate;
@property (retain, nonatomic) IBOutlet UISwitch *shuffleSwitch;
@property (retain, nonatomic) IBOutlet UISwitch *floydProtectionSwitch;
@property (retain, nonatomic) IBOutlet UISwitch *millitaryTime;

@property (retain, nonatomic) IBOutlet UIButton *SundayLabel;
@property (retain, nonatomic) IBOutlet UIButton *MondayLabel;
@property (retain, nonatomic) IBOutlet UIButton *TuesdayLabel;
@property (retain, nonatomic) IBOutlet UIButton *WedLabel;
@property (retain, nonatomic) IBOutlet UIButton *ThursdayLabel;
@property (retain, nonatomic) IBOutlet UIButton *FridayLabel;
@property (retain, nonatomic) IBOutlet UIButton *SaturdayLabel;
@property (retain, nonatomic) IBOutlet UIDatePicker *timeSelector;


- (IBAction)minutesOfMusicChanged:(id)sender;
@property (retain, nonatomic) IBOutlet UITextField *minutesOfMusicText;
@property (retain, nonatomic) IBOutlet UIStepper *minutesOfMusicSpinner;
-(id)initWithDelegate:(id<DataChanged>)delegate;
@end
