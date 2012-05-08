//
//  HSUStack.m
//  SingMeToSleep
//
//  Created by Coud Hsu http://www.codeproject.com/script/Membership/View.aspx?mid=6010034 
//

#import "HSUStack.h"

@implementation HSUStack
@synthesize count;
- (id)init
{
    if( self=[super init] )
    {
        m_array = [[NSMutableArray alloc] init];
        count = 0;
    }
    return self;
}
-(BOOL)containsString:(id)string{
    for (NSString *element in m_array){
        if([element isEqualToString:string]){
            return YES;
        }
    }
    return NO;
}
- (void)push:(id)anObject
{
    [m_array addObject:anObject];
    count = m_array.count;
}
- (id)pop
{
    id obj = nil;
    if(m_array.count > 0)
    {
        obj = [m_array lastObject];
        [m_array removeLastObject];
        count = m_array.count;
    }
    return obj;
}
- (void)clear
{
    [m_array removeAllObjects];
    count = 0;
}
@end
