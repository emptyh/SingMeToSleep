//
//  ConfigScreen_iPad.h
//  SingMeToSleep
//
//  Created by Mike Hickman on 10/21/11.
//  Copyright (c) 2011 Hobsons. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataChanged.h"

@interface ConfigScreen_iPad : UIViewController
- (IBAction)minutesChanged:(id)sender;
- (IBAction)backPressed:(id)sender;
@property (retain, nonatomic) IBOutlet UITextField *minutesOfMusic;
@property (retain, nonatomic)id<DataChanged>delegate;
-(id)initWithDelegate:(id<DataChanged>)delegate;
@end
