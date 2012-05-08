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
@property ( nonatomic) IBOutlet UIPickerView *alarmPicker;
@property ( nonatomic) NSArray *alarms;
@property ( nonatomic) AVPlayer *audioPlayer;
@property ( nonatomic) ConfigScreen *delegate;
@end
