//
//  SlowWorker_AppDelegate.h
//  SlowWorker
//
//  Created by JN on 11/21/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface SlowWorker_AppDelegate : NSObject {
  IBOutlet NSButton *startButton;
  IBOutlet NSTextView *resultsTextView;
  NSString *fetchedData;
  NSString *processedData;
  NSString *firstResult;
  NSString *secondResult;
  BOOL isWorking;
  NSInteger completed;
}

@property (retain) NSString *fetchedData;
@property (retain) NSString *processedData;
@property (retain) NSString *firstResult;
@property (retain) NSString *secondResult;  
@property (assign) BOOL isWorking;
@property (assign) NSInteger completed;

- (IBAction)doWork:(id)sender;

@end
