//
//  DataChanged.h
//  SingMeToSleep
//
//  Created by Mike Hickman on 10/21/11.
//  Copyright (c) 2011 EmptyH Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DataChanged <NSObject>
-(void)dataDidChange:(NSString*)source withValue:(NSString*)value;
@end
