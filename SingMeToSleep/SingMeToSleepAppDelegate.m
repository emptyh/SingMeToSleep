//
//  SingMeToSleepAppDelegate.m
//  SingMeToSleep
//
//  Created by Mike Hickman on 10/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SingMeToSleepAppDelegate.h"
#import "SingMeToSleepAppDelegate_iPad.h"
#import "SingMeToSleepAppDelegate_iPhone.h"
#import "ClockController_ipad.h"
#import "ClockController_iphone.h"

@implementation SingMeToSleepAppDelegate
#pragma mark - Properties
@synthesize window = _window;



#pragma mark -App Life Cycle
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [self.window makeKeyAndVisible];
    //put device check here
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        ClockController_ipad *clock=[[ClockController_ipad alloc]initWithNibName:nil bundle:nil];
        [[self window]addSubview:[clock view]];
    }else{
        ClockController_iphone *clock=[[ClockController_iphone alloc]initWithNibName:nil bundle:nil];
        [[self window]addSubview:[clock view]];
    }
    

    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

- (void)dealloc
{
    [_window release];
    [super dealloc];
}



@end
