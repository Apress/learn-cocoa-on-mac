//
//  FoundationAdditions.h
//  SlowWorker
//
//  Created by JN on 11/21/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#define DISPATCH_ON_MAIN_THREAD if(![NSThread isMainThread]) { \
[self performSelectorOnMainThread:_cmd withObject:nil waitUntilDone:NO]; \
return; }

@interface NSObject (SlowWorkerExtras)
- (NSInvocationOperation*)operationForSelector:(SEL)selector;
@end
