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
}

- (IBAction)doWork:(id)sender;

@end
