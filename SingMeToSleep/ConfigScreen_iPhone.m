//
//  ConfigScreen_iPhone.m
//  SingMeToSleep
//
//  Created by Mike Hickman on 4/13/12.
//  Copyright (c) 2012 Hobsons. All rights reserved.
//

#import "ConfigScreen_iPhone.h"



@implementation ConfigScreen_iPhone



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad{
    [self setTimeSelector:[[UIDatePicker alloc]init]];
    [[self timeSelector]setDatePickerMode:UIDatePickerModeTime];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (IBAction)setTimePressed:(id)sender {
    UIActionSheet *popupQuery = [[UIActionSheet alloc] 
                                 initWithTitle:@"User Type" 
                                 delegate:self 
                                 cancelButtonTitle:nil 
                                 destructiveButtonTitle:@"Cancel" 
                                 otherButtonTitles:@"Done", nil];
    
    popupQuery.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    
    
    [popupQuery showInView:self.view];
    [popupQuery setFrame:CGRectMake(0,115,320, 680)];
    [popupQuery addSubview:[self timeSelector]];
    [[self timeSelector] setFrame:CGRectMake(0, 150,320,300)];
    [popupQuery release];
}
@end
