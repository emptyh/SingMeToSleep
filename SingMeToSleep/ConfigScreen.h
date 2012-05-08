//
//  ConfigScreen.h
//  SingMeToSleep
//
//  Created by Mike Hickman on 4/13/12.
//  Copyright (c) 2012 Hobsons. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

#import "DataChanged.h"
@interface ConfigScreen : UIViewController<UIPickerViewDelegate, UIPickerViewDataSource,UIActionSheetDelegate,AVAudioPlayerDelegate>
//- (IBAction)minutesChanged:(id)sender;

#pragma mark Properties
//@property (retain, nonatomic) IBOutlet UITextField *minutesOfMusic;
@property ( nonatomic) AVPlayer *audioPlayer;
@property ( nonatomic)id<DataChanged>delegate;
@property ( nonatomic) IBOutlet UISwitch *shuffleSwitch;
@property ( nonatomic) IBOutlet UISwitch *floydProtectionSwitch;
@property ( nonatomic) IBOutlet UISwitch *millitaryTime;

@property ( nonatomic) IBOutlet UISwitch *alarmActiveSwitch;
@property ( nonatomic) IBOutlet UILabel *currentAlarmLabel;
@property ( nonatomic) IBOutlet UIButton *SundayLabel;
@property ( nonatomic) IBOutlet UIButton *MondayLabel;
@property ( nonatomic) IBOutlet UIButton *TuesdayLabel;
@property ( nonatomic) IBOutlet UIButton *WedLabel;
@property ( nonatomic) IBOutlet UIButton *ThursdayLabel;
@property ( nonatomic) IBOutlet UIButton *FridayLabel;
@property ( nonatomic) IBOutlet UIButton *SaturdayLabel;
@property ( nonatomic) IBOutlet UIDatePicker *timeSelector;
@property ( nonatomic) UIPickerView *alarmPicker;
@property ( nonatomic) NSArray *alarms;
@property ( nonatomic) NSString *alarmSound;
@property ( nonatomic) IBOutlet UITextField *minutesOfMusicText;
@property ( nonatomic) IBOutlet UIStepper *minutesOfMusicSpinner;
#pragma mark Actions
- (IBAction)selectAlarmPressed:(id)sender;
- (IBAction)backPressed:(id)sender;
- (IBAction)dayPressed:(id)sender;
- (IBAction)minutesOfMusicChanged:(id)sender;

#pragma mark Methods
-(id)initWithDelegate:(id<DataChanged>)delegate;
- (IBAction)minutesSpinnerChanged:(id)sender;
@end
