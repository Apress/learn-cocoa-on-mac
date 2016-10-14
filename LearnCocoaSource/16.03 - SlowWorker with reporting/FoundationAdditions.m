//
//  FoundationAdditions.m
//  SlowWorker
//
//  Created by JN on 11/21/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "FoundationAdditions.h"

@implementation NSObject (SlowWorkerExtras)
- (NSInvocationOperation*)operationForSelector:(SEL)selector {
  return [[[NSInvocationOperation alloc] initWithTarget:self 
    selector:selector object:nil] autorelease];
}
@end
