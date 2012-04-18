//
//  ConfigScreen_iPad.h
//  SingMeToSleep
//
//  Created by Mike Hickman on 10/21/11.
//  Copyright (c) 2011 EmptyH Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfigScreen.h"
#import "AlarmPopover.h"

@interface ConfigScreen_iPad : ConfigScreen{
    UIPopoverController *popoverController;
   
    AlarmPopover *alarmPopover;
}


@end
