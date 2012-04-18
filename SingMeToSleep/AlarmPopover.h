//
//  AlarmPopover.h
//  SingMeToSleep
//
//  Created by Mike Hickman on 4/18/12.
//  Copyright (c) 2012 Hobsons. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "ConfigScreen.h"

@interface AlarmPopover : UIViewController<UIPickerViewDelegate>
- (IBAction)donePressed:(id)sender;
@property (retain, nonatomic) IBOutlet UIPickerView *alarmPicker;
@property (retain, nonatomic) NSArray *alarms;
@property (retain, nonatomic) AVPlayer *audioPlayer;
@property (retain, nonatomic) ConfigScreen *delegate;
@end
