//
//  HSUStack.h
//  SingMeToSleep
//
//  Created by Mike Hickman on 10/18/11.
//  Copyright (c) 2011 EmptyH Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HSUStack : NSObject{
    NSMutableArray* m_array;
    int count;
}
- (void)push:(id)anObject;
- (id)pop;
- (void)clear;
- (BOOL)containsString:string;
@property (nonatomic, readonly) int count;
@end
