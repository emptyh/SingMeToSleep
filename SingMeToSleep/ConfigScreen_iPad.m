//
//  ConfigScreen_iPad.m
//  SingMeToSleep
//
//  Created by Mike Hickman on 10/21/11.
//  Copyright (c) 2011 EmptyH Software. All rights reserved.
//

#import "ConfigScreen_iPad.h"
@implementation ConfigScreen_iPad


- (IBAction)selectAlarmPressed:(id)sender {
        
        
    
    
    alarmPopover = [[AlarmPopover alloc] initWithNibName:@"AlarmPopover" bundle:nil];
    [alarmPopover setDelegate:self];
    popoverController = [[UIPopoverController alloc] initWithContentViewController:alarmPopover];
    [popoverController presentPopoverFromRect:CGRectMake(10, 300, 100, 100) inView:[self view] permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    
        
       /* UIActionSheet *popupQuery = [[UIActionSheet alloc] 
                                     initWithTitle:@"Select Alarm" 
                                     delegate:self 
                                     cancelButtonTitle:nil 
                                     destructiveButtonTitle:@"Cancel" 
                                     otherButtonTitles:@"Done", nil];
        
        popupQuery.actionSheetStyle = UIActionSheetStyleBlackOpaque;
        
        
        [popupQuery showInView:self.view];
        [popupQuery setFrame:CGRectMake(0,115,320, 680)];
        [popupQuery addSubview:[super alarmPicker]];
        [[self alarmPicker] setFrame:CGRectMake(0, 150,320,300)];
        [popupQuery release];*/
   
}
@end
